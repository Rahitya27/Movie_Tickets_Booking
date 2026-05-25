<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Account Sign In - Movie Ticket Booking</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body style="background-color: #333545;">
    <div class="container" style="max-width: 420px; margin-top: 100px;">
        <div class="movie-card" style="padding: 35px; background: white; border-radius: 12px;">
            <h2 style="text-align: center; margin-top:0; font-weight:800; color:#333545;">It's Show<span>Time....</span></h2>
            <p style="text-align: center; font-size: 14px; color: #666; margin-bottom: 30px;">Single portal entry for customers and administrators</p>
            
            <% if("invalid".equals(request.getParameter("error"))) { %>
                <p style="color: red; text-align: center; font-size: 14px; font-weight:600;">Incorrect Email or Password!</p>
            <% } %>

            <form method="POST" action="LoginServlet">
                <div class="form-group">
                    <label style="color:#555; font-size:13px; font-weight:600;">Account Email Address</label>
                    <input type="email" name="email" placeholder="example@cinebook.com" style="background:#fff; color:#333; border: 1px solid #ccc;" required>
                </div>
                <div class="form-group" style="margin-top:15px;">
                    <label style="color:#555; font-size:13px; font-weight:600;">Security Password</label>
                    <input type="password" name="password" placeholder="••••••••" style="background:#fff; color:#333; border: 1px solid #ccc;" required>
                </div>
                <button type="submit" class="btn-bms" style="width: 100%; margin-top: 25px; padding: 12px;">Secure Sign In</button>
            </form>
            <p style="margin-top: 20px; text-align: center; font-size: 14px; color:#555;">
    Don't have an account? <a href="register.jsp" style="color: #f84464; font-weight:600; text-decoration:none;">Register here</a>
</p>
            
            <div style="margin-top: 20px; background: #f8f9fa; padding: 10px; border-radius: 6px; font-size: 12px; color: #555;">
                <strong>Demo Logins:</strong><br>
                • Admin: <code>admin@cinebook.com</code> / <code>admin123</code><br>
                • Customer: <code>user@cinebook.com</code> / <code>user123</code>
            </div>
        </div>
    </div>
</body>
</html>