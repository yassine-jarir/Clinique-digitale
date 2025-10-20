package com.example.demo2.servlet;

import com.example.demo2.dto.UserDTO;
import com.example.demo2.entity.Availability;
import com.example.demo2.entity.Doctor;
import com.example.demo2.enums.AvailabilityStatus;
import com.example.demo2.repository.AvailabilityRepository;
import com.example.demo2.repository.DoctorRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.*;

@WebServlet("/doctor/availabilities/bulk")
public class BulkAvailabilityServlet extends HttpServlet {
    private final AvailabilityRepository availabilityRepository = new AvailabilityRepository();
    private final DoctorRepository doctorRepository = new DoctorRepository();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        var session = req.getSession(false);
        UserDTO userDTO = (session != null) ? (UserDTO) session.getAttribute("user") : null;

        if (userDTO == null || userDTO.getRole() != com.example.demo2.enums.UserRole.DOCTOR) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Doctor doctor = doctorRepository.findById(userDTO.getId()).orElse(null);
        if (doctor == null) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied: Doctor not found.");
            return;
        }

        try {
            // Parse dates
            String startDateStr = req.getParameter("startDate");
            String endDateStr = req.getParameter("endDate");

            if (startDateStr == null || endDateStr == null) {
                req.setAttribute("error", "Les dates de début et de fin sont requises.");
                req.getRequestDispatcher("/WEB-INF/views/doctor/availabilities.jsp").forward(req, resp);
                return;
            }

            LocalDate startDate = LocalDate.parse(startDateStr);
            LocalDate endDate = LocalDate.parse(endDateStr);

            if (endDate.isBefore(startDate)) {
                req.setAttribute("error", "La date de fin doit être après la date de début.");
                req.getRequestDispatcher("/WEB-INF/views/doctor/availabilities.jsp").forward(req, resp);
                return;
            }

            // Get selected days
            String[] selectedDays = req.getParameterValues("days");
            if (selectedDays == null || selectedDays.length == 0) {
                req.setAttribute("error", "Veuillez sélectionner au moins un jour.");
                req.getRequestDispatcher("/WEB-INF/views/doctor/availabilities.jsp").forward(req, resp);
                return;
            }

            // Parse time slots for each day
            Map<String, TimeSlot> daySchedule = new HashMap<>();
            for (String day : selectedDays) {
                String startTimeStr = req.getParameter("startTime_" + day);
                String endTimeStr = req.getParameter("endTime_" + day);

                if (startTimeStr == null || endTimeStr == null) {
                    req.setAttribute("error", "Horaires manquants pour " + day);
                    req.getRequestDispatcher("/WEB-INF/views/doctor/availabilities.jsp").forward(req, resp);
                    return;
                }

                LocalTime startTime = LocalTime.parse(startTimeStr);
                LocalTime endTime = LocalTime.parse(endTimeStr);

                if (endTime.isBefore(startTime) || endTime.equals(startTime)) {
                    req.setAttribute("error", "L'heure de fin doit être après l'heure de début pour " + day);
                    req.getRequestDispatcher("/WEB-INF/views/doctor/availabilities.jsp").forward(req, resp);
                    return;
                }

                daySchedule.put(day, new TimeSlot(startTime, endTime));
            }

            // Create availabilities for each date in range
            int createdCount = 0;
            Set<String> selectedDaySet = new HashSet<>(Arrays.asList(selectedDays));

            for (LocalDate date = startDate; !date.isAfter(endDate); date = date.plusDays(1)) {
                DayOfWeek dayOfWeek = date.getDayOfWeek();
                String frenchDay = getFrenchDay(dayOfWeek);

                if (selectedDaySet.contains(frenchDay)) {
                    TimeSlot timeSlot = daySchedule.get(frenchDay);

                    // Check for overlaps
                    boolean hasOverlap = availabilityRepository.hasOverlap(
                        doctor.getId(),
                        frenchDay,
                        timeSlot.start,
                        timeSlot.end,
                        null
                    );

                    if (!hasOverlap) {
                        Availability availability = new Availability(
                            frenchDay,
                            timeSlot.start,
                            timeSlot.end,
                            AvailabilityStatus.AVAILABLE
                        );
                        availability.setValide(true);
                        availability.setStatut(AvailabilityStatus.AVAILABLE);

                        availabilityRepository.saveWithDoctorId(availability, doctor.getId());
                        createdCount++;
                    }
                }
            }

            req.getSession().setAttribute("success",
                String.format("✅ %d disponibilité(s) créée(s) avec succès!", createdCount));
            resp.sendRedirect(req.getContextPath() + "/doctor/availabilities");

        } catch (Exception e) {
            System.err.println("Error creating bulk availabilities: " + e.getMessage());
            req.setAttribute("error", "Erreur lors de la création des disponibilités: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/doctor/availabilities.jsp").forward(req, resp);
        }
    }

    private String getFrenchDay(DayOfWeek dayOfWeek) {
        return switch (dayOfWeek) {
            case MONDAY -> "Lundi";
            case TUESDAY -> "Mardi";
            case WEDNESDAY -> "Mercredi";
            case THURSDAY -> "Jeudi";
            case FRIDAY -> "Vendredi";
            case SATURDAY -> "Samedi";
            case SUNDAY -> "Dimanche";
        };
    }

    private static class TimeSlot {
        LocalTime start;
        LocalTime end;

        TimeSlot(LocalTime start, LocalTime end) {
            this.start = start;
            this.end = end;
        }
    }
}
