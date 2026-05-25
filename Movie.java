package com.movie.model;

import java.sql.Date;

public class Movie {
    private int id;
    private String title;
    private String genre;
    private Date releaseDate;
    private Date bookingStart;
    private Date bookingEnd;

    public Movie(int id, String title, String genre, Date releaseDate, Date bookingStart, Date bookingEnd) {
        this.id = id;
        this.title = title;
        this.genre = genre;
        this.releaseDate = releaseDate;
        this.bookingStart = bookingStart;
        this.bookingEnd = bookingEnd;
    }

    public int getId() { return id; }
    public String getTitle() { return title; }
    public String getGenre() { return genre; }
    public Date getReleaseDate() { return releaseDate; }
    public Date getBookingStart() { return bookingStart; }
    public Date getBookingEnd() { return bookingEnd; }
}