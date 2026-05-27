<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Create Account - TechM Movie World</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>

    <div class="container" style="max-width: 460px; margin-top: 60px;">
        <div class="glass-container">
            <h2 style="text-align: center; margin-top:0; font-weight: 800; font-size: 26px; letter-spacing: 0.5px; color: var(--text-pure);">
                TechM Movie World<span>THEATRES</span>
            </h2>
            <p style="text-align: center; color: var(--text-muted); font-size: 13px; margin-bottom: 30px;">
                Create your unified workspace credential account profile
            </p>
            
            <% if("failed".equals(request.getParameter("error"))) { %>
                <div style="background: rgba(239, 68, 68, 0.1); border: 1px solid #ef4444; color: #ef4444; padding: 12px; border-radius: 8px; text-align: center; font-size: 13px; margin-bottom: 20px; font-weight:600;">
                    Email already registered or server constraint occurred!
                </div>
            <% } %>

            <form method="POST" action="RegisterServlet">
                <div class="form-group-block">
                    <label>Full Name</label>
                    <input type="text" name="name" placeholder="John Doe" required>
                </div>
                
                <div class="form-group-block">
                    <label>Email Address</label>
                    <input type="email" name="email" placeholder="john@domain.com" required>
                </div>

                <div class="form-group-block">
                    <label>Mobile Number</label>
                    <input type="tel" name="mobile_number" placeholder="9876543210" pattern="[0-9]{10,15}" required>
                </div>
                
                <div class="form-group-block">
                    <label>Security Password</label>
                    <input type="password" name="password" placeholder="••••••••" required>
                </div>

                <div class="form-group-block">
                    <label>Account Category Type</label>
                    <select name="role" required>
                        <option value="USER">User</option>
                        <option value="ADMIN">Administrator</option>
                    </select>
                </div>

                <button type="submit" class="btn-amc-prime" style="width: 100%; margin-top: 20px; padding: 14px;">Complete Registration</button>
            </form>
            
            <p style="margin-top: 25px; text-align: center; font-size: 14px; color: var(--text-muted);">
                Already have an account? <a href="login.jsp" style="color: var(--amc-gold); font-weight:600; text-decoration:none;">Login here</a>
            </p>
        </div>
    </div>

</body>
</html>