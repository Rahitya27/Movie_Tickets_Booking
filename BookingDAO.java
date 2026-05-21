package com.movie.dao;

import com.movie.config.DBConnection;
import com.movie.model.Booking;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    public void createBooking(String username, String movieName, int seats) {
        String sql = "INSERT INTO bookings (username, movie_name, seats) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, movieName);
            ps.setInt(3, seats);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Booking> getBookingsByUser(String username) {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT * FROM bookings WHERE username = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Booking(rs.getInt("id"), rs.getString("username"), 
                        rs.getString("movie_name"), rs.getInt("seats")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Booking> getAllBookings() {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT * FROM bookings";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Booking(rs.getInt("id"), rs.getString("username"), 
                        rs.getString("movie_name"), rs.getInt("seats")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}