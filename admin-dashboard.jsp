<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="com.movie.dao.MovieDAO, com.movie.model.Movie, java.util.List"%>
<%
    String email = (String) session.getAttribute("email");
    String role = (String) session.getAttribute("role");
    if(email == null || !"ADMIN".equalsIgnoreCase(role)) { 
        response.sendRedirect("login.jsp"); 
        return; 
    }

    MovieDAO movieDAO = new MovieDAO();

    // Catch dynamic addition requests
    String title = request.getParameter("title");
    if(title != null) {
        movieDAO.addMovie(title, request.getParameter("genre"), 
                          request.getParameter("release_date"), 
                          request.getParameter("booking_start"), 
                          request.getParameter("booking_end"));
        response.sendRedirect("admin-dashboard.jsp");
        return;
    }

    List<Movie> managedCatalog = movieDAO.getAllMovies();
%>
<!DOCTYPE html>
<html>
<head>
<title>Admin Operations Center</title>
<link rel="stylesheet" href="css/style.css">
</head>
<body>
	<nav class="navbar">
		<span class="logo">bookmy<span>show</span> Control Unit
		</span>
		<div class="nav-links">
			<span class="badge badge-admin">Operational Administrator</span> <a
				href="login.jsp">Log Out</a>
		</div>
	</nav>

	<div class="container">
		<h2 class="section-title">Movie Releases & Booking Window
			Configuration</h2>

		<div class="admin-flex-layout">
			<!-- Left form container block configuration entry component -->
			<div class="form-card">
				<h3 style="margin-top: 0; margin-bottom: 20px; color: #333545;">Publish
					New Show</h3>
				<form method="POST" action="admin-dashboard.jsp">
					<div class="form-group">
						<label style="color: #555;">Movie Title</label> <input type="text"
							name="title"
							style="background: #fff; color: #333; border: 1px solid #ccc;"
							required>
					</div>
					<div class="form-group">
						<label style="color: #555;">Genre Description</label> <input
							type="text" name="genre"
							style="background: #fff; color: #333; border: 1px solid #ccc;"
							required>
					</div>
					<div class="form-group">
						<label style="color: #555;">Official Release Date</label> <input
							type="date" name="release_date"
							style="background: #fff; color: #333; border: 1px solid #ccc;"
							required>
					</div>
					<div class="form-group">
						<label style="color: #555;">Booking Opens On</label> <input
							type="date" name="booking_start"
							style="background: #fff; color: #333; border: 1px solid #ccc;"
							required>
					</div>
					<div class="form-group">
						<label style="color: #555;">Booking Closes On</label> <input
							type="date" name="booking_end"
							style="background: #fff; color: #333; border: 1px solid #ccc;"
							required>
					</div>
					<button type="submit" class="btn-bms"
						style="width: 100%; margin-top: 15px;">Publish to Catalog</button>
				</form>
			</div>

			<!-- Right list compilation overview table component -->
			<div style="flex-grow: 1;">
				<table class="bms-table">
					<thead>
						<tr>
							<th>Movie Title</th>
							<th>Genre</th>
							<th>Release Date</th>
							<th>Ticket Window Open</th>
							<th>Ticket Window Close</th>
						</tr>
					</thead>
					<tbody>
						<% for(Movie m : managedCatalog) { %>
						<tr>
							<td style="font-weight: 700;"><%= m.getTitle() %></td>
							<td><%= m.getGenre() %></td>
							<td><%= m.getReleaseDate() %></td>
							<td><span class="badge badge-active"><%= m.getBookingStart() %></span></td>
							<td><span class="badge badge-expired"><%= m.getBookingEnd() %></span></td>
						</tr>
						<% } %>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>