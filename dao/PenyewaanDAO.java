package dao;

import sewaalatcamping.Penyewaan;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PenyewaanDAO {
    private Connection conn;

    public PenyewaanDAO(Connection conn) {
        this.conn = conn;
    }

    public void insert(Penyewaan p) throws SQLException {
        String sql = "INSERT INTO penyewaan (id_pelanggan, tanggal_sewa, tanggal_kembali, status) VALUES (?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, p.getIdPelanggan());
        stmt.setDate(2, p.getTanggalSewa());
        stmt.setDate(3, p.getTanggalKembali());
        stmt.setString(4, p.getStatus());
        stmt.executeUpdate();
        stmt.close();
    }

    public List<Penyewaan> getAll() throws SQLException {
        List<Penyewaan> list = new ArrayList<>();
        String sql = "SELECT * FROM penyewaan";
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);

        while (rs.next()) {
            Penyewaan p = new Penyewaan(
                rs.getInt("id"),
                rs.getInt("id_pelanggan"),
                rs.getDate("tanggal_sewa"),
                rs.getDate("tanggal_kembali"),
                rs.getString("status")
            );
            list.add(p);
        }

        rs.close();
        stmt.close();
        return list;
    }

    public Penyewaan getById(int id) throws SQLException {
        String sql = "SELECT * FROM penyewaan WHERE id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            Penyewaan p = new Penyewaan(
                rs.getInt("id"),
                rs.getInt("id_pelanggan"),
                rs.getDate("tanggal_sewa"),
                rs.getDate("tanggal_kembali"),
                rs.getString("status")
            );
            rs.close();
            stmt.close();
            return p;
        }

        rs.close();
        stmt.close();
        return null;
    }

    public void updateStatus(int id, String status) throws SQLException {
        String sql = "UPDATE penyewaan SET status = ? WHERE id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, status);
        stmt.setInt(2, id);
        stmt.executeUpdate();
        stmt.close();
    }
}
