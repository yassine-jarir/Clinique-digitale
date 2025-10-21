package com.example.demo2.servlet;

import com.example.demo2.entity.Availability;
import com.example.demo2.enums.AvailabilityStatus;
import com.example.demo2.repository.AvailabilityRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.*;
import java.util.*;

@WebServlet("/api/doctor-days")
public class DoctorDaysApiServlet extends HttpServlet {
    private final AvailabilityRepository availabilityRepository = new AvailabilityRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String doctorIdStr = req.getParameter("doctorId");
        String startDateStr = req.getParameter("startDate");

        System.out.println("=== API /api/doctor-days called ===");
        System.out.println("doctorId: " + doctorIdStr);

        if (doctorIdStr == null) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.setContentType("application/json");
            resp.getWriter().write("{\"error\": \"doctorId is required\"}");
            return;
        }

        try {
            UUID doctorId = UUID.fromString(doctorIdStr);
            LocalDate startDate = startDateStr != null ? LocalDate.parse(startDateStr) : LocalDate.now();

            List<Availability> availabilities = availabilityRepository.findByDoctorId(doctorId);
            System.out.println("Found " + availabilities.size() + " total availability records");

            // CRITICAL FIX: Filter to only AVAILABLE status
            List<Availability> availableOnly = new ArrayList<>();
            for (Availability avail : availabilities) {
                System.out.println("  - " + avail.getJour() + ": " + avail.getHeureDebut() + "-" + avail.getHeureFin() +
                        " | Status: " + avail.getStatut() + " | Valid: " + avail.getValide());
                if (avail.getValide() != null && avail.getValide() &&
                        avail.getStatut() == AvailabilityStatus.AVAILABLE) {
                    availableOnly.add(avail);
                }
            }
            System.out.println("After filtering by AVAILABLE status: " + availableOnly.size() + " records");

            // Group availabilities by day
            Map<String, List<Availability>> availabilityByDay = new LinkedHashMap<>();
            for (Availability avail : availableOnly) {
                availabilityByDay.computeIfAbsent(avail.getJour(), k -> new ArrayList<>()).add(avail);
            }

            // CRITICAL FIX: Show only the NEXT occurrence of each day the doctor works
            // This will show maximum 7 days (one per day of week) instead of repeating every week
            Set<String> daysAlreadyAdded = new HashSet<>();
            List<Map<String, Object>> daysToShow = new ArrayList<>();

            // Look ahead up to 14 days to find the next occurrence of each working day
            for (LocalDate date = startDate; date.isBefore(startDate.plusDays(14)); date = date.plusDays(1)) {
                String dayName = getFrenchDay(date.getDayOfWeek());

                // Skip if we already added this day of the week OR if doctor doesn't work this day
                if (daysAlreadyAdded.contains(dayName) || !availabilityByDay.containsKey(dayName)) {
                    continue;
                }

                List<Availability> dayAvailabilities = availabilityByDay.get(dayName);
                boolean isPast = date.isBefore(LocalDate.now());
                boolean isToday = date.equals(LocalDate.now());

                // Skip past days
                if (isPast) {
                    continue;
                }

                // Add this day
                Map<String, Object> dayInfo = new LinkedHashMap<>();
                dayInfo.put("date", date.toString());
                dayInfo.put("dayName", dayName);
                dayInfo.put("dayOfWeek", date.getDayOfWeek().name());
                dayInfo.put("isPast", false);
                dayInfo.put("isToday", isToday);
                dayInfo.put("hasAvailability", true);
                dayInfo.put("periods", dayAvailabilities);

                daysToShow.add(dayInfo);
                daysAlreadyAdded.add(dayName);

                System.out.println("  ✅ Adding day: " + date + " (" + dayName + ")");
            }

            // Generate JSON response
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            PrintWriter out = resp.getWriter();

            out.write("{\"days\": [");
            boolean first = true;

            for (Map<String, Object> dayInfo : daysToShow) {
                if (!first) out.write(",");
                first = false;

                @SuppressWarnings("unchecked")
                List<Availability> periods = (List<Availability>) dayInfo.get("periods");

                out.write(String.format(
                        "{\"date\": \"%s\", \"dayName\": \"%s\", \"dayOfWeek\": \"%s\", \"isPast\": %b, \"isToday\": %b, \"hasAvailability\": %b, \"periods\": [",
                        dayInfo.get("date"), dayInfo.get("dayName"), dayInfo.get("dayOfWeek"),
                        dayInfo.get("isPast"), dayInfo.get("isToday"), dayInfo.get("hasAvailability")
                ));

                boolean firstPeriod = true;
                for (Availability avail : periods) {
                    if (!firstPeriod) out.write(",");
                    firstPeriod = false;
                    out.write(String.format(
                            "{\"start\": \"%s\", \"end\": \"%s\"}",
                            avail.getHeureDebut(), avail.getHeureFin()
                    ));
                }

                out.write("]}");
            }

            out.write("]}");
            System.out.println("Returned " + daysToShow.size() + " unique days (max one per day-of-week)");
            System.out.println("=== API response sent successfully ===");

        } catch (Exception e) {
            System.err.println("!!! ERROR in /api/doctor-days: " + e.getMessage());
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
}
