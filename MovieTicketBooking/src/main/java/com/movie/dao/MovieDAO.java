package com.movie.dao;

import com.movie.config.DBConnection;
import com.movie.model.Movie;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MovieDAO {

    public void addMovie(String title, String genre, String releaseDate, String bookingStart, String bookingEnd, String imageUrl) {
        String sql = "INSERT INTO movies (title, genre, release_date, booking_start, booking_end, image_url) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, title);
            ps.setString(2, genre);
            ps.setDate(3, Date.valueOf(releaseDate));
            ps.setDate(4, Date.valueOf(bookingStart));
            ps.setDate(5, Date.valueOf(bookingEnd));
            
            // Check if input is empty, if so, supply a fallback string to the column row
            if (imageUrl == null || imageUrl.trim().isEmpty()) {
                ps.setString(6, "https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?q=80&w=500");
            } else {
                ps.setString(6, imageUrl.trim());
            }
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Movie> getAllMovies() {
        List<Movie> list = new ArrayList<>();
        String sql = "SELECT id, title, genre, release_date, booking_start, booking_end, image_url FROM movies ORDER BY release_date ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                // Explicitly pull via SQL table column labels
                int id = rs.getInt("id");
                String title = rs.getString("title");
                String genre = rs.getString("genre");
                Date release = rs.getDate("release_date");
                Date start = rs.getDate("booking_start");
                Date end = rs.getDate("booking_end");
                String imgUrl = rs.getString("image_url");

                // Construct model with the live database image link string
                list.add(new Movie(id, title, genre, release, start, end, imgUrl));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}