package dao;

import sewaalatcamping.User;
import java.sql.*;

public class UserAdminDAO {
    private Connection conn;

    public UserAdminDAO(Connection conn) {
        this.conn = conn;
    }

    public boolean login(String username, String password) throws SQLException {
        String sql = "SELECT * FROM user WHERE username = ? AND password = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, username);
        stmt.setString(2, password);
        ResultSet rs = stmt.executeQuery();

        boolean success = rs.next();
        rs.close();
        stmt.close();

        return success;
    }
}
