package dao;

import sewaalatcamping.Pelanggan;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PelangganDAO {
    private Connection conn;

    public PelangganDAO(Connection conn) {
        this.conn = conn;
    }

    public void insert(Pelanggan p) throws SQLException {
        String sql = "INSERT INTO pelanggan (nama, alamat, no_hp, email) VALUES (?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, p.getNama());
        stmt.setString(2, p.getNoTelepon());
        stmt.setString(3, p.getAlamat());
        stmt.setString(4, p.getEmail());
        stmt.executeUpdate();
        stmt.close();
    }

    public List<Pelanggan> getAll() throws SQLException {
        List<Pelanggan> list = new ArrayList<>();
        String sql = "SELECT * FROM pelanggan";
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);

        while (rs.next()) {
            Pelanggan p = new Pelanggan(
                rs.getInt("id"),
                rs.getString("nama"),
                rs.getString("no_hp"),
                rs.getString("alamat"),
                rs.getString("email")
            );
            list.add(p);
        }

        rs.close();
        stmt.close();
        return list;
    }

    public Pelanggan getById(int id) throws SQLException {
        String sql = "SELECT * FROM pelanggan WHERE id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            Pelanggan p = new Pelanggan(
                rs.getInt("id"),
                rs.getString("nama"),
                rs.getString("no_telp"),
                rs.getString("alamat"),
                rs.getString("email")
            );
            rs.close();
            stmt.close();
            return p;
        }

        rs.close();
        stmt.close();
        return null;
    }
}
