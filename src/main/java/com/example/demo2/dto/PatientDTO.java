package com.example.demo2.dto;

import com.example.demo2.enums.BloodType;
import com.example.demo2.enums.Gender;
import java.time.LocalDate;
import java.util.UUID;

public class PatientDTO {
    private UUID id;
    private String nom;
    private String email;
    private String cin;
    private LocalDate dateNaissance;
    private Gender sexe;
    private String adresse;
    private String telephone;
    private BloodType sang;
    private boolean actif;

    // Constructors
    public PatientDTO() {
    }

    // Getters and Setters
    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

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

    public boolean isActif() {
        return actif;
    }

    public void setActif(boolean actif) {
        this.actif = actif;
    }
}

