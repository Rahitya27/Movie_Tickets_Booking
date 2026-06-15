<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.movie.dao.MovieDAO, com.movie.dao.BookingDAO, com.movie.model.Movie, com.movie.model.Booking, java.util.List" %>
<%
    // ... Session validation gates remain unchanged ...
    MovieDAO movieDAO = new MovieDAO();
    BookingDAO bookingDAO = new BookingDAO();

    String titleFormInput = request.getParameter("title");
    if (titleFormInput != null) {
        movieDAO.addMovie(titleFormInput, request.getParameter("genre"), 
                          request.getParameter("release_date"), 
                          request.getParameter("booking_start"), 
                          request.getParameter("booking_end"),
                          request.getParameter("image_url")); // Pass the input here
        response.sendRedirect("admin-dashboard.jsp");
        return;
    }
    List<Movie> globalManagedCatalog = movieDAO.getAllMovies();
    List<Booking> platformMasterRecords = bookingDAO.getAllBookings();
    // ... rest of calculations ...
%>
<!DOCTYPE html>
<html>
<head>
    <title>TechM Movie World - Admin Systems Console</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <nav class="amc-navbar">
        <a href="admin-dashboard.jsp" class="amc-logo">TechM Movie<span>World</span></a>
        <div class="amc-nav-menu">
            <span class="badge-pill badge-gold">HQ System Administrator</span>
            <a href="login.jsp" class="btn-amc-prime" style="padding: 8px 18px; font-size: 12px; color: black;">Sign Out</a>
        </div>
    </nav>
    <div class="container">
        <!-- Enterprise Summary Analytics Metrics Modules -->
        <h2 class="headline-badge">Operational Highlights</h2>
        <div style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 30px; margin-bottom: 50px;">
            <div class="glass-container" style="border-left: 5px solid var(--amc-gold); padding: 25px;">
                <div style="font-size: 12px; text-transform: uppercase; letter-spacing: 1px; color: var(--text-sub);">Active Programmed Titles</div>
                <div style="font-size: 36px; font-weight: 800; margin-top: 5px;"><%= globalManagedCatalog.size() %></div>
            </div>
            <div class="glass-container" style="border-left: 5px solid #10b981; padding: 25px;">
                <div style="font-size: 12px; text-transform: uppercase; letter-spacing: 1px; color: var(--text-sub);">Total Tickets Tracked</div>
                            </div>
        </div>
        <h2 class="headline-badge">Theatre Program Management Panel</h2>
        <div class="amc-split-layout">
            <div class="glass-container amc-sidebar-form">
                <h3 style="margin-top: 0; margin-bottom: 25px; font-size: 18px; text-transform: uppercase; color: var(--amc-gold);">Schedule New Show</h3>
                <form method="POST" action="admin-dashboard.jsp">
                    <div class="form-group-block">
                        <label>Movie Title</label>
                        <input type="text" name="title" required placeholder="e.g., Gladiator II">
                    </div>
                    <div class="form-group-block">
    <label>Movie Poster Image URL</label>
    <input type="url" name="image_url" placeholder="https://site.com/poster.jpg">
</div>
                    <div class="form-group-block">
                        <label>Genre Taxonomy</label>
                        <input type="text" name="genre" required placeholder="e.g., Action, Drama">
                    </div>
                    <div class="form-group-block">
                        <label>Theatre Release Date</label>
                        <input type="date" name="release_date" required>
                    </div>
                    <div class="form-group-block">
                        <label>Ticket Sales Launch Date</label>
                        <input type="date" name="booking_start" required>
                    </div>
                    <div class="form-group-block">
                        <label>Ticket Sales Close Date</label>
                        <input type="date" name="booking_end" required>
                    </div>
                    <button type="submit" class="btn-amc-prime" style="width: 100%; margin-top: 10px; color: black;">Publish Showtime</button>
                </form>
            </div>
            <div style="flex-grow: 1;">
                <% if (globalManagedCatalog.isEmpty()) { %>
                    <div class="glass-container" style="text-align: center; color: var(--text-sub); font-size: 14px;">
                        The system inventory catalog contains zero programmatic titles. Add a show via the scheduler.
                    </div>
                <% } else { %>
                    <table class="amc-table">
                        <thead>
                            <tr>
                                <th>Movie Name</th>
                                <th>Genre Description</th>
                                <th>Release Date</th>
                                <th>Window Opens</th>
                                <th>Window Closes</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Movie m : globalManagedCatalog) { %>
                            <tr>
                                <td style="font-weight: 700; color:var(--amc-gold);"><%= m.getTitle() %></td>
                                <td style="color: var(--text-sub);"><%= m.getGenre() %></td>
                                <td><%= m.getReleaseDate() %></td>
                                <td><span class="badge-pill badge-gold"><%= m.getBookingStart() %></span></td>
                                <td><span class="badge-pill badge-muted"><%= m.getBookingEnd() %></span></td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                <% } %>
            </div>

        </div>
    </div>
</body>
</html>