<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>TechM Movie World</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body style="background: radial-gradient(circle at center, #181922 0%, #0a0a0c 100%);">

    <div class="container" style="max-width: 440px; margin-top: 90px;">
        <div class="glass-container" style="background: #12131a; border: 1px solid rgba(255, 255, 255, 0.1); padding: 35px; border-radius: 16px;">
            
            <h2 style="text-align: center; margin-top: 0; font-weight: 800; font-size: 26px; letter-spacing: 0.5px; color: #ffffff;">
                TechM movie World <span style="color: #ffaa00; text-shadow: 0 0 25px rgba(255, 170, 0, 0.35);">THEATRES</span>
            </h2>
            <p style="text-align: center; color: #94a3b8; font-size: 13px; margin-bottom: 35px;">
                Enter your workspace verification profile details below
            </p>
            
            <% if ("invalid".equals(request.getParameter("error"))) { %>
                <div style="background: rgba(239, 68, 68, 0.1); border: 1px solid #ef4444; color: #ef4444; padding: 12px; border-radius: 8px; text-align: center; font-size: 13px; margin-bottom: 20px; font-weight:600;">
                    Invalid security credentials or node mapping error!
                </div>
            <% } %>
            <% if ("success".equals(request.getParameter("signup"))) { %>
                <div style="background: rgba(16, 185, 129, 0.1); border: 1px solid #10b981; color: #10b981; padding: 12px; border-radius: 8px; text-align: center; font-size: 13px; margin-bottom: 20px; font-weight:600;">
                    Profile initialized successfully! Sign in to continue.
                </div>
            <% } %>

            <form method="POST" action="LoginServlet">
                <div class="form-group-block" style="margin-bottom: 22px;">
                    <label style="color: #cbd5e0; display: block; font-size: 12px; font-weight: 600; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 10px;">
                        Email Address
                    </label>
                    <input type="email" name="email" required placeholder="name@domain.com" 
                           style="width: 100%; padding: 14px; background: #060608; border: 1px solid rgba(255,255,255,0.07); color: #ffffff; border-radius: 8px; box-sizing: border-box; font-size: 14px;">
                </div>
                
                <div class="form-group-block" style="margin-bottom: 22px;">
                    <label style="color: #cbd5e0; display: block; font-size: 12px; font-weight: 600; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 10px;">
                        Password
                    </label>
                    <input type="password" name="password" required placeholder="••••••••" 
                           style="width: 100%; padding: 14px; background: #060608; border: 1px solid rgba(255,255,255,0.07); color: #ffffff; border-radius: 8px; box-sizing: border-box; font-size: 14px;">
                </div>
                
                <button type="submit" class="btn-amc-prime" style="width:100%; margin-top: 15px; padding: 14px; color: #000000; font-weight: 700; background: #ffaa00; border: none; border-radius: 8px; cursor: pointer;">
                    Sign In
                </button>
            </form>
            
            <p style="text-align: center; margin-top: 25px; font-size: 14px; color: #94a3b8;">
                New to TechM Movies? <a href="register.jsp" style="color: #ffaa00; text-decoration: none; font-weight: 600;">Create an account</a>
            </p>
        </div>
    </div>

</body>
</html>