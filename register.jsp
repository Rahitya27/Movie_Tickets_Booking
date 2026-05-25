<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Movie Ticket Booking</title>
<link rel="stylesheet" href="css/style.css">
</head>
<body style="background-color: #333545;">
	<div class="container" style="max-width: 460px; margin-top: 60px;">
		<div class="movie-card"
			style="padding: 35px; background: white; border-radius: 12px;">
			<h2
				style="text-align: center; margin-top: 0; font-weight: 800; color: #333545;">
				It's Show<span>Time</span>
			</h2>
			<p
				style="text-align: center; font-size: 14px; color: #666; margin-bottom: 25px;">Create
				your unified workspace credential account profile</p>

			<% if("failed".equals(request.getParameter("error"))) { %>
			<p
				style="color: #f84464; text-align: center; font-size: 14px; font-weight: 600;">Email
				already registered or server constraint occurred!</p>
			<% } %>

			<form method="POST" action="RegisterServlet">
				<div class="form-group">
					<label style="color: #555; font-size: 13px; font-weight: 600;">Full
						Name</label> <input type="text" name="name" placeholder="John Doe"
						style="background: #fff; color: #333; border: 1px solid #ccc;"
						required>
				</div>

				<div class="form-group" style="margin-top: 12px;">
					<label style="color: #555; font-size: 13px; font-weight: 600;">Email
						Address</label> <input type="email" name="email"
						placeholder="john@example.com"
						style="background: #fff; color: #333; border: 1px solid #ccc;"
						required>
				</div>

				<div class="form-group" style="margin-top: 12px;">
					<label style="color: #555; font-size: 13px; font-weight: 600;">Mobile
						Number</label> <input type="tel" name="mobile_number"
						placeholder="9876543210" pattern="[0-9]{10,15}"
						title="Please enter a valid mobile number (10 to 15 digits)"
						style="background: #fff; color: #333; border: 1px solid #ccc;"
						required>
				</div>

				<div class="form-group" style="margin-top: 12px;">
					<label style="color: #555; font-size: 13px; font-weight: 600;">Security
						Password</label> <input type="password" name="password"
						placeholder="••••••••"
						style="background: #fff; color: #333; border: 1px solid #ccc;"
						required>
				</div>

				<div class="form-group" style="margin-top: 12px;">
					<label style="color: #555; font-size: 13px; font-weight: 600;">Account
						Category Type</label> <select name="role"
						style="background: #fff; color: #333; border: 1px solid #ccc; width: 100%; padding: 10px; border-radius: 4px;"
						required>
						<option value="USER">User</option>
						<option value="ADMIN">Administrator</option>
					</select>
				</div>

				<button type="submit" class="btn-bms"
					style="width: 100%; margin-top: 25px; padding: 12px; font-weight: 700;">Complete
					Registration</button>
			</form>

			<p
				style="margin-top: 20px; text-align: center; font-size: 14px; color: #555;">
				Already have an identity token profile? <a href="login.jsp"
					style="color: #f84464; font-weight: 600; text-decoration: none;">Login
					here</a>
			</p>
		</div>
	</div>
</body>
</html>