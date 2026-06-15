package com.movie.dao;

import com.movie.config.DBConnection;
import java.sql.*;

public class UserDAO {

    /**
     * Registers a categorized user (USER or ADMIN) into the database.
     * Implements an atomic transaction across multiple profile tables.
     * * @param name         Full name of the user or admin
     * @param email        Unique registration email address
     * @param password     Plain text password
     * @param mobileNumber Contact mobile number
     * @param role         Account type selection ("USER" or "ADMIN")
     * @return boolean     True if the entire registration completes successfully
     */
    public boolean registerCategorizedUser(String name, String email, String password, String mobileNumber, String role) {
        String insertUserSQL = "INSERT INTO users (email, password, role) VALUES (?, ?, ?)";
        String insertUserProfileSQL = "INSERT INTO user_profiles (user_id, name, mobile_number) VALUES (?, ?, ?)";
        String insertAdminProfileSQL = "INSERT INTO admin_profiles (admin_id, name, mobile_number) VALUES (?, ?, ?)";
        
        Connection conn = null;
        PreparedStatement psUser = null;
        PreparedStatement psProfile = null;
        
        try {
            conn = DBConnection.getConnection();
            if (conn == null) {
                System.err.println("UserDAO Error: Database connection is null.");
                return false;
            }
            
            // Turn off auto-commit to manage multi-table inserts under a single transaction
            conn.setAutoCommit(false); 

            // Sanitize input data to force consistency
            String cleanRole = (role == null) ? "USER" : role.trim().toUpperCase();
            String cleanEmail = (email == null) ? "" : email.trim().toLowerCase();

            // 1. Insert credentials into base authentication table
            psUser = conn.prepareStatement(insertUserSQL, Statement.RETURN_GENERATED_KEYS);
            psUser.setString(1, cleanEmail);
            psUser.setString(2, password);
            psUser.setString(3, cleanRole);
            psUser.executeUpdate();

            // 2. Extract the auto-generated primary key ID
            ResultSet generatedKeys = psUser.getGeneratedKeys();
            int newUserId = 0;
            if (generatedKeys.next()) {
                newUserId = generatedKeys.getInt(1);
            } else {
                throw new SQLException("User creation failed; auto-generated ID could not be retrieved.");
            }

            // 3. Route structural profile metadata based on the uppercase role parameter
            if ("ADMIN".equals(cleanRole)) {
                psProfile = conn.prepareStatement(insertAdminProfileSQL);
                System.out.println("UserDAO: Inserting into admin_profiles table.");
            } else {
                psProfile = conn.prepareStatement(insertUserProfileSQL);
                System.out.println("UserDAO: Inserting into user_profiles table.");
            }
            
            psProfile.setInt(1, newUserId);
            psProfile.setString(2, name);
            psProfile.setString(3, mobileNumber);
            psProfile.executeUpdate();

            // 4. Commit transaction successfully
            conn.commit(); 
            System.out.println("UserDAO: Registration committed successfully for " + cleanEmail);
            return true;
            
        } catch (SQLException e) {
            System.err.println("UserDAO Exception: Error during registration pipeline. Executing transaction rollback.");
            e.printStackTrace();
            
            // Safe automated rollback to keep tables clean
            if (conn != null) {
                try {
                    conn.rollback();
                    System.err.println("UserDAO Status: Transaction safely rolled back.");
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            return false;
        } finally {
            // Resource cleanup to prevent pool leaks in Apache Tomcat
            try {
                if (psProfile != null) psProfile.close();
                if (psUser != null) psUser.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * Authenticates an identity credential profile and returns their access level role mapping block.
     * * @param email    Input login authorization email address target
     * @param password Input matching password token string string
     * @return String  The associated account role ("USER" or "ADMIN"), or null if validation fails
     */
    public String validateUser(String email, String password) {
        String sql = "SELECT role FROM users WHERE email = ? AND password = ?";
        String cleanEmail = (email == null) ? "" : email.trim().toLowerCase();
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, cleanEmail);
            ps.setString(2, password);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String role = rs.getString("role");
                    return (role != null) ? role.trim().toUpperCase() : null;
                }
            }
        } catch (SQLException e) {
            System.err.println("UserDAO Exception: Error processing authentication check.");
            e.printStackTrace();
        }
        return null;
    }
}