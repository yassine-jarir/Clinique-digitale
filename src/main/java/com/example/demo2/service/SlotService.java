package com.example.demo2.service;

import com.example.demo2.entity.Availability;
import com.example.demo2.entity.Pause;
import com.example.demo2.repository.AvailabilityRepository;
import com.example.demo2.repository.AppointmentRepository;
import com.example.demo2.repository.PauseRepository;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.UUID;

public class SlotService {
    private final AvailabilityRepository availabilityRepository = new AvailabilityRepository();
    private final PauseRepository pauseRepository = new PauseRepository();
    private final AppointmentRepository appointmentRepository = new AppointmentRepository();

    private static final int DEFAULT_SLOT_MINUTES = 30;
    private static final int LEAD_TIME_HOURS = 2;

    public List<LocalTime> generateSlots(UUID doctorId, LocalDate date) {
        return generateSlots(doctorId, date, DEFAULT_SLOT_MINUTES);
    }

    public List<LocalTime> generateSlots(UUID doctorId, LocalDate date, int slotMinutes) {
        String jour = getFrenchDay(date.getDayOfWeek());
        List<Availability> availabilities = availabilityRepository.findByDoctorIdAndDay(doctorId, jour);

        // CRITICAL FIX: Filter to only AVAILABLE status
        availabilities = availabilities.stream()
            .filter(a -> a.getStatut() == com.example.demo2.enums.AvailabilityStatus.AVAILABLE)
            .collect(java.util.stream.Collectors.toList());

        if (availabilities == null || availabilities.isEmpty()) return List.of();

        List<Pause> pauses = pauseRepository.findByDoctorIdAndDay(doctorId, jour);
        List<LocalTime> slots = new ArrayList<>();

        // Collect existing appointment start times for quick lookup
        var existingAppointments = appointmentRepository.findByDoctorIdAndDate(doctorId, date);
        Set<LocalTime> existingTimes = new HashSet<>();
        for (var a : existingAppointments) existingTimes.add(a.getHeure());

        LocalDateTime now = LocalDateTime.now();
        LocalDateTime cutoff = now.plusHours(LEAD_TIME_HOURS);

        for (Availability availability : availabilities) {
            LocalTime start = availability.getHeureDebut();
            LocalTime end = availability.getHeureFin();

            LocalTime slotStart = start;
            while (!slotStart.plusMinutes(slotMinutes).isAfter(end)) {
                LocalTime slotEnd = slotStart.plusMinutes(slotMinutes);

                LocalDateTime slotDateTime = LocalDateTime.of(date, slotStart);

                // Lead time check: slot must be >= now + LEAD_TIME_HOURS
                if (slotDateTime.isBefore(cutoff)) {
                    slotStart = slotStart.plusMinutes(slotMinutes);
                    continue;
                }

                // Check pause overlap
                boolean inPause = false;
                if (pauses != null) {
                    for (Pause p : pauses) {
                        if (overlaps(slotStart, slotEnd, p.getHeureDebut(), p.getHeureFin())) {
                            inPause = true;
                            break;
                        }
                    }
                }
                if (inPause) {
                    slotStart = slotStart.plusMinutes(slotMinutes);
                    continue;
                }

                // Check existing appointment conflict (assume appointments occupy one slot)
                if (existingTimes.contains(slotStart)) {
                    slotStart = slotStart.plusMinutes(slotMinutes);
                    continue;
                }

                slots.add(slotStart);
                slotStart = slotStart.plusMinutes(slotMinutes);
            }
        }

        return slots;
    }

    private boolean overlaps(LocalTime start1, LocalTime end1, LocalTime start2, LocalTime end2) {
        return start1.isBefore(end2) && end1.isAfter(start2);
    }

    private String getFrenchDay(java.time.DayOfWeek dayOfWeek) {
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
