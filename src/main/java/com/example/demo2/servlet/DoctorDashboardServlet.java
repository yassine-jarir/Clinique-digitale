package com.example.demo2.servlet;

import com.example.demo2.dto.UserDTO;
import com.example.demo2.repository.DoctorRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/doctor/dashboard")
public class DoctorDashboardServlet extends HttpServlet {
    private final DoctorRepository doctorRepository = new DoctorRepository();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserDTO user = (UserDTO) req.getSession().getAttribute("user");
        if (user == null || user.getRole() != com.example.demo2.enums.UserRole.DOCTOR) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        req.getRequestDispatcher("/WEB-INF/views/doctor/dashboard.jsp").forward(req, resp);
    }
}
