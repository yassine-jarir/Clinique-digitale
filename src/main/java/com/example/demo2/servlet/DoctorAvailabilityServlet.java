package com.example.demo2.servlet;

import com.example.demo2.entity.Availability;
import com.example.demo2.entity.Doctor;
import com.example.demo2.enums.AvailabilityStatus;
import com.example.demo2.repository.AvailabilityRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalTime;
import java.util.List;
import java.util.UUID;

@WebServlet("/doctor/availabilities")
public class DoctorAvailabilityServlet extends HttpServlet {
    private final AvailabilityRepository availabilityRepository = new AvailabilityRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var session = req.getSession(false);
        Doctor doctor = (session != null) ? (Doctor) session.getAttribute("doctor") : null;
        if (doctor == null) {
            if (session == null) {
                resp.sendRedirect(req.getContextPath() + "/login");
            } else {
                resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied: Doctors only.");
            }
            return;
        }
        List<Availability> availabilities = availabilityRepository.findByDoctorId(doctor.getId());
        req.setAttribute("availabilities", availabilities);
        req.getRequestDispatcher("/WEB-INF/views/doctor/availabilities.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var session = req.getSession(false);
        Doctor doctor = (session != null) ? (Doctor) session.getAttribute("doctor") : null;
        if (doctor == null) {
            if (session == null) {
                resp.sendRedirect(req.getContextPath() + "/login");
            } else {
                resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied: Doctors only.");
            }
            return;
        }
        String jour = req.getParameter("jour");
        String heureDebutStr = req.getParameter("heureDebut");
        String heureFinStr = req.getParameter("heureFin");
        String idStr = req.getParameter("id");
        String action = req.getParameter("action");
        String error = null;
        try {
            if ("delete".equals(action) && idStr != null) {
                availabilityRepository.delete(UUID.fromString(idStr));
            } else {
                LocalTime heureDebut = LocalTime.parse(heureDebutStr);
                LocalTime heureFin = LocalTime.parse(heureFinStr);
                UUID excludeId = (idStr != null && !idStr.isEmpty()) ? UUID.fromString(idStr) : null;
                boolean hasOverlap = availabilityRepository.hasOverlap(doctor.getId(), jour, heureDebut, heureFin, excludeId);
                if (hasOverlap) {
                    error = "Les horaires se chevauchent avec une disponibilité existante.";
                } else {
                    Availability availability;
                    if (excludeId != null) {
                        availability = availabilityRepository.findById(excludeId).orElse(null);
                        if (availability != null) {
                            availability.setJour(jour);
                            availability.setHeureDebut(heureDebut);
                            availability.setHeureFin(heureFin);
                            availability.setStatut(AvailabilityStatus.AVAILABLE);
                            availability.setValide(true);
                            availabilityRepository.update(availability);
                        }
                    } else {
                        availability = new Availability(jour, heureDebut, heureFin, AvailabilityStatus.AVAILABLE);
                        availability.setDoctor(doctor);
                        availability.setValide(true);
                        availabilityRepository.save(availability);
                    }
                }
            }
        } catch (Exception e) {
            error = "Erreur lors de l'enregistrement de la disponibilité.";
        }
        if (error != null) {
            req.setAttribute("error", error);
            doGet(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/doctor/availabilities");
        }
    }
}
