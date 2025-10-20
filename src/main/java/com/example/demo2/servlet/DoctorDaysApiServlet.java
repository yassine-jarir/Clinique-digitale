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
import java.time.*;
import java.util.*;

@WebServlet("/api/doctor-days")
public class DoctorDaysApiServlet extends HttpServlet {
    private final AvailabilityRepository availabilityRepository = new AvailabilityRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String doctorIdStr = req.getParameter("doctorId");
        String startDateStr = req.getParameter("startDate");

        if (doctorIdStr == null) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.setContentType("application/json");
            resp.getWriter().write("{\"error\": \"doctorId is required\"}");
            return;
        }

        try {
            UUID doctorId = UUID.fromString(doctorIdStr);
            LocalDate startDate = startDateStr != null ? LocalDate.parse(startDateStr) : LocalDate.now();
            LocalDate endDate = startDate.plusDays(30); // Show 30 days

            List<Availability> availabilities = availabilityRepository.findByDoctorId(doctorId);

            // Group availabilities by day
            Map<String, List<Availability>> availabilityByDay = new LinkedHashMap<>();
            for (Availability avail : availabilities) {
                if (avail.getValide() != null && avail.getValide()) {
                    availabilityByDay.computeIfAbsent(avail.getJour(), k -> new ArrayList<>()).add(avail);
                }
            }

            // Generate day objects for next 30 days
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            PrintWriter out = resp.getWriter();

            out.write("{\"days\": [");
            boolean first = true;

            for (LocalDate date = startDate; date.isBefore(endDate); date = date.plusDays(1)) {
                String dayName = getFrenchDay(date.getDayOfWeek());
                List<Availability> dayAvailabilities = availabilityByDay.get(dayName);

                boolean isPast = date.isBefore(LocalDate.now());
                boolean isToday = date.equals(LocalDate.now());
                boolean hasAvailability = dayAvailabilities != null && !dayAvailabilities.isEmpty();

                if (!first) out.write(",");
                first = false;

                out.write(String.format(
                    "{\"date\": \"%s\", \"dayName\": \"%s\", \"dayOfWeek\": \"%s\", \"isPast\": %b, \"isToday\": %b, \"hasAvailability\": %b, \"periods\": [",
                    date, dayName, date.getDayOfWeek().name(), isPast, isToday, hasAvailability
                ));

                if (hasAvailability) {
                    boolean firstPeriod = true;
                    for (Availability avail : dayAvailabilities) {
                        if (!firstPeriod) out.write(",");
                        firstPeriod = false;
                        out.write(String.format(
                            "{\"start\": \"%s\", \"end\": \"%s\"}",
                            avail.getHeureDebut(), avail.getHeureFin()
                        ));
                    }
                }

                out.write("]}");
            }

            out.write("]}");

        } catch (Exception e) {
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

