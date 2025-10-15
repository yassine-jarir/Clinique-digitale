package com.example.demo2.entity;

import com.example.demo2.enums.BloodType;
import com.example.demo2.enums.Gender;
import com.example.demo2.enums.UserRole;
import jakarta.persistence.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "patients")
@PrimaryKeyJoinColumn(name = "id")
public class Patient extends User {

    @Column(nullable = false, unique = true, length = 20)
    private String cin;

    @Column(name = "naissance")
    private LocalDate dateNaissance;

    @Enumerated(EnumType.STRING)
    @Column(length = 10)
    private Gender sexe;

    @Column(length = 200)
    private String adresse;

    @Column(length = 20)
    private String telephone;

    @Enumerated(EnumType.STRING)
    @Column(length = 10)
    private BloodType sang;

    @OneToMany(mappedBy = "patient", cascade = CascadeType.ALL)
    private List<Appointment> appointments = new ArrayList<>();

    // Constructors
    public Patient() {
        super();
        setRole(UserRole.PATIENT);
    }

    public Patient(String nom, String email, String password, String cin) {
        super(nom, email, password, UserRole.PATIENT);
        this.cin = cin;
    }

    // Getters and Setters
    public String getCin() {
        return cin;
    }

    public void setCin(String cin) {
        this.cin = cin;
    }

    public LocalDate getDateNaissance() {
        return dateNaissance;
    }

    public void setDateNaissance(LocalDate dateNaissance) {
        this.dateNaissance = dateNaissance;
    }

    public Gender getSexe() {
        return sexe;
    }

    public void setSexe(Gender sexe) {
        this.sexe = sexe;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public BloodType getSang() {
        return sang;
    }

    public void setSang(BloodType sang) {
        this.sang = sang;
    }

    public List<Appointment> getAppointments() {
        return appointments;
    }

    public void setAppointments(List<Appointment> appointments) {
        this.appointments = appointments;
    }
}

