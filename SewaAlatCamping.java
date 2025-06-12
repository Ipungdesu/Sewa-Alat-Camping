package sewaalatcamping;

import dao.UserAdminDAO;
import java.sql.Connection;
import java.util.Scanner;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;

public class SewaAlatCamping {
    public static void main(String[] args) {
        try (Connection conn = DBConnection.getConnection()) {
            Scanner scanner = new Scanner(System.in);
            UserAdminDAO adminDAO = new UserAdminDAO(conn);

            System.out.println("===== LOGIN ADMIN =====");
            System.out.print("Username: ");
            String username = scanner.nextLine();
            System.out.print("Password: ");
            String password = scanner.nextLine();

            if (adminDAO.login(username, password)) {
                boolean running = true;
                while (running) {
                    System.out.println("\n=== MENU UTAMA ===");
                    System.out.println("1. Tambah Pelanggan");
                    System.out.println("2. Lihat Daftar Alat");
                    System.out.println("3. Sewa Alat");
                    System.out.println("4. Kembalikan Alat");
                    System.out.println("5. Keluar");
                    System.out.print("Pilih menu: ");
                    int pilihan = Integer.parseInt(scanner.nextLine());

                    switch (pilihan) {
                        case 1:
                            tambahPelanggan(conn, scanner);
                            break;
                        case 2:
                            lihatAlat(conn);
                            break;
                        case 3:
                            sewaAlat(conn, scanner);
                            break;
                        case 4:
                            kembalikanAlat(conn, scanner);
                            break;
                        case 5:
                            running = false;
                            System.out.println("Keluar dari sistem...");
                            break;
                        default:
                            System.out.println("Pilihan tidak valid.");
                    }
                }

            } else {
                System.out.println("Login gagal. Username atau password salah.");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    private static void tambahPelanggan(Connection conn, Scanner scanner) {
        try {
            System.out.print("Nama pelanggan: ");
            String nama = scanner.nextLine();
            System.out.print("Nomor telepon: ");
            String telp = scanner.nextLine();
            System.out.print("Alamat: ");
            String alamat = scanner.nextLine();
            System.out.print("Email: ");
            String email = scanner.nextLine();

            String sql = "INSERT INTO pelanggan (nama, no_hp, alamat, email) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, nama);
            stmt.setString(2, telp);
            stmt.setString(3, alamat);
            stmt.setString(4, email);
            stmt.executeUpdate();

            System.out.println("Pelanggan berhasil ditambahkan.");
            stmt.close();
        } catch (SQLException e) {
            System.out.println("Gagal menambahkan pelanggan: " + e.getMessage());
        }
    }
    private static void lihatAlat(Connection conn) {
        try {
            String sql = "SELECT * FROM alat";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            System.out.println("\n=== DAFTAR ALAT ===");
            while (rs.next()) {
                System.out.println(rs.getInt("id_alat") + ". " +
                    rs.getString("nama_alat") + " | Stok: " + rs.getInt("stok"));
            }

            rs.close();
            stmt.close();
        } catch (SQLException e) {
            System.out.println("Gagal mengambil data alat: " + e.getMessage());
        }
    }
    
    private static void sewaAlat(Connection conn, Scanner scanner) {
        try {
            // Pilih pelanggan
            System.out.print("ID Pelanggan: ");
            int idPelanggan = Integer.parseInt(scanner.nextLine());

            // Input tanggal sewa dan durasi
            System.out.print("Tanggal sewa (YYYY-MM-DD): ");
            String tglSewa = scanner.nextLine();
            System.out.print("Durasi sewa (hari): ");
            int durasi = Integer.parseInt(scanner.nextLine());

            // Hitung tanggal pengembalian otomatis (sementara pakai SQL DATE_ADD)
            String tglKembaliQuery = "SELECT DATE_ADD(?, INTERVAL ? DAY) AS tgl_pengembalian";
            PreparedStatement psTglKembali = conn.prepareStatement(tglKembaliQuery);
            psTglKembali.setString(1, tglSewa);
            psTglKembali.setInt(2, durasi);
            ResultSet rsKembali = psTglKembali.executeQuery();

            String tglPengembalian = "";
            if (rsKembali.next()) {
                tglPengembalian = rsKembali.getString("tgl_pengembalian");
            }
            rsKembali.close();
            psTglKembali.close();

            // Insert ke tabel penyewaan
            String insertPenyewaan = "INSERT INTO penyewaan (id_pelanggan, tgl_penyewaan, tgl_pengembalian, total_biaya, status, jml_denda) VALUES (?, ?, ?, ?, 'disewa', 0)";
            PreparedStatement psPenyewaan = conn.prepareStatement(insertPenyewaan, Statement.RETURN_GENERATED_KEYS);
            psPenyewaan.setInt(1, idPelanggan);
            psPenyewaan.setString(2, tglSewa);
            psPenyewaan.setString(3, tglPengembalian);
            psPenyewaan.setInt(4, 0); // total_biaya akan dihitung nanti
            psPenyewaan.executeUpdate();

            // Ambil ID penyewaan yang baru dibuat
            ResultSet generatedKeys = psPenyewaan.getGeneratedKeys();
            int idPenyewaan = 0;
            if (generatedKeys.next()) {
                idPenyewaan = generatedKeys.getInt(1);
            }

            int totalBiaya = 0;

            // Tambah alat ke detail penyewaan
            boolean tambahLagi = true;
            while (tambahLagi) {
                System.out.print("ID Alat: ");
                int idAlat = Integer.parseInt(scanner.nextLine());
                System.out.print("Jumlah: ");
                int jumlah = Integer.parseInt(scanner.nextLine());

                // Ambil harga sewa alat
                String sqlHarga = "SELECT harga_sewa_perhari FROM alat WHERE id_alat = ?";
                PreparedStatement psHarga = conn.prepareStatement(sqlHarga);
                psHarga.setInt(1, idAlat);
                ResultSet rsHarga = psHarga.executeQuery();
                int hargaSewa = 0;
                if (rsHarga.next()) {
                    hargaSewa = rsHarga.getInt("harga_sewa_perhari");
                }
                rsHarga.close();
                psHarga.close();

                int subtotal = hargaSewa * jumlah * durasi;
                totalBiaya += subtotal;

                // Kurangi stok
                String updateStok = "UPDATE alat SET stok = stok - ? WHERE id_alat = ?";
                PreparedStatement psStok = conn.prepareStatement(updateStok);
                psStok.setInt(1, jumlah);
                psStok.setInt(2, idAlat);
                psStok.executeUpdate();
                psStok.close();

                // Insert ke detail
                String insertDetail = "INSERT INTO detail_penyewaan (id_penyewaan, id_alat, jumlah) VALUES (?, ?, ?)";
                PreparedStatement psDetail = conn.prepareStatement(insertDetail);
                psDetail.setInt(1, idPenyewaan);
                psDetail.setInt(2, idAlat);
                psDetail.setInt(3, jumlah);
                psDetail.executeUpdate();
                psDetail.close();

                System.out.print("Tambah alat lain? (y/n): ");
                String jawaban = scanner.nextLine();
                if (!jawaban.equalsIgnoreCase("y")) {
                    tambahLagi = false;
                }
            }

            // Update total biaya di tabel penyewaan
            String updateTotal = "UPDATE penyewaan SET total_biaya = ? WHERE id_penyewaan = ?";
            PreparedStatement psUpdateTotal = conn.prepareStatement(updateTotal);
            psUpdateTotal.setInt(1, totalBiaya);
            psUpdateTotal.setInt(2, idPenyewaan);
            psUpdateTotal.executeUpdate();
            psUpdateTotal.close();

            System.out.println("Sewa alat berhasil dicatat.");
            psPenyewaan.close();

        } catch (SQLException | NumberFormatException e) {
            System.out.println("Gagal menyewa alat: " + e.getMessage());
        }
    }

    private static void kembalikanAlat(Connection conn, Scanner scanner) {
        try {
            System.out.print("ID Penyewaan yang dikembalikan: ");
            int idPenyewaan = Integer.parseInt(scanner.nextLine());

            // Ambil data penyewaan
            String selectPenyewaan = "SELECT tgl_pengembalian, status FROM penyewaan WHERE id_penyewaan = ?";
            PreparedStatement psSelect = conn.prepareStatement(selectPenyewaan);
            psSelect.setInt(1, idPenyewaan);
            ResultSet rs = psSelect.executeQuery();

            if (!rs.next()) {
                System.out.println("ID penyewaan tidak ditemukan.");
                return;
            }

            String status = rs.getString("status");
            String tanggalPengembalian = rs.getString("tgl_pengembalian");
            rs.close();
            psSelect.close();

            if (!status.equals("disewa")) {
                System.out.println("Alat sudah dikembalikan sebelumnya.");
                return;
            }

            // Hitung keterlambatan
            String sqlSelisihHari = "SELECT DATEDIFF(CURDATE(), ?) AS terlambat";
            PreparedStatement psTerlambat = conn.prepareStatement(sqlSelisihHari);
            psTerlambat.setString(1, tanggalPengembalian);
            ResultSet rsTerlambat = psTerlambat.executeQuery();

            int terlambatHari = 0;
            if (rsTerlambat.next()) {
                terlambatHari = rsTerlambat.getInt("terlambat");
            }
            rsTerlambat.close();
            psTerlambat.close();

            int dendaPerHari = 10000; // misalnya 10 ribu per hari
            int totalDenda = (terlambatHari > 0) ? terlambatHari * dendaPerHari : 0;

            // Update status dan denda
            String updatePenyewaan = "UPDATE penyewaan SET status = 'dikembalikan', jml_denda = ? WHERE id_penyewaan = ?";
            PreparedStatement psUpdate = conn.prepareStatement(updatePenyewaan);
            psUpdate.setInt(1, totalDenda);
            psUpdate.setInt(2, idPenyewaan);
            psUpdate.executeUpdate();
            psUpdate.close();

            // Ambil detail penyewaan dan kembalikan stok
            String sqlDetail = "SELECT id_alat, jumlah FROM detail_penyewaan WHERE id_penyewaan = ?";
            PreparedStatement psDetail = conn.prepareStatement(sqlDetail);
            psDetail.setInt(1, idPenyewaan);
            ResultSet rsDetail = psDetail.executeQuery();

            while (rsDetail.next()) {
                int idAlat = rsDetail.getInt("id_alat");
                int jumlah = rsDetail.getInt("jumlah");

                String updateStok = "UPDATE alat SET stok = stok + ? WHERE id_alat = ?";
                PreparedStatement psStok = conn.prepareStatement(updateStok);
                psStok.setInt(1, jumlah);
                psStok.setInt(2, idAlat);
                psStok.executeUpdate();
                psStok.close();
            }

            rsDetail.close();
            psDetail.close();

            System.out.println("Pengembalian berhasil dicatat. Denda: Rp" + totalDenda);

        } catch (SQLException | NumberFormatException e) {
            System.out.println("Gagal memproses pengembalian: " + e.getMessage());
        }
    }

}
