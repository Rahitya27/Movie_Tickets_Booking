<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.movie.dao.BookingDAO, com.movie.model.Booking, java.util.List" %>
<%
    String username = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");
    
    // Safety authentication block protection override
    if(username == null || (!"ADMIN".equalsIgnoreCase(role) && !"admin".equalsIgnoreCase(username))) { 
        response.sendRedirect("login.jsp"); 
        return; 
    }

    BookingDAO dao = new BookingDAO();
    List<Booking> allBookings = dao.getAllBookings();
    
    // Real-time calculation aggregates
    int totalBookings = allBookings.size();
    int totalSeatsAllocated = 0;
    for(Booking b : allBookings) {
        totalSeatsAllocated += b.getSeats();
    }
    // Simple mock metric estimation: assuming avg seat ticket value = 250 INR
    int estimatedRevenue = totalSeatsAllocated * 250;
%>
<!DOCTYPE html>
<html>
<head>
    <title>BookMyShow - Corporate Management Center</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <nav class="navbar">
        <a href="admin-dashboard.jsp" class="logo">bookmy<span>show</span> Operations</a>
        <div class="nav-links">
            <span class="badge badge-admin">System Admin Console</span>
            <a href="login.jsp">Log Out</a>
        </div>
    </nav>

    <div class="container">
        <h2 class="section-title">Operational Insights</h2>
        
        <!-- Summary Analytical Blocks -->
        <div class="stats-row">
            <div class="stat-card">
                <div style="color: #666; font-size: 14px; font-weight: 600;">Total Transactions</div>
                <div class="stat-val"><%= totalBookings %></div>
            </div>
            <div class="stat-card" style="border-left-color: #11998e;">
                <div style="color: #666; font-size: 14px; font-weight: 600;">Total Tickets Sold</div>
                <div class="stat-val"><%= totalSeatsAllocated %></div>
            </div>
            <div class="stat-card" style="border-left-color: #ff9966;">
                <div style="color: #666; font-size: 14px; font-weight: 600;">Estimated Revenue</div>
                <div class="stat-val">₹<%= estimatedRevenue %></div>
            </div>
        </div>

        <h2 class="section-title">Master Booking Transaction Logs</h2>
        <table class="bms-table">
            <thead>
                <tr>
                    <th>Ref ID</th>
                    <th>Customer Name</th>
                    <th>Movie Choice</th>
                    <th>Tickets Issued</th>
                    <th>System Processing Node</th>
                </tr>
            </thead>
            <tbody>
                <% for(Booking b : allBookings) { %>
                <tr>
                    <td>#BMS-00<%= b.getId() %></td>
                    <td style="font-weight: 600; color: #444;"><%= b.getUsername() %></td>
                    <td><%= b.getMovieName() %></td>
                    <td><%= b.getSeats() %> Tickets</td>
                    <td><span class="badge badge-confirmed" style="background: #e8f0fe; color: #1a73e8;">JDBC-Node-01</span></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>