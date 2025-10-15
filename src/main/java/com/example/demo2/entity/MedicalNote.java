package com.example.demo2.entity;

import jakarta.persistence.*;
import java.util.UUID;

@Entity
@Table(name = "medical_notes")
public class MedicalNote {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String contenu;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "appointment_id", unique = true)
    private Appointment appointment;

    @Column(name = "locked")
    private boolean locked = false;

    // Constructors
    public MedicalNote() {
    }

    public MedicalNote(String contenu, Appointment appointment) {
        this.contenu = contenu;
        this.appointment = appointment;
    }

    // Getters and Setters
    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getContenu() {
        return contenu;
    }

    public void setContenu(String contenu) {
        if (!locked) {
            this.contenu = contenu;
        } else {
            throw new IllegalStateException("Cannot modify locked medical note");
        }
    }

    public Appointment getAppointment() {
        return appointment;
    }

    public void setAppointment(Appointment appointment) {
        this.appointment = appointment;
    }

    public boolean isLocked() {
        return locked;
    }

    public void lock() {
        this.locked = true;
    }
}
