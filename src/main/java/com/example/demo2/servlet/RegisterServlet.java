package com.example.demo2.servlet;

import com.example.demo2.service.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "registerServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {
    
    private AuthService authService;
    
    @Override
    public void init() throws ServletException {
        authService = new AuthService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String cin = request.getParameter("cin");
        
        if (nom == null || nom.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            cin == null || cin.trim().isEmpty()) {
            
            request.setAttribute("error", "All fields are required");
            request.setAttribute("nom", nom);
            request.setAttribute("email", email);
            request.setAttribute("cin", cin);
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }
        
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            request.setAttribute("nom", nom);
            request.setAttribute("email", email);
            request.setAttribute("cin", cin);
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }
        
        if (password.length() < 6) {
            request.setAttribute("error", "Password must be at least 6 characters long");
            request.setAttribute("nom", nom);
            request.setAttribute("email", email);
            request.setAttribute("cin", cin);
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
            return;
        }
        try {
            authService.registerPatient(nom.trim(), email.trim(), password, cin.trim());

            request.getSession().setAttribute("successMessage", 
                "Registration successful! Please login with your credentials.");
            response.sendRedirect(request.getContextPath() + "/login");
            
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.setAttribute("nom", nom);
            request.setAttribute("email", email);
            request.setAttribute("cin", cin);
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred during registration. Please try again.");
            request.setAttribute("nom", nom);
            request.setAttribute("email", email);
            request.setAttribute("cin", cin);
            request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
        }
    }
}

