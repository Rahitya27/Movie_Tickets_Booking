package com.movie.model;




public class Booking {
    private int id;
    private String username;
    private String movieName;
    private int seats;

    public Booking(int id, String username, String movieName, int seats) {
        this.id = id;
        this.username = username;
        this.movieName = movieName;
        this.seats = seats;
    }

    public int getId() { return id; }
    public String getUsername() { return username; }
    public String getMovieName() { return movieName; }
    public int getSeats() { return seats; }
}