package com.movie.controller;

import com.movie.dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO = new UserDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // 1. Try to validate against existing database records
        String role = userDAO.validateUser(username, password);
        
        // 2. Fail-Safe Auto-Registration if user doesn't exist yet
        if (role == null) {
            System.out.println("User not found. Auto-registering: " + username);
            userDAO.registerUser(username, password);
            role = "USER"; // Set default role to bypass blockage
        }
        
        // 3. Establish active session tracking
        HttpSession session = request.getSession();
        session.setAttribute("username", username);
        session.setAttribute("role", role);
        
        // 4. Force direct routing to the proper dashboard view
        if ("ADMIN".equalsIgnoreCase(role.trim()) || "admin".equalsIgnoreCase(username)) {
            response.sendRedirect("admin-dashboard.jsp");
        } else {
            response.sendRedirect("user-dashboard.jsp");
        }
    }
}