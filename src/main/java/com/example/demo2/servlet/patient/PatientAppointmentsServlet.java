package com.example.demo2.servlet.patient;

import com.example.demo2.dto.UserDTO;
import com.example.demo2.entity.Appointment;
import com.example.demo2.enums.AppointmentStatus;
import com.example.demo2.repository.AppointmentRepository;
import com.example.demo2.repository.PatientRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@WebServlet("/patient/appointments")
public class PatientAppointmentsServlet extends HttpServlet {
    private final AppointmentRepository appointmentRepository = new AppointmentRepository();
    private final PatientRepository patientRepository = new PatientRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var session = req.getSession(false);
        UserDTO userDTO = (session != null) ? (UserDTO) session.getAttribute("user") : null;

        if (userDTO == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        List<Appointment> appointments = appointmentRepository.findByPatientId(userDTO.getId());
        req.setAttribute("appointments", appointments);
        req.getRequestDispatcher("/WEB-INF/views/patient/appointments.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var session = req.getSession(false);
        UserDTO userDTO = (session != null) ? (UserDTO) session.getAttribute("user") : null;

        if (userDTO == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        try {
            String action = req.getParameter("action");
            if ("cancel".equals(action)) {
                String appointmentIdStr = req.getParameter("appointmentId");
                if (appointmentIdStr == null) {
                    req.setAttribute("error", "Identifiant du rendez-vous manquant.");
                    doGet(req, resp);
                    return;
                }

                UUID appointmentId = UUID.fromString(appointmentIdStr);
                var optional = appointmentRepository.findById(appointmentId);
                if (optional.isEmpty()) {
                    req.setAttribute("error", "Rendez-vous introuvable.");
                    doGet(req, resp);
                    return;
                }

                Appointment appointment = optional.get();

                // Verify ownership
                if (appointment.getPatient() == null || !appointment.getPatient().getId().equals(userDTO.getId())) {
                    req.setAttribute("error", "Vous n'êtes pas autorisé à annuler ce rendez-vous.");
                    doGet(req, resp);
                    return;
                }

                // Check cancellation window: must be at least 12 hours before appointment datetime
                LocalDateTime appointmentDateTime = LocalDateTime.of(appointment.getDateRdv(), appointment.getHeure());
                LocalDateTime cutoff = LocalDateTime.now().plusHours(12);
                if (appointmentDateTime.isBefore(cutoff)) {
                    req.setAttribute("error", "Annulation impossible : la limite d'annulation (12 heures) est dépassée.");
                    doGet(req, resp);
                    return;
                }

                // Mark canceled
                appointment.setStatut(AppointmentStatus.CANCELED);
                appointmentRepository.update(appointment);

                req.getSession().setAttribute("success", "Rendez-vous annulé avec succès.");
                resp.sendRedirect(req.getContextPath() + "/patient/appointments");
                return;
            }

            // Unknown action - just refresh
            resp.sendRedirect(req.getContextPath() + "/patient/appointments");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur lors du traitement: " + e.getMessage());
            doGet(req, resp);
        }
    }
}
