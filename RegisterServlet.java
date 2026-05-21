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
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        boolean isSuccess = userDAO.registerUser(username, password);
        
        if (isSuccess) {
            // Redirect directly to login on smooth user creation
            response.sendRedirect("login.jsp?signup=success");
        } else {
            // Bounce back to register if the username is taken or a DB failure occurs
            response.sendRedirect("register.jsp?error=failed");
        }
    }
}