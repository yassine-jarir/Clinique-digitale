package com.example.demo2.servlet;

import com.example.demo2.entity.Availability;
import com.example.demo2.repository.AvailabilityRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

@WebServlet("/api/doctor-availability")
public class DoctorAvailabilityApiServlet extends HttpServlet {
    private final AvailabilityRepository availabilityRepository = new AvailabilityRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String doctorIdStr = req.getParameter("doctorId");

        System.out.println("=== API /api/doctor-availability called ===");
        System.out.println("doctorId: " + doctorIdStr);

        if (doctorIdStr == null) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.setContentType("application/json");
            resp.getWriter().write("{\"error\": \"doctorId is required\"}");
            return;
        }

        try {
            UUID doctorId = UUID.fromString(doctorIdStr);

            // Get all availabilities for this doctor
            List<Availability> availabilities = availabilityRepository.findByDoctorId(doctorId);
            System.out.println("╔════════════════════════════════════════════════════════════════");
            System.out.println("║ TOTAL AVAILABILITIES FROM DATABASE: " + availabilities.size());
            System.out.println("╠════════════════════════════════════════════════════════════════");

            // Debug: Print each availability record
            for (int i = 0; i < availabilities.size(); i++) {
                Availability avail = availabilities.get(i);
                System.out.println("║ [" + (i + 1) + "] Jour: " + avail.getJour() +
                                   " | Hours: " + avail.getHeureDebut() + "-" + avail.getHeureFin() +
                                   " | Status: " + avail.getStatut() +
                                   " | Valid: " + avail.getValide());
            }
            System.out.println("╚════════════════════════════════════════════════════════════════");

            // Group by day of week
            Map<String, List<Availability>> byDay = new LinkedHashMap<>();
            String[] daysOrder = {"Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"};

            for (String day : daysOrder) {
                byDay.put(day, new ArrayList<>());
            }

            for (Availability avail : availabilities) {
                String jour = avail.getJour();
                if (byDay.containsKey(jour)) {
                    byDay.get(jour).add(avail);
                }
            }

            // Debug: Show grouped availabilities
            System.out.println("╔════════════════════════════════════════════════════════════════");
            System.out.println("║ GROUPED BY DAY OF WEEK:");
            System.out.println("╠════════════════════════════════════════════════════════════════");
            int totalDaysWithAvailability = 0;
            for (Map.Entry<String, List<Availability>> entry : byDay.entrySet()) {
                if (!entry.getValue().isEmpty()) {
                    totalDaysWithAvailability++;
                    System.out.println("║ " + entry.getKey() + " → " + entry.getValue().size() + " period(s)");
                    for (Availability a : entry.getValue()) {
                        System.out.println("║    └─ " + a.getHeureDebut() + " - " + a.getHeureFin() + " [" + a.getStatut() + "]");
                    }
                }
            }
            System.out.println("╠════════════════════════════════════════════════════════════════");
            System.out.println("║ SUMMARY: " + totalDaysWithAvailability + " UNIQUE DAYS OF WEEK with availability");
            System.out.println("╚════════════════════════════════════════════════════════════════");

            // Build JSON response
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            PrintWriter out = resp.getWriter();

            StringBuilder jsonBuilder = new StringBuilder();
            jsonBuilder.append("{\"schedule\": [");
            boolean first = true;
            for (Map.Entry<String, List<Availability>> entry : byDay.entrySet()) {
                if (!entry.getValue().isEmpty()) {
                    if (!first) jsonBuilder.append(",");
                    first = false;

                    jsonBuilder.append("{\"day\": \"").append(entry.getKey()).append("\", \"periods\": [");

                    for (int i = 0; i < entry.getValue().size(); i++) {
                        Availability avail = entry.getValue().get(i);
                        jsonBuilder.append(String.format("{\"start\": \"%s\", \"end\": \"%s\", \"status\": \"%s\"}",
                            avail.getHeureDebut(),
                            avail.getHeureFin(),
                            avail.getStatut()));
                        if (i < entry.getValue().size() - 1) jsonBuilder.append(",");
                    }

                    jsonBuilder.append("]}");
                }
            }
            jsonBuilder.append("]}");

            String jsonResponse = jsonBuilder.toString();
            System.out.println("JSON Response: " + jsonResponse);
            out.write(jsonResponse);

            System.out.println("=== API response sent successfully ===");

        } catch (Exception e) {
            System.err.println("!!! ERROR in /api/doctor-availability: " + e.getMessage());
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.setContentType("application/json");
            resp.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");
        }
    }
}
