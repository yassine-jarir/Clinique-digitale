package com.example.demo2.dto;

import java.util.List;
import java.util.UUID;

public class DoctorDTO {
    private UUID id;
    private String nom;
    private String email;
    private String matricule;
    private String titre;
    private UUID specialiteId;
    private String specialiteNom;
    private boolean actif;
    private List<AvailabilityDTO> disponibilites;

    // Constructors
    public DoctorDTO() {

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

    public UUID getSpecialiteId() {
        return specialiteId;
    }

    public void setSpecialiteId(UUID specialiteId) {
        this.specialiteId = specialiteId;
    }

    public String getSpecialiteNom() {
        return specialiteNom;
    }

    public void setSpecialiteNom(String specialiteNom) {
        this.specialiteNom = specialiteNom;
    }

    public boolean isActif() {
        return actif;
    }

    public void setActif(boolean actif) {
        this.actif = actif;
    }

    public List<AvailabilityDTO> getDisponibilites() {
        return disponibilites;
    }

    public void setDisponibilites(List<AvailabilityDTO> disponibilites) {
        this.disponibilites = disponibilites;
    }
}
