package com.example.demo2.servlet;

import com.example.demo2.dto.UserDTO;
import com.example.demo2.entity.Appointment;
import com.example.demo2.entity.Doctor;
import com.example.demo2.entity.Patient;
import com.example.demo2.enums.AppointmentStatus;
import com.example.demo2.enums.AppointmentType;
import com.example.demo2.enums.UserRole;
import com.example.demo2.repository.AppointmentRepository;
import com.example.demo2.repository.DoctorRepository;
import com.example.demo2.repository.PatientRepository;
import com.example.demo2.service.SlotService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.UUID;

@WebServlet("/patient/book-appointment")
public class PatientBookAppointmentServlet extends HttpServlet {
    private final DoctorRepository doctorRepository = new DoctorRepository();
    private final AppointmentRepository appointmentRepository = new AppointmentRepository();
    private final PatientRepository patientRepository = new PatientRepository();
    private final SlotService slotService = new SlotService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var session = req.getSession(false);
        UserDTO userDTO = (session != null) ? (UserDTO) session.getAttribute("user") : null;

        if (userDTO == null || userDTO.getRole() != UserRole.PATIENT) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Get all doctors for selection
        List<Doctor> doctors = doctorRepository.findAll();
        req.setAttribute("doctors", doctors);

        String doctorIdStr = req.getParameter("doctorId");
        String dateStr = req.getParameter("date");
        if (doctorIdStr != null) {
            req.setAttribute("selectedDoctorId", doctorIdStr);
        }
        if (doctorIdStr != null && dateStr != null) {
            try {
                UUID doctorId = UUID.fromString(doctorIdStr);
                LocalDate date = LocalDate.parse(dateStr);
                List<LocalTime> slots = slotService.generateSlots(doctorId, date);
                req.setAttribute("slots", slots);
                req.setAttribute("selectedDoctorId", doctorIdStr);
                req.setAttribute("selectedDate", dateStr);
            } catch (Exception e) {
                req.setAttribute("error", "Erreur lors de la génération des créneaux: " + e.getMessage());
            }
        }

        req.getRequestDispatcher("/WEB-INF/views/patient/book-appointment.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var session = req.getSession(false);
        UserDTO userDTO = (session != null) ? (UserDTO) session.getAttribute("user") : null;

        if (userDTO == null || userDTO.getRole() != UserRole.PATIENT) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        try {
            String doctorIdStr = req.getParameter("doctorId");
            String dateStr = req.getParameter("date");
            String timeStr = req.getParameter("time");
            String typeStr = req.getParameter("type");

            if (doctorIdStr == null || dateStr == null || timeStr == null || typeStr == null) {
                req.setAttribute("error", "Tous les champs sont requis.");
                doGet(req, resp);
                return;
            }

            UUID doctorId = UUID.fromString(doctorIdStr);
            LocalDate date = LocalDate.parse(dateStr);
            LocalTime time = LocalTime.parse(timeStr);
            AppointmentType type = AppointmentType.valueOf(typeStr);

            if (date.isBefore(LocalDate.now())) {
                req.setAttribute("error", "Impossible de prendre rendez-vous dans le passé.");
                doGet(req, resp);
                return;
            }

            Doctor doctor = doctorRepository.findById(doctorId).orElse(null);
            if (doctor == null) {
                req.setAttribute("error", "Médecin introuvable.");
                doGet(req, resp);
                return;
            }

            Patient patient = patientRepository.findById(userDTO.getId()).orElse(null);
            if (patient == null) {
                req.setAttribute("error", "Patient introuvable.");
                doGet(req, resp);
                return;
            }

            List<LocalTime> slots = slotService.generateSlots(doctorId, date);
            if (!slots.contains(time)) {
                req.setAttribute("error", "Le créneau sélectionné n'est pas disponible. Veuillez choisir un autre créneau.");
                doGet(req, resp);
                return;
            }

            // Final conflict check (defense-in-depth)
            if (appointmentRepository.hasConflict(doctorId, date, time)) {
                req.setAttribute("error", "Ce créneau est déjà réservé. Veuillez choisir une autre heure.");
                doGet(req, resp);
                return;
            }

            // Create appointment
            Appointment appointment = new Appointment(date, time, type, doctor, patient);
            appointment.setStatut(AppointmentStatus.PLANNED);
            appointmentRepository.save(appointment);

            req.getSession().setAttribute("success", "\u2705 Rendez-vous réservé avec succès!");
            resp.sendRedirect(req.getContextPath() + "/patient/appointments");

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur lors de la réservation: " + e.getMessage());
            doGet(req, resp);
        }
    }
}
