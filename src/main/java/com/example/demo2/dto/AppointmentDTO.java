package com.example.demo2.dto;

import com.example.demo2.enums.AppointmentStatus;
import com.example.demo2.enums.AppointmentType;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.UUID;

public class AppointmentDTO {
    private UUID id;
    private LocalDate dateRdv;
    private LocalTime heure;
    private AppointmentStatus statut;
    private AppointmentType type;
    private UUID doctorId;
    private String doctorNom;
    private UUID patientId;
    private String patientNom;
    private boolean hasMedicalNote;

    // Constructors
    public AppointmentDTO() {
    }

    // Getters and Setters
    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public LocalDate getDateRdv() {
        return dateRdv;
    }

    public void setDateRdv(LocalDate dateRdv) {
        this.dateRdv = dateRdv;
    }

    public LocalTime getHeure() {
        return heure;
    }

    public void setHeure(LocalTime heure) {
        this.heure = heure;
    }

    public AppointmentStatus getStatut() {
        return statut;
    }

    public void setStatut(AppointmentStatus statut) {
        this.statut = statut;
    }

    public AppointmentType getType() {
        return type;
    }

    public void setType(AppointmentType type) {
        this.type = type;
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

    public UUID getPatientId() {
        return patientId;
    }

    public void setPatientId(UUID patientId) {
        this.patientId = patientId;
    }

    public String getPatientNom() {
        return patientNom;
    }

    public void setPatientNom(String patientNom) {
        this.patientNom = patientNom;
    }

    public boolean isHasMedicalNote() {
        return hasMedicalNote;
    }

    public void setHasMedicalNote(boolean hasMedicalNote) {
        this.hasMedicalNote = hasMedicalNote;
    }
}

