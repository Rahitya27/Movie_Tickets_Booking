<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.movie.dao.BookingDAO, com.movie.model.Booking, java.util.List" %>
<%
    String username = (String) session.getAttribute("username");
    if(username == null) { 
        response.sendRedirect("login.jsp"); 
        return; 
    }

    BookingDAO dao = new BookingDAO();
    
    // Process real-time operations
    String movie = request.getParameter("movie");
    String seatsStr = request.getParameter("seats");
    if(movie != null && seatsStr != null) {
        int seats = Integer.parseInt(seatsStr);
        dao.createBooking(username, movie, seats);
        response.sendRedirect("user-dashboard.jsp"); // Form post-redirect pattern injection
        return;
    }
    
    List<Booking> myBookings = dao.getBookingsByUser(username);
%>
<!DOCTYPE html>
<html>
<head>
    <title>BookMyShow - Dashboard</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <nav class="navbar">
        <a href="user-dashboard.jsp" class="logo">bookmy<span>show</span></a>
        <div class="nav-links">
            <span>Hi, <%= username %></span>
            <a href="login.jsp">Logout</a>
        </div>
    </nav>

    <div class="container">
        <h2 class="section-title">Recommended Movies</h2>
        
        <div class="movie-grid">
            <!-- Movie Item 1 -->
            <div class="movie-card">
                <div class="movie-poster-placeholder" style="background: linear-gradient(135deg, #f05a28 0%, #e80a89 100%);">
                    INCEPTION
                </div>
                <div class="movie-info">
                    <div>
                        <h3 class="movie-title">Inception</h3>
                        <div class="movie-meta">UA | Sci-Fi / Action | English, Hindi</div>
                    </div>
                    <form method="POST" action="user-dashboard.jsp">
                        <input type="hidden" name="movie" value="Inception">
                        <input type="hidden" name="seats" value="2">
                        <button type="submit" class="btn-bms" style="width: 100%;">Book 2 Tickets</button>
                    </form>
                </div>
            </div>

            <!-- Movie Item 2 -->
            <div class="movie-card">
                <div class="movie-poster-placeholder" style="background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);">
                    DARK KNIGHT
                </div>
                <div class="movie-info">
                    <div>
                        <h3 class="movie-title">The Dark Knight</h3>
                        <div class="movie-meta">A | Action / Drama | English</div>
                    </div>
                    <form method="POST" action="user-dashboard.jsp">
                        <input type="hidden" name="movie" value="The Dark Knight">
                        <input type="hidden" name="seats" value="1">
                        <button type="submit" class="btn-bms" style="width: 100%;">Book 1 Ticket</button>
                    </form>
                </div>
            </div>

            <!-- Movie Item 3 -->
            <div class="movie-card">
                <div class="movie-poster-placeholder" style="background: linear-gradient(135deg, #ff9966 0%, #ff5e62 100%);">
                    INTERSTELLAR
                </div>
                <div class="movie-info">
                    <div>
                        <h3 class="movie-title">Interstellar</h3>
                        <div class="movie-meta">A | Sci-Fi | English, Telugu</div>
                    </div>
                    <form method="POST" action="user-dashboard.jsp">
                        <input type="hidden" name="movie" value="Interstellar">
                        <input type="hidden" name="seats" value="3">
                        <button type="submit" class="btn-bms" style="width: 100%;">Book 3 Tickets</button>
                    </form>
                </div>
            </div>
        </div>

        <h2 class="section-title">Your Booking History</h2>
        <% if(myBookings.isEmpty()) { %>
            <div style="background: white; padding: 30px; text-align: center; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.05);">
                <p style="color: #666; margin: 0;">No active bookings found. Explore movies above to book tickets!</p>
            </div>
        <% } else { %>
            <table class="bms-table">
                <thead>
                    <tr>
                        <th>Booking Reference ID</th>
                        <th>Movie Title</th>
                        <th>Seats Confirmed</th>
                        <th>Transaction Status</th>
                    </tr>
                </thead>
                <tbody>
                    <% for(Booking b : myBookings) { %>
                    <tr>
                        <td>#BMS-00<%= b.getId() %></td>
                        <td style="font-weight: 600;"><%= b.getMovieName() %></td>
                        <td><%= b.getSeats() %> Seat(s)</td>
                        <td><span class="badge badge-confirmed">Confirmed</span></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        <% } %>
    </div>
</body>
</html>