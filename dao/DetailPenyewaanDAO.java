package dao;

import sewaalatcamping.DetailPenyewaan;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DetailPenyewaanDAO {
    private Connection conn;

    public DetailPenyewaanDAO(Connection conn) {
        this.conn = conn;
    }

    public void insert(DetailPenyewaan d) throws SQLException {
        String sql = "INSERT INTO detail_penyewaan (id_penyewaan, id_alat, jumlah, harga_perhari) VALUES (?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, d.getIdPenyewaan());
        stmt.setInt(2, d.getIdAlat());
        stmt.setInt(3, d.getJumlah());
        stmt.setDouble(4, d.getHargaPerhari());
        stmt.executeUpdate();
        stmt.close();
    }

    public List<DetailPenyewaan> getByPenyewaanId(int idPenyewaan) throws SQLException {
        List<DetailPenyewaan> list = new ArrayList<>();
        String sql = "SELECT * FROM detail_penyewaan WHERE id_penyewaan = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, idPenyewaan);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            DetailPenyewaan d = new DetailPenyewaan(
                rs.getInt("id"),
                rs.getInt("id_penyewaan"),
                rs.getInt("id_alat"),
                rs.getInt("jumlah"),
                rs.getDouble("harga_sewa_per_item")
            );
            list.add(d);
        }

        rs.close();
        stmt.close();
        return list;
    }
}
