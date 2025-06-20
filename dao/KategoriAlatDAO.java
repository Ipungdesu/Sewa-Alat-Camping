package dao;

import sewaalatcamping.KategoriAlat;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class KategoriAlatDAO {
    private Connection conn;

    public KategoriAlatDAO(Connection conn) {
        this.conn = conn;
    }

    public void insert(KategoriAlat kategori) throws SQLException {
        String sql = "INSERT INTO kategori_alat (nama_kategori) VALUES (?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, kategori.getNama());
        stmt.executeUpdate();
        stmt.close();
    }

    public List<KategoriAlat> getAll() throws SQLException {
        List<KategoriAlat> list = new ArrayList<>();
        String sql = "SELECT * FROM kategori_alat";
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);

        while (rs.next()) {
            KategoriAlat k = new KategoriAlat(rs.getInt("id"), rs.getString("nama_kategori"));
            list.add(k);
        }

        rs.close();
        stmt.close();
        return list;
    }

    public KategoriAlat getById(int id) throws SQLException {
        String sql = "SELECT * FROM kategori_alat WHERE id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            KategoriAlat k = new KategoriAlat(rs.getInt("id"), rs.getString("nama_kategori"));
            rs.close();
            stmt.close();
            return k;
        }

        rs.close();
        stmt.close();
        return null;
    }
}
