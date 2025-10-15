package com.example.demo2.servlet.patient;

import com.example.demo2.dto.UserDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "patientDashboardServlet", urlPatterns = {"/patient/dashboard"})
public class PatientDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        UserDTO user = (UserDTO) session.getAttribute("user");
        request.getRequestDispatcher("/WEB-INF/views/patient/dashboard.jsp").forward(request, response);
    }
}
