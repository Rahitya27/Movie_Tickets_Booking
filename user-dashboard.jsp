<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.movie.dao.MovieDAO, com.movie.dao.BookingDAO, com.movie.model.Movie, com.movie.model.Booking, java.util.List" %>
<%
    // Security Access Gate: Ensure the session exists and the user is authorized
    String userEmail = (String) session.getAttribute("email");
    String userRole = (String) session.getAttribute("role");
    if (userEmail == null || !"USER".equalsIgnoreCase(userRole)) { 
        response.sendRedirect("login.jsp"); 
        return; 
    }

    MovieDAO movieDAO = new MovieDAO();
    BookingDAO bookingDAO = new BookingDAO();

    // Intercept client ticket placement requests
    String bookMovieTarget = request.getParameter("book_movie");
    String selectedSeatsCount = request.getParameter("seats_count");
    
    if (bookMovieTarget != null && selectedSeatsCount != null) {
        int seatsCount = Integer.parseInt(selectedSeatsCount);
        if (seatsCount > 0) {
            bookingDAO.createBooking(userEmail, bookMovieTarget, seatsCount);
            response.sendRedirect("user-dashboard.jsp?transaction=completed");
            return;
        }
    }

    // Retrieve active runtime collections from MySQL
    List<Movie> amcLiveCatalog = movieDAO.getAllMovies();
    List<Booking> userPersonalTickets = bookingDAO.getBookingsByUser(userEmail);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>TechM Movie World - Customer Dashboard</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        /* Context-Driven Visual Auditorium Grid Styles */
        .amc-auditorium-canvas {
            background: #12131a;
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 16px;
            padding: 45px;
            margin-top: 40px;
            display: none; /* Controlled dynamically via JavaScript */
            box-shadow: 0 30px 60px rgba(0,0,0,0.6);
        }
        
        .amc-imax-screen {
            width: 75%;
            height: 4px;
            background: linear-gradient(90deg, transparent 0%, #ffaa00 50%, transparent 100%);
            margin: 0 auto 50px auto;
            border-radius: 50%;
            box-shadow: 0 6px 25px rgba(255, 170, 0, 0.5);
            text-align: center;
            color: #ffaa00;
            font-size: 10px;
            letter-spacing: 4px;
            text-transform: uppercase;
            line-height: 30px;
        }
        
        .seat-matrix-grid {
            display: grid;
            grid-template-columns: repeat(10, 38px);
            gap: 12px;
            justify-content: center;
            margin-bottom: 35px;
        }
        
        .seat-matrix-grid input[type="checkbox"] { 
            display: none; 
        }
        
        .seat-matrix-grid label {
            background: #232530;
            height: 34px;
            border-radius: 6px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 11px;
            font-weight: 700;
            color: #64748b;
            transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
            border: 1px solid rgba(255,255,255,0.02);
        }
        
        .seat-matrix-grid label:hover {
            background: #333747;
            color: white;
        }
        
        .seat-matrix-grid input[type="checkbox"]:checked + label {
            background: #ffaa00;
            color: #000000;
            box-shadow: 0 0 25px rgba(255, 170, 0, 0.35);
            transform: scale(1.05);
        }
    </style>
</head>
<body>

    <nav class="amc-navbar">
        <a href="user-dashboard.jsp" class="amc-logo">TechM Movie<span>World</span></a>
        <div class="amc-nav-menu">
            <span style="color: #94a3b8; font-size: 14px;">Account: <strong style="color: #94a3b8;"><%= userEmail %></strong></span>
            <a href="login.jsp" class="btn-amc-prime" style="padding: 8px 18px; font-size: 12px; color: black; font-weight: 700; background: #ffaa00; text-decoration: none; border-radius: 8px;">Sign Out</a>
        </div>
    </nav>

    <div class="container">
        
        <% if ("completed".equals(request.getParameter("transaction"))) { %>
            <div style="background: rgba(16, 185, 129, 0.08); border: 1px solid #10b981; color: #10b981; padding: 18px; border-radius: 12px; margin-bottom: 35px; font-weight: 600; font-size: 14px;">
                ✓ Order Confirmed! Your luxury recliners have been locked and tickets issued to your Stubs wallet.
            </div>
        <% } %>

        <h2 class="headline-badge">Available Showtimes</h2>
        
        <% if (amcLiveCatalog.isEmpty()) { %>
            <div class="glass-container" style="text-align: center; color: #94a3b8; font-size: 14px;">
                No active showtimes scheduled at this theatre node. Check back later!
            </div>
        <% } else { %>
            <div class="amc-grid">
                <% for (Movie m : amcLiveCatalog) { %>
                <div class="movie-card-obsidian">
    
    <div class="poster-viewport" style="background: #000; padding: 0; overflow: hidden; height: 360px; display: flex; align-items: center; justify-content: center;">
        <%-- The Expression tag calls the exact getImageUrl() method from our database collection --%>
        <img src="<%= m.getImageUrl() %>" alt="<%= m.getTitle() %> Poster" 
             style="width: 75%; height: 100%; object-fit: cover; display: block;"
             onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?q=80&w=500';">
    </div>
    
    <div class="movie-body-panel">
        <h3 class="movie-title-text" style="color: var(--amc-gold); margin: 15px 0 8px 0; font-size: 19px;"><%= m.getTitle() %></h3>
        <div style="font-size: 13px; color: #94a3b8; margin-bottom: 20px;">Genre: <%= m.getGenre() %> • Dolby Cinema</div>
        <button class="btn-amc-prime" style="width: 100%; color: black; background: #ffaa00; border: none; padding: 12px; font-weight: 700; border-radius: 8px; cursor: pointer;" 
                onclick="launchSeatMapEngine('<%= m.getTitle() %>')">Select Seats</button>
    </div>
</div>
                <% } %>
            </div>
        <% } %>

        <div class="amc-auditorium-canvas" id="seatSelectionPanel">
            <h3 id="mapMovieHeadline" style="text-align: center; margin-top: 0; font-size: 22px; font-weight: 700; color: #ffffff;">Reserve Seats</h3>
            <div class="amc-imax-screen">SCREEN THIS WAY</div>
            
            <form method="POST" action="user-dashboard.jsp" onsubmit="return runCheckoutValidation();">
                <input type="hidden" name="book_movie" id="hiddenFormMovieField">
                <input type="hidden" name="seats_count" id="hiddenFormSeatsCountField">
                
                <div class="seat-matrix-grid">
                    <% 
                       for (int r = 1; r <= 4; r++) {
                           char rowSymbol = (char)('A' + r - 1);
                           for (int col = 1; col <= 10; col++) {
                               String uniqueCode = rowSymbol + "" + col;
                    %>
                        <input type="checkbox" id="<%= uniqueCode %>" class="auditorium-seat-checkbox" onchange="calculateLiveSeatingMetrics()">
                        <label for="<%= uniqueCode %>"><%= uniqueCode %></label>
                    <% 
                           }
                       } 
                    %>
                </div>

                <div style="text-align: center; padding-top: 30px; border-top: 1px solid rgba(255, 255, 255, 0.08);">
                    <p style="color: #94a3b8; font-size: 14px; margin-bottom: 20px;">Seats Chosen: <span id="uiMetricDisplay" style="color: #ffaa00; font-weight: 700; font-size: 20px;">0</span></p>
                    <button type="submit" class="btn-amc-prime" style="padding: 14px 60px; color: black; background: #ffaa00; border: none; font-weight: 700; border-radius: 8px; cursor: pointer; text-transform: uppercase; letter-spacing: 0.5px;">Reserve Seats</button>
                </div>
            </form>
        </div>

        <h2 class="headline-badge" style="margin-top: 65px;">Your Digital Stubs Wallet</h2>
        <% if (userPersonalTickets.isEmpty()) { %>
            <div class="glass-container" style="text-align: center; color: #94a3b8; font-size: 14px; background: #12131a; border: 1px solid rgba(255, 255, 255, 0.1); border-radius: 12px; padding: 35px;">
                No active ticket reservations found in your stubs history.
            </div>
        <% } else { %>
            <table class="amc-table" style="width: 100%; border-collapse: collapse; background: #12131a; border: 1px solid rgba(255, 255, 255, 0.1); border-radius: 12px; overflow: hidden;">
                <thead>
                    <tr style="background: #060608; border-bottom: 1px solid rgba(255, 255, 255, 0.1);">
                        <th style="padding: 16px 20px; text-align: left; color: #94a3b8; font-size: 13px; text-transform: uppercase;">Booking Reference Node</th>
                        <th style="padding: 16px 20px; text-align: left; color: #94a3b8; font-size: 13px; text-transform: uppercase;">Feature Movie Selected</th>
                        <th style="padding: 16px 20px; text-align: left; color: #94a3b8; font-size: 13px; text-transform: uppercase;">Auditorium Allocated Tickets</th>
                        <th style="padding: 16px 20px; text-align: left; color: #94a3b8; font-size: 13px; text-transform: uppercase;">Status</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Booking b : userPersonalTickets) { %>
                    <tr style="border-bottom: 1px solid rgba(255, 255, 255, 0.08);">
                        <td style="color: #ffaa00; font-weight: 600; padding: 18px 20px;">#AMC-TKT-00<%= b.getId() %></td>
                        <td style="font-weight: 700; color: white; padding: 18px 20px;"><%= b.getMovieName() %></td>
                        <td style="color: white; padding: 18px 20px;"><%= b.getSeats() %> Luxury Recliner(s) Locked</td>
                        <td style="padding: 18px 20px;"><span style="background: rgba(255,170,0,0.1); color: #ffaa00; border: 1px solid rgba(255,170,0,0.2); padding: 5px 12px; border-radius: 20px; font-size: 11px; font-weight: 700; text-transform: uppercase;">Active Pass</span></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        <% } %>
    </div>

    <script>
        function launchSeatMapEngine(movieTitle) {
            document.getElementById('hiddenFormMovieField').value = movieTitle;
            document.getElementById('mapMovieHeadline').innerText = "Select Luxury Recliners for: " + movieTitle;
            
            // Clear prior user selection checks cleanly
            document.querySelectorAll('.auditorium-seat-checkbox').forEach(box => box.checked = false);
            calculateLiveSeatingMetrics();

            // Slide display block smoothly into viewport
            var viewPanel = document.getElementById('seatSelectionPanel');
            viewPanel.style.display = 'block';
            viewPanel.scrollIntoView({ behavior: 'smooth' });
        }

        function calculateLiveSeatingMetrics() {
            var checkedSeatsCount = document.querySelectorAll('.auditorium-seat-checkbox:checked').length;
            document.getElementById('uiMetricDisplay').innerText = checkedSeatsCount;
            document.getElementById('hiddenFormSeatsCountField').value = checkedSeatsCount;
        }

        function runCheckoutValidation() {
            var finalCount = parseInt(document.getElementById('hiddenFormSeatsCountField').value || 0);
            if (finalCount <= 0) {
                alert("Please click and select your luxury recliners from the seating map layout before checking out.");
                return false;
            }
            return true;
        }
    </script>
</body>
</html>