package com.example.demo2.service;

import com.example.demo2.entity.Availability;
import com.example.demo2.entity.Doctor;
import com.example.demo2.enums.AvailabilityStatus;
import com.example.demo2.repository.AvailabilityRepository;
import com.example.demo2.repository.DoctorRepository;

import java.time.LocalTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public class AvailabilityService {
    private final AvailabilityRepository availabilityRepository;
    private final DoctorRepository doctorRepository;

    public AvailabilityService() {
        this.availabilityRepository = new AvailabilityRepository();
        this.doctorRepository = new DoctorRepository();
    }

    public AvailabilityService(AvailabilityRepository availabilityRepository, DoctorRepository doctorRepository) {
        this.availabilityRepository = availabilityRepository;
        this.doctorRepository = doctorRepository;
    }

    public Optional<Doctor> getDoctorById(UUID doctorId) {
        return doctorRepository.findById(doctorId);
    }

    public List<Availability> getDoctorAvailabilities(UUID doctorId) {
        return availabilityRepository.findByDoctorId(doctorId);
    }

    public void deleteAvailability(UUID availabilityId, UUID doctorId) throws IllegalAccessException {
        Availability availability = availabilityRepository.findById(availabilityId).orElse(null);

        if (availability == null) {
            throw new IllegalArgumentException("Disponibilité introuvable.");
        }

        if (!availability.getDoctor().getId().equals(doctorId)) {
            throw new IllegalAccessException("Vous n'êtes pas autorisé à supprimer cette disponibilité.");
        }

        availabilityRepository.delete(availabilityId);
    }

    public String validateTimeRange(LocalTime heureDebut, LocalTime heureFin) {
        if (heureFin.isBefore(heureDebut)) {
            return String.format(
                "L'heure de fin (%s) est avant l'heure de début (%s). " +
                "Exemple valide: 08:00 → 17:00 (8h matin à 5h après-midi)",
                heureFin, heureDebut
            );
        }

        if (heureFin.equals(heureDebut)) {
            return String.format(
                "L'heure de début et de fin sont identiques (%s). " +
                "Veuillez choisir des heures différentes.",
                heureDebut
            );
        }

        return null;
    }

    public boolean hasOverlap(UUID doctorId, String jour, LocalTime heureDebut, LocalTime heureFin, UUID excludeId) {
        return availabilityRepository.hasOverlap(doctorId, jour, heureDebut, heureFin, excludeId);
    }

    public void createAvailability(UUID doctorId, String jour, LocalTime heureDebut, LocalTime heureFin) {
        Availability availability = new Availability(jour, heureDebut, heureFin, AvailabilityStatus.AVAILABLE);
        availability.setValide(true);
        availability.setStatut(AvailabilityStatus.AVAILABLE);

        System.out.println("DEBUG - About to save availability with doctor ID: " + doctorId);
        availabilityRepository.saveWithDoctorId(availability, doctorId);
        System.out.println("SUCCESS - Availability saved: " + jour + " " + heureDebut + " to " + heureFin);
    }

    public void updateAvailability(UUID availabilityId, UUID doctorId, String jour, LocalTime heureDebut, LocalTime heureFin)
            throws IllegalAccessException {
        Availability availability = availabilityRepository.findById(availabilityId).orElse(null);

        if (availability == null) {
            throw new IllegalArgumentException("Disponibilité introuvable.");
        }

        if (!availability.getDoctor().getId().equals(doctorId)) {
            throw new IllegalAccessException("Vous n'êtes pas autorisé à modifier cette disponibilité.");
        }

        availability.setJour(jour);
        availability.setHeureDebut(heureDebut);
        availability.setHeureFin(heureFin);
        availability.setStatut(AvailabilityStatus.AVAILABLE);
        availability.setValide(true);

        availabilityRepository.update(availability);
    }
}

