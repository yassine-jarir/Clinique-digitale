package com.example.demo2.servlet;

import com.example.demo2.dto.UserDTO;
import com.example.demo2.enums.UserRole;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/patient/book-appointment-enhanced")
public class EnhancedBookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var session = req.getSession(false);
        UserDTO user = (session != null) ? (UserDTO) session.getAttribute("user") : null;

        if (user == null || user.getRole() != UserRole.PATIENT) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String doctorId = req.getParameter("doctorId");
        if (doctorId == null || doctorId.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/patient/rendezvous");
            return;
        }

        req.getRequestDispatcher("/WEB-INF/views/patient/book-appointment-enhanced.jsp").forward(req, resp);
    }
}

