package com.example.demo2.dto;

import com.example.demo2.enums.AvailabilityStatus;
import java.time.LocalTime;
import java.util.UUID;

public class AvailabilityDTO {
    private UUID id;
    private String jour;
    private LocalTime heureDebut;
    private LocalTime heureFin;
    private AvailabilityStatus statut;
    private Boolean valide;
    private UUID doctorId;
    private String doctorNom;

    // Constructors
    public AvailabilityDTO() {
    }

    // Getters and Setters
    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getJour() {
        return jour;
    }

    public void setJour(String jour) {
        this.jour = jour;
    }

    public LocalTime getHeureDebut() {
        return heureDebut;
    }

    public void setHeureDebut(LocalTime heureDebut) {
        this.heureDebut = heureDebut;
    }

    public LocalTime getHeureFin() {
        return heureFin;
    }

    public void setHeureFin(LocalTime heureFin) {
        this.heureFin = heureFin;
    }

    public AvailabilityStatus getStatut() {
        return statut;
    }

    public void setStatut(AvailabilityStatus statut) {
        this.statut = statut;
    }

    public Boolean getValide() {
        return valide;
    }

    public void setValide(Boolean valide) {
        this.valide = valide;
    }

    public UUID getDoctorId() {
        return doctorId;
    }

    public void setDoctorId(UUID doctorId) {
        this.doctorId = doctorId;
    }

    public String getDoctorNom() {
        return doctorNom;
    }

    public void setDoctorNom(String doctorNom) {
        this.doctorNom = doctorNom;
    }
}

