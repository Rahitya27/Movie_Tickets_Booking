<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="com.movie.dao.MovieDAO, com.movie.dao.BookingDAO, com.movie.model.Movie, com.movie.model.Booking, java.util.List"%>
<%
    String email = (String) session.getAttribute("email");
    String role = (String) session.getAttribute("role");
    if(email == null || !"USER".equalsIgnoreCase(role)) { 
        response.sendRedirect("login.jsp"); 
        return; 
    }

    MovieDAO movieDAO = new MovieDAO();
    BookingDAO bookingDAO = new BookingDAO();

    // Catch dynamic transaction operations requests from client
    String bMovie = request.getParameter("book_movie");
    if(bMovie != null) {
        bookingDAO.createBooking(email, bMovie, 1); // Auto allocates single ticket allocation unit
        response.sendRedirect("user-dashboard.jsp");
        return;
    }

    List<Movie> dynamicShows = movieDAO.getAllMovies();
    List<Booking> customerHistory = bookingDAO.getBookingsByUser(email);
%>
<!DOCTYPE html>
<html>
<head>
<title>Customer Reservation Portal</title>
<link rel="stylesheet" href="css/style.css">
</head>
<body>
	<nav class="navbar">
		<a href="user-dashboard.jsp" class="logo">bookmy<span>show</span></a>
		<div class="nav-links">
			<span>Logged in as: <strong><%= email %></strong></span> <a
				href="login.jsp">Sign Out</a>
		</div>
	</nav>

	<div class="container">
		<h2 class="section-title">Now Showing & Upcoming Releases</h2>

		<% if(dynamicShows.isEmpty()) { %>
		<div
			style="background: white; padding: 40px; text-align: center; border-radius: 8px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05); margin-bottom: 40px;">
			<p style="color: #666; margin: 0;">The catalog is empty right
				now. Check back soon after administrators publish new titles!</p>
		</div>
		<% } else { %>
		<div class="movie-grid">
			<% for(Movie m : dynamicShows) { %>
			<div class="movie-card">
				<div class="movie-poster-placeholder">
					<%= m.getTitle().toUpperCase() %>
				</div>
				<div class="movie-info">
					<div>
						<h3 class="movie-title" style="margin-bottom: 2px;"><%= m.getTitle() %></h3>
						<div class="movie-meta" style="margin-bottom: 8px;">
							Genre:
							<%= m.getGenre() %></div>
						<div
							style="font-size: 11px; color: #555; margin-bottom: 12px; line-height: 1.4;">
							• Released: <strong><%= m.getReleaseDate() %></strong><br> •
							Booking Window: <span style="color: #137333;"><%= m.getBookingStart() %></span>
							to <span style="color: #c5221f;"><%= m.getBookingEnd() %></span>
						</div>
					</div>
					<form method="POST" action="user-dashboard.jsp">
						<input type="hidden" name="book_movie" value="<%= m.getTitle() %>">
						<button type="submit" class="btn-bms" style="width: 100%;">Instantly
							Reserve 1 Ticket</button>
					</form>
				</div>
			</div>
			<% } %>
		</div>
		<% } %>

		<h2 class="section-title">Your Confirmed Tickets</h2>
		<table class="bms-table">
			<thead>
				<tr>
					<th>Ticket ID Reference</th>
					<th>Movie Selection</th>
					<th>Seats Secured</th>
					<th>Processing Node Status</th>
				</tr>
			</thead>
			<tbody>
				<% for(Booking b : customerHistory) { %>
				<tr>
					<td>#BMS-TKT-00<%= b.getId() %></td>
					<td style="font-weight: 600;"><%= b.getMovieName() %></td>
					<td><%= b.getSeats() %> Seat(s)</td>
					<td><span class="badge badge-active">Active / Confirmed</span></td>
				</tr>
				<% } %>
			</tbody>
		</table>
	</div>
</body>
</html>