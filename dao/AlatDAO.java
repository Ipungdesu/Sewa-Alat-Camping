package dao;

import sewaalatcamping.Alat;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AlatDAO {
    private Connection conn;

    public AlatDAO(Connection conn) {
        this.conn = conn;
    }

    public void insert(Alat alat) throws SQLException {
        String sql = "INSERT INTO alat (nama_alat, id_kategori_alat, stok, harga_sewa_perhari) VALUES (?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, alat.getNama());
        stmt.setInt(2, alat.getIdKategori());
        stmt.setInt(3, alat.getStok());
        stmt.setDouble(4, alat.getHargaSewa());
        stmt.executeUpdate();
        stmt.close();
    }

    public List<Alat> getAll() throws SQLException {
        List<Alat> list = new ArrayList<>();
        String sql = "SELECT * FROM alat";
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);

        while (rs.next()) {
            Alat a = new Alat(
                rs.getInt("id"),
                rs.getString("nama_alat"),
                rs.getInt("id_kategori_alat"),
                rs.getInt("stok"),
                rs.getDouble("harga_sewa_perhari")
            );
            list.add(a);
        }

        rs.close();
        stmt.close();
        return list;
    }

    public Alat getById(int id) throws SQLException {
        String sql = "SELECT * FROM alat WHERE id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();
        Alat alat = null;

        if (rs.next()) {
            alat = new Alat(
                rs.getInt("id"),
                rs.getString("nama_alat"),
                rs.getInt("id_kategori_alat"),
                rs.getInt("stok"),
                rs.getDouble("harga_sewa_perhari")
            );
        }

        rs.close();
        stmt.close();
        return alat;
    }

    public void updateStok(int idAlat, int newStok) throws SQLException {
        String sql = "UPDATE alat SET stok = ? WHERE id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, newStok);
        stmt.setInt(2, idAlat);
        stmt.executeUpdate();
        stmt.close();
    }
}
