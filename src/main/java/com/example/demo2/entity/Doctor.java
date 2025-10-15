package com.example.demo2.entity;

import com.example.demo2.enums.UserRole;
import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "doctors")
@PrimaryKeyJoinColumn(name = "id")
public class Doctor extends User {

    @Column(nullable = false, unique = true, length = 50)
    private String matricule;

    @Column(length = 50)
    private String titre;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "specialite_id")
    private Specialty specialite;

    @OneToMany(mappedBy = "doctor", cascade = CascadeType.ALL)
    private List<Availability> availabilities = new ArrayList<>();

    @OneToMany(mappedBy = "doctor", cascade = CascadeType.ALL)
    private List<Appointment> appointments = new ArrayList<>();

    // Constructors
    public Doctor() {
        super();
        setRole(UserRole.DOCTOR);
    }

    public Doctor(String nom, String email, String password, String matricule) {
        super(nom, email, password, UserRole.DOCTOR);
        this.matricule = matricule;
    }

    // Getters and Setters
    public String getMatricule() {
        return matricule;
    }

    public void setMatricule(String matricule) {
        this.matricule = matricule;
    }

    public String getTitre() {
        return titre;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public Specialty getSpecialite() {
        return specialite;
    }

    public void setSpecialite(Specialty specialite) {
        this.specialite = specialite;
    }

    public List<Availability> getAvailabilities() {
        return availabilities;
    }

    public void setAvailabilities(List<Availability> availabilities) {
        this.availabilities = availabilities;
    }

    public List<Appointment> getAppointments() {
        return appointments;
    }

    public void setAppointments(List<Appointment> appointments) {
        this.appointments = appointments;
    }
}

