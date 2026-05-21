<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register - CineBook</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container" style="max-width: 400px; margin-top: 100px;">
        <div class="card">
            <h2>Create Account</h2>
            
            <% if("failed".equals(request.getParameter("error"))) { %>
                <p style="color: var(--primary);">Username already taken or systemic issue. Try again.</p>
            <% } %>

            <form method="POST" action="RegisterServlet">
                <div class="form-group">
                    <label>Choose Username</label>
                    <input type="text" name="username" required>
                </div>
                <div class="form-group">
                    <label>Set Password</label>
                    <input type="password" name="password" required>
                </div>
                <button type="submit" class="btn">Register</button>
            </form>
            <p style="margin-top: 15px; font-size: 14px;">
                Already have an account? <a href="login.jsp" style="color: var(--primary);">Login here</a>
            </p>
        </div>
    </div>
</body>
</html>