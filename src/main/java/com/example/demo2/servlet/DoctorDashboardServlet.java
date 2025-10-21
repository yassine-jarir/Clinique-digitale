package com.example.demo2.servlet;

import com.example.demo2.dto.UserDTO;
import com.example.demo2.entity.Appointment;
import com.example.demo2.repository.AppointmentRepository;
import com.example.demo2.repository.AvailabilityRepository;
import com.example.demo2.repository.DoctorRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/doctor/dashboard")
public class DoctorDashboardServlet extends HttpServlet {
    private final DoctorRepository doctorRepository = new DoctorRepository();
    private final AppointmentRepository appointmentRepository = new AppointmentRepository();
    private final AvailabilityRepository availabilityRepository = new AvailabilityRepository();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserDTO user = (UserDTO) req.getSession().getAttribute("user");
        if (user == null || user.getRole() != com.example.demo2.enums.UserRole.DOCTOR) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Fetch today's appointments
        List<Appointment> todayAppointments = appointmentRepository.findTodayAppointmentsByDoctorId(user.getId());
        req.setAttribute("todayAppointments", todayAppointments);
        req.setAttribute("todayCount", todayAppointments.size());

        // Fetch all appointments for the doctor
        List<Appointment> allAppointments = appointmentRepository.findByDoctorId(user.getId());
        req.setAttribute("allAppointments", allAppointments);

        // Count active availabilities
        long activeAvailabilities = availabilityRepository.findByDoctorId(user.getId()).size();
        req.setAttribute("activeAvailabilities", activeAvailabilities);

        // Count total unique patients
        long totalPatients = allAppointments.stream()
                .map(a -> a.getPatient().getId())
                .distinct()
                .count();
        req.setAttribute("totalPatients", totalPatients);

        req.getRequestDispatcher("/WEB-INF/views/doctor/dashboard.jsp").forward(req, resp);
    }
}
