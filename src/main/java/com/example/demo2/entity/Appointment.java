package com.example.demo2.entity;

import com.example.demo2.enums.AppointmentStatus;
import com.example.demo2.enums.AppointmentType;
import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.UUID;

@Entity
@Table(name = "appointments")
public class Appointment {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(name = "date_rdv", nullable = false)
    private LocalDate dateRdv;

    @Column(nullable = false)
    private LocalTime heure;

    @Enumerated(EnumType.STRING)
    @Column(length = 20)
    private AppointmentStatus statut;

    @Enumerated(EnumType.STRING)
    @Column(length = 20)
    private AppointmentType type;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "doctor_id")
    private Doctor doctor;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "patient_id")
    private Patient patient;

    @OneToOne(mappedBy = "appointment", cascade = CascadeType.ALL, orphanRemoval = true)
    private MedicalNote medicalNote;

    // Constructors
    public Appointment() {
    }

    public Appointment(LocalDate dateRdv, LocalTime heure, AppointmentType type, Doctor doctor, Patient patient) {
        this.dateRdv = dateRdv;
        this.heure = heure;
        this.type = type;
        this.doctor = doctor;
        this.patient = patient;
        this.statut = AppointmentStatus.PLANNED;
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

    public Doctor getDoctor() {
        return doctor;
    }

    public void setDoctor(Doctor doctor) {
        this.doctor = doctor;
    }

    public Patient getPatient() {
        return patient;
    }

    public void setPatient(Patient patient) {
        this.patient = patient;
    }

    public MedicalNote getMedicalNote() {
        return medicalNote;
    }

    public void setMedicalNote(MedicalNote medicalNote) {
        this.medicalNote = medicalNote;
    }
}

