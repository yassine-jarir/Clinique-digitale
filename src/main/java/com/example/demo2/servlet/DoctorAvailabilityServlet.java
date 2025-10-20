package com.example.demo2.servlet;
import com.example.demo2.dto.UserDTO;
import com.example.demo2.entity.Availability;
import com.example.demo2.entity.Doctor;
import com.example.demo2.enums.UserRole;
import com.example.demo2.service.AvailabilityService;
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
    private final AvailabilityService availabilityService = new AvailabilityService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var session = req.getSession(false);
        UserDTO userDTO = (session != null) ? (UserDTO) session.getAttribute("user") : null;

        if (userDTO == null || userDTO.getRole() != UserRole.DOCTOR) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Doctor doctor = availabilityService.getDoctorById(userDTO.getId()).orElse(null);
        if (doctor == null) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied: Doctor not found.");
            return;
        }

        List<Availability> availabilities = availabilityService.getDoctorAvailabilities(doctor.getId());
        req.setAttribute("availabilities", availabilities);
        req.getRequestDispatcher("/WEB-INF/views/doctor/availabilities.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var session = req.getSession(false);
        UserDTO userDTO = (session != null) ? (UserDTO) session.getAttribute("user") : null;

        if (userDTO == null || userDTO.getRole() != UserRole.DOCTOR) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Doctor doctor = availabilityService.getDoctorById(userDTO.getId()).orElse(null);
        if (doctor == null) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied: Doctor not found.");
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
                UUID availabilityId = UUID.fromString(idStr);
                availabilityService.deleteAvailability(availabilityId, doctor.getId());
            } else if (jour != null && heureDebutStr != null && heureFinStr != null) {
                LocalTime heureDebut = LocalTime.parse(heureDebutStr);
                LocalTime heureFin = LocalTime.parse(heureFinStr);

                // Validate time range
                error = availabilityService.validateTimeRange(heureDebut, heureFin);

                if (error == null) {
                    UUID excludeId = (idStr != null && !idStr.isEmpty()) ? UUID.fromString(idStr) : null;
                    boolean hasOverlap = availabilityService.hasOverlap(doctor.getId(), jour, heureDebut, heureFin, excludeId);

                    if (hasOverlap) {
                        error = "Les horaires se chevauchent avec une disponibilité existante.";
                    } else {
                        if (excludeId != null) {
                            // Update existing availability
                            availabilityService.updateAvailability(excludeId, doctor.getId(), jour, heureDebut, heureFin);
                        } else {
                            // Create new availability
                            availabilityService.createAvailability(doctor.getId(), jour, heureDebut, heureFin);
                        }
                    }
                }
            }
        } catch (IllegalAccessException e) {
            error = e.getMessage();
        } catch (Exception e) {
            e.printStackTrace();
            error = "Erreur lors de l'enregistrement de la disponibilité: " + e.getMessage();
        }

        if (error != null) {
            req.setAttribute("error", error);
            doGet(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/doctor/availabilities");
        }
    }
}
