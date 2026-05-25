package com.movie.dao;

import com.movie.config.DBConnection;
import com.movie.model.Movie;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MovieDAO {

    public void addMovie(String title, String genre, String releaseDate, String bookingStart, String bookingEnd) {
        String sql = "INSERT INTO movies (title, genre, release_date, booking_start, booking_end) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, title);
            ps.setString(2, genre);
            ps.setDate(3, Date.valueOf(releaseDate));
            ps.setDate(4, Date.valueOf(bookingStart));
            ps.setDate(5, Date.valueOf(bookingEnd));
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Movie> getAllMovies() {
        List<Movie> list = new ArrayList<>();
        String sql = "SELECT * FROM movies ORDER BY release_date ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Movie(
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getString("genre"),
                    rs.getDate("release_date"),
                    rs.getDate("booking_start"),
                    rs.getDate("booking_end")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}