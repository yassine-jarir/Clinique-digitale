package com.example.demo2.servlet;

import com.example.demo2.entity.Availability;
import com.example.demo2.repository.AvailabilityRepository;
import com.example.demo2.repository.AppointmentRepository;
import com.example.demo2.service.SlotService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.UUID;

@WebServlet("/api/availabilities")
public class AvailabilityApiServlet extends HttpServlet {
    private final AvailabilityRepository availabilityRepository = new AvailabilityRepository();
    private final AppointmentRepository appointmentRepository = new AppointmentRepository();
    private final SlotService slotService = new SlotService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String doctorIdStr = req.getParameter("doctorId");
        String dateStr = req.getParameter("date");

        System.out.println("=== API /api/availabilities called ===");
        System.out.println("doctorId: " + doctorIdStr);
        System.out.println("date: " + dateStr);

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

            System.out.println("Day of week: " + dayOfWeek);

            List<Availability> availabilities = availabilityRepository.findByDoctorIdAndDay(doctorId, dayOfWeek);
            System.out.println("Found " + availabilities.size() + " availability periods");

            // Use SlotService to compute truly available slot start times (respect pauses, existing appointments, lead time)
            List<LocalTime> availableSlots = slotService.generateSlots(doctorId, date);
            System.out.println("Generated " + availableSlots.size() + " available slots");

            Set<String> availableSet = new HashSet<>();
            for (LocalTime lt : availableSlots) {
                availableSet.add(lt.toString());
            }

            List<TimeSlot> timeSlots = new ArrayList<>();
            for (Availability availability : availabilities) {
                LocalTime current = availability.getHeureDebut();
                LocalTime end = availability.getHeureFin();
                System.out.println("Processing availability: " + current + " to " + end);

                while (current.isBefore(end)) {
                    boolean isAvailable = availableSet.contains(current.toString());
                    timeSlots.add(new TimeSlot(current.toString(), isAvailable));
                    current = current.plusMinutes(30); // 30-minute slots
                }
            }

            System.out.println("Total slots generated: " + timeSlots.size());
            System.out.println("Available slots: " + availableSlots.size());

            // Build JSON response
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            PrintWriter out = resp.getWriter();

            out.write("{\"slots\": [");
            for (int i = 0; i < timeSlots.size(); i++) {
                TimeSlot slot = timeSlots.get(i);
                out.write(String.format("{\"time\": \"%s\", \"available\": %b}",
                    slot.time, slot.available));
                if (i < timeSlots.size() - 1) {
                    out.write(",");
                }
            }
            out.write("]}");

            System.out.println("=== API response sent successfully ===");

         } catch (Exception e) {
            System.err.println("!!! ERROR in /api/availabilities: " + e.getMessage());
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.setContentType("application/json");
            resp.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");
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
        String time;
        boolean available;

        TimeSlot(String time, boolean available) {
            this.time = time;
            this.available = available;
        }
    }
}
