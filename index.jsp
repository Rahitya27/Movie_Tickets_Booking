<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.movie.dao.MovieDAO, com.movie.model.Movie, java.util.List" %>
<%
    MovieDAO movieDAO = new MovieDAO();
    List<Movie> amcShowtimes = movieDAO.getAllMovies();
    String activeSessionUser = (String) session.getAttribute("email");
    String activeSessionRole = (String) session.getAttribute("role");
%>
<!DOCTYPE html>
<html>
<head>
    <title>TechM Movie World - Movie Times, Movie Trailers, Order Concessions</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <nav class="amc-navbar">
        <a href="index.jsp" class="amc-logo">TechM Movie<span>World</span></a>
        <div class="amc-nav-menu">
            <a href="index.jsp" class="active">Movies</a>
            <a href="#">Food & Drinks</a>
            <a href="#">MacGuffins Bar</a>
            <% if (activeSessionUser == null) { %>
                <a href="register.jsp">Join A-List</a>
                <a href="login.jsp" class="btn-amc-prime" style="padding: 8px 20px; font-size: 12px; margin-left: 20px; color: black;">Sign In</a>
            <% } else { %>
                <% if ("ADMIN".equalsIgnoreCase(activeSessionRole)) { %>
                    <a href="admin-dashboard.jsp" class="btn-amc-prime" style="padding: 8px 20px; font-size: 12px; margin-left: 20px; color: black;">Admin Console</a>
                <% } else { %>
                    <a href="user-dashboard.jsp" class="btn-amc-prime" style="padding: 8px 20px; font-size: 12px; margin-left: 20px; color: black;">My Tickets</a>
                <% } %>
            <% } %>
        </div>
    </nav>

    <!-- Visual Movie Feature Spotlight Banner -->
    <div style="background: linear-gradient(rgba(0,0,0,0.1), var(--amc-black)), url('https://images.unsplash.com/photo-1517604931442-7e0c8ed2963c?q=80&w=1600') center/cover; padding: 100px 0; text-align: center;">
        <div class="container">
            <span style="letter-spacing: 3px; font-size: 12px; font-weight: 700; color: var(--amc-gold); text-transform: uppercase; display: block; margin-bottom: 15px;">Welcome to TechM Movie World</span>
            <h1 style="font-size: 46px; font-weight: 800; margin: 0 0 15px 0; text-transform: uppercase; letter-spacing: -1px;">Movies In Their Best Form</h1>
            <p style="color: var(--text-muted); max-width: 600px; margin: 0 auto; font-size: 16px; line-height: 1.6;">Experience crisp projection, premium sound engineering pipelines, and plush recliners at TechM Movie World near you.</p>
        </div>
    </div>

    <div class="container">
        <h2 class="headline-badge">Now Showing At TechM Movie World</h2>
        
        <% if (amcShowtimes.isEmpty()) { %>
            <div class="glass-container" style="text-align: center; padding: 50px;">
                <p style="color: var(--text-muted); margin: 0; font-size: 15px;">No dynamic movies are scheduled for screening right now. Please log in as administrator to populate the active auditorium catalog lines.</p>
                <a href="login.jsp" class="btn-amc-prime" style="margin-top: 25px; color: black;">Admin System Login</a>
            </div>
        <% } else { %>
            <div class="amc-grid">
                <% 
                   int counter = 0;
                   String[] backgrounds = {
                       "linear-gradient(135deg, #1e1f29 0%, #0c0d14 100%)",
                       "linear-gradient(135deg, #2a1414 0%, #0a0505 100%)",
                       "linear-gradient(135deg, #11221b 0%, #040a07 100%)"
                   };
                   for (Movie m : amcShowtimes) { 
                       String grad = backgrounds[counter % backgrounds.length];
                       counter++;
                %>
                <div class="movie-card-obsidian">
                    <div class="poster-viewport" style="background: <%= grad %>;">
                        <%= m.getTitle().toUpperCase() %>
                    </div>
                    <div class="movie-body-panel">
                        <h3 class="movie-title-text"><%= m.getTitle() %></h3>
                        <div class="movie-info-tags">Genre: <%= m.getGenre() %></div>
                        <div style="background: rgba(255,255,255,0.02); padding: 12px; border-radius: 8px; font-size: 12px; line-height: 1.6; margin-bottom: 20px; border: 1px solid var(--glass-border);">
                            🗓️ Release: <strong style="color:white;"><%= m.getReleaseDate() %></strong><br>
                            ⚡ Booking Ends: <span style="color: var(--amc-gold); font-weight:600;"><%= m.getBookingEnd() %></span>
                        </div>
                        <a href="login.jsp" class="btn-amc-prime" style="width: 100%; box-sizing: border-box; color: black;">Get Tickets</a>
                    </div>
                </div>
                <% } %>
            </div>
        <% } %>
    </div>

</body>
</html>