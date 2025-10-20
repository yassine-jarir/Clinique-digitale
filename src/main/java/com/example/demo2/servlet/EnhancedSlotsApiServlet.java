package com.example.demo2.servlet;

import com.example.demo2.entity.Availability;
import com.example.demo2.entity.Appointment;
import com.example.demo2.entity.Pause;
import com.example.demo2.repository.AvailabilityRepository;
import com.example.demo2.repository.AppointmentRepository;
import com.example.demo2.repository.PauseRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.*;
import java.util.*;

@WebServlet("/api/enhanced-slots")
public class EnhancedSlotsApiServlet extends HttpServlet {
    private final AvailabilityRepository availabilityRepository = new AvailabilityRepository();
    private final AppointmentRepository appointmentRepository = new AppointmentRepository();
    private final PauseRepository pauseRepository = new PauseRepository();

    private static final int SLOT_MINUTES = 30;
    private static final int LEAD_TIME_HOURS = 2;
    private static final int CANCELLATION_LIMIT_HOURS = 12;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String doctorIdStr = req.getParameter("doctorId");
        String dateStr = req.getParameter("date");

        if (doctorIdStr == null || dateStr == null) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.setContentType("application/json");
            resp.getWriter().write("{\"error\": \"doctorId and date are required\"}");
            return;
        }

        try {
            UUID doctorId = UUID.fromString(doctorIdStr);
            LocalDate date = LocalDate.parse(dateStr);
            String dayOfWeek = getFrenchDay(date.getDayOfWeek());

            LocalDateTime now = LocalDateTime.now();
            LocalDateTime leadTimeCutoff = now.plusHours(LEAD_TIME_HOURS);

            // Get doctor's availability for this day
            List<Availability> availabilities = availabilityRepository.findByDoctorIdAndDay(doctorId, dayOfWeek);

            // Get pauses for this day
            List<Pause> pauses = pauseRepository.findByDoctorIdAndDay(doctorId, dayOfWeek);

            // Get existing appointments for this date
            List<Appointment> appointments = appointmentRepository.findByDoctorIdAndDate(doctorId, date);
            Set<LocalTime> bookedTimes = new HashSet<>();
            for (Appointment apt : appointments) {
                bookedTimes.add(apt.getHeure());
            }

            // Generate slots with detailed status
            List<SlotDetail> slots = new ArrayList<>();

            for (Availability availability : availabilities) {
                LocalTime current = availability.getHeureDebut();
                LocalTime end = availability.getHeureFin();

                while (current.isBefore(end)) {
                    LocalDateTime slotDateTime = LocalDateTime.of(date, current);
                    SlotDetail slot = new SlotDetail();
                    slot.time = current.toString();
                    slot.dateTime = slotDateTime.toString();

                    // Determine slot status
                    if (slotDateTime.isBefore(now)) {
                        slot.status = "past";
                        slot.available = false;
                        slot.reason = "Ce créneau est dans le passé";
                        slot.tooltip = "Passé";
                    } else if (slotDateTime.isBefore(leadTimeCutoff)) {
                        slot.status = "too-soon";
                        slot.available = false;
                        slot.reason = "Délai minimum de " + LEAD_TIME_HOURS + "h requis";
                        slot.tooltip = "Trop proche (" + LEAD_TIME_HOURS + "h min requis)";
                    } else if (bookedTimes.contains(current)) {
                        slot.status = "booked";
                        slot.available = false;
                        slot.reason = "Ce créneau est déjà réservé";
                        slot.tooltip = "Déjà réservé";
                    } else if (isDuringPause(current, pauses)) {
                        slot.status = "pause";
                        slot.available = false;
                        slot.reason = "Pause/déjeuner du médecin";
                        slot.tooltip = "Pause";
                    } else {
                        slot.status = "available";
                        slot.available = true;
                        slot.reason = "";
                        slot.tooltip = "Disponible - Cliquez pour sélectionner";
                    }

                    // Check if within cancellation window for existing appointments
                    slot.cancellable = slotDateTime.isAfter(now.plusHours(CANCELLATION_LIMIT_HOURS));

                    slots.add(slot);
                    current = current.plusMinutes(SLOT_MINUTES);
                }
            }

            // Build JSON response
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            PrintWriter out = resp.getWriter();

            out.write("{");
            out.write("\"date\": \"" + date + "\",");
            out.write("\"dayName\": \"" + dayOfWeek + "\",");
            out.write("\"isPast\": " + date.isBefore(LocalDate.now()) + ",");
            out.write("\"isToday\": " + date.equals(LocalDate.now()) + ",");
            out.write("\"totalSlots\": " + slots.size() + ",");
            out.write("\"availableCount\": " + slots.stream().filter(s -> s.available).count() + ",");
            out.write("\"slots\": [");

            for (int i = 0; i < slots.size(); i++) {
                SlotDetail slot = slots.get(i);
                if (i > 0) out.write(",");
                out.write(String.format(
                    "{\"time\": \"%s\", \"dateTime\": \"%s\", \"status\": \"%s\", \"available\": %b, \"reason\": \"%s\", \"tooltip\": \"%s\", \"cancellable\": %b}",
                    slot.time, slot.dateTime, slot.status, slot.available,
                    escapeJson(slot.reason), escapeJson(slot.tooltip), slot.cancellable
                ));
            }
            
            out.write("]}");

        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.setContentType("application/json");
            resp.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");
        }
    }

    private boolean isDuringPause(LocalTime time, List<Pause> pauses) {
        if (pauses == null) return false;
        for (Pause pause : pauses) {
            if (!time.isBefore(pause.getHeureDebut()) && time.isBefore(pause.getHeureFin())) {
                return true;
            }
        }
        return false;
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

    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\"", "\\\"").replace("\n", "\\n");
    }

    private static class SlotDetail {
        String time;
        String dateTime;
        String status;
        boolean available;
        String reason;
        String tooltip;
        boolean cancellable;
    }
}
