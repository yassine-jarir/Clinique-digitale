package com.example.demo2.servlet.patient;

import com.example.demo2.dto.UserDTO;
import com.example.demo2.entity.Appointment;
import com.example.demo2.enums.AppointmentStatus;
import com.example.demo2.enums.UserRole;
import com.example.demo2.repository.AppointmentRepository;
import com.example.demo2.repository.DoctorRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "patientDashboardServlet", urlPatterns = {"/patient/dashboard"})
public class PatientDashboardServlet extends HttpServlet {

    private final AppointmentRepository appointmentRepository = new AppointmentRepository();
    private final DoctorRepository doctorRepository = new DoctorRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        UserDTO user = (UserDTO) session.getAttribute("user");

        if (user.getRole() != UserRole.PATIENT) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            List<Appointment> allAppointments = appointmentRepository.findByPatientId(user.getId());
            LocalDate today = LocalDate.now();

            // Count upcoming appointments
            long upcomingCount = allAppointments.stream()
                    .filter(a -> a.getDateRdv().isAfter(today) ||
                                (a.getDateRdv().isEqual(today) && a.getStatut() != AppointmentStatus.CANCELED))
                    .count();

            // Count past appointments
            long pastCount = allAppointments.stream()
                    .filter(a -> a.getDateRdv().isBefore(today) && a.getStatut() == AppointmentStatus.DONE)
                    .count();

            // Get recent appointments (last 5)
            List<Appointment> recentAppointments = allAppointments.stream()
                    .sorted((a1, a2) -> {
                        int dateCompare = a2.getDateRdv().compareTo(a1.getDateRdv());
                        if (dateCompare != 0) return dateCompare;
                        return a2.getHeure().compareTo(a1.getHeure());
                    })
                    .limit(5)
                    .collect(Collectors.toList());

            // Count active doctors
            long doctorCount = doctorRepository.findActiveDoctors().size();

            // Set attributes
            request.setAttribute("upcomingCount", upcomingCount);
            request.setAttribute("pastCount", pastCount);
            request.setAttribute("doctorCount", doctorCount);
            request.setAttribute("recentAppointments", recentAppointments);

        } catch (Exception e) {
            System.err.println("Error loading patient dashboard: " + e.getMessage());
            e.printStackTrace();
        }

        request.getRequestDispatcher("/WEB-INF/views/patient/dashboard.jsp").forward(request, response);
    }
}
