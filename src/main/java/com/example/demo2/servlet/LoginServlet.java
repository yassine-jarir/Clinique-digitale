package com.example.demo2.servlet;

import com.example.demo2.dto.UserDTO;
import com.example.demo2.enums.UserRole;
import com.example.demo2.service.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "loginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {
    
    private AuthService authService;
    
    @Override
    public void init() throws ServletException {
        authService = new AuthService();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            UserDTO user = (UserDTO) session.getAttribute("user");
            redirectToDashboard(response, user);
            return;
        }
        
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        if (email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Email and password are required");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }
        
        try {
            // Attempt login
            UserDTO user = authService.login(email.trim(), password);
            
            if (user == null) {
                request.setAttribute("error", "Invalid email or password");
                request.setAttribute("email", email);
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
                return;
            }
            
            HttpSession session = request.getSession(true);
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getId());
            session.setAttribute("userRole", user.getRole());
            session.setAttribute("role", user.getRole().toString());
            session.setAttribute("nom", user.getNom());

            session.setMaxInactiveInterval(3600);
            if (user.getRole() == UserRole.DOCTOR) {
                session.setAttribute("doctor", user);
            }
            redirectToDashboard(response, user);
            
        } catch (IllegalStateException e) {
            request.setAttribute("error", e.getMessage());
            request.setAttribute("email", email);
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "An error occurred during login. Please try again.");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }
    
    private void redirectToDashboard(HttpServletResponse response, UserDTO user) throws IOException {
        switch (user.getRole()) {
            case ADMIN:
                response.sendRedirect(response.encodeRedirectURL("admin/dashboard"));
                break;
            case DOCTOR:
                response.sendRedirect(response.encodeRedirectURL("doctor/dashboard"));
                break;
            case PATIENT:
                response.sendRedirect(response.encodeRedirectURL("patient/dashboard"));
                break;
            case STAFF:
                response.sendRedirect(response.encodeRedirectURL("staff/dashboard"));
                break;
            default:
                response.sendRedirect(response.encodeRedirectURL("login"));
        }
    }
}
