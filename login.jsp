<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login - CineBook</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container" style="max-width: 400px; margin-top: 100px;">
        <div class="card">
            <h2>Login</h2>
            <%
                // Basic demo routing login validation
                String user = request.getParameter("username");
                String pass = request.getParameter("password");
                if(user != null && pass != null) {
                    session.setAttribute("username", user);
                    if(user.equalsIgnoreCase("admin")) {
                        response.sendRedirect("admin-dashboard.jsp");
                    } else {
                        response.sendRedirect("user-dashboard.jsp");
                    }
                }
            %>
            <!-- Form points directly to the servlet now -->
				<form method="POST" action="LoginServlet">
                <div class="form-group">
                    <label>Username (Type 'admin' or 'user')</label>
                    <input type="text" name="username" required>
                </div>
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" required>
                </div>
                <button type="submit" class="btn">Sign In</button>
            </form>
        </div>
    </div>
</body>
</html>