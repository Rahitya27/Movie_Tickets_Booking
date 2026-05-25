package com.movie.dao;

import com.movie.config.DBConnection;
import java.sql.*;

public class UserDAO {

    public boolean registerCategorizedUser(String name, String email, String password, String mobileNumber, String role) {
        String insertUserSQL = "INSERT INTO users (email, password, role) VALUES (?, ?, ?)";
        String insertUserProfileSQL = "INSERT INTO user_profiles (user_id, name, mobile_number) VALUES (?, ?, ?)";
        String insertAdminProfileSQL = "INSERT INTO admin_profiles (user_id, name, mobile_number) VALUES (?, ?, ?)";
        
        Connection conn = null;
        PreparedStatement psUser = null;
        PreparedStatement psProfile = null;
        
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // Enable manual transaction block tracking control

            // Step 1: Insert core authentication table row record
            psUser = conn.prepareStatement(insertUserSQL, Statement.RETURN_GENERATED_KEYS);
            psUser.setString(1, email);
            psUser.setString(2, password);
            psUser.setString(3, role.toUpperCase());
            psUser.executeUpdate();

            // Fetch auto-generated user primary key ID reference allocation
            ResultSet generatedKeys = psUser.getGeneratedKeys();
            int newUserId = 0;
            if (generatedKeys.next()) {
                newUserId = generatedKeys.getInt(1);
            }

            // Step 2: Route structural registration metadata profile payload content conditionally
            if ("ADMIN".equalsIgnoreCase(role)) {
                psProfile = conn.prepareStatement(insertAdminProfileSQL);
            } else {
                psProfile = conn.prepareStatement(insertUserProfileSQL);
            }
            
            psProfile.setInt(1, newUserId);
            psProfile.setString(2, name);
            psProfile.setString(3, mobileNumber);
            psProfile.executeUpdate();

            conn.commit(); // Push all table adjustments to disk concurrently
            return true;
            
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback(); // Undo operations if a crash happens mid-execution
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (psProfile != null) psProfile.close();
                if (psUser != null) psUser.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public String validateUser(String email, String password) {
        String sql = "SELECT role FROM users WHERE email = ? AND password = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("role");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}