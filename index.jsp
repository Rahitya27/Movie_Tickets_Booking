<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>CineBook - Home</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <nav class="navbar">
        <a href="index.jsp" class="logo">CineBook</a>
        <div class="nav-links">
            <a href="login.jsp">Login</a>
        </div>
    </nav>
    <div class="container">
        <h2>Now Showing</h2>
        <div class="card-grid">
            <div class="card">
                <h3>Inception</h3>
                <p>Genre: Sci-Fi</p>
                <a href="login.jsp" class="btn">Book Tickets</a>
            </div>
            <div class="card">
                <h3>The Dark Knight</h3>
                <p>Genre: Action</p>
                <a href="login.jsp" class="btn">Book Tickets</a>
            </div>
        </div>
    </div>
</body>
</html>