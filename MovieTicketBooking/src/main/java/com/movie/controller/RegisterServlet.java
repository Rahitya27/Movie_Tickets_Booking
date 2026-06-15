package com.movie.controller;

import com.movie.dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO = new UserDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Extract complete dynamic form payload arrays
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String mobileNumber = request.getParameter("mobile_number");
        String role = request.getParameter("role");
        
        boolean isSuccess = userDAO.registerCategorizedUser(name, email, password, mobileNumber, role);
        
        if (isSuccess) {
            response.sendRedirect("login.jsp?signup=success");
        } else {
            response.sendRedirect("register.jsp?error=failed");
        }
    }
}