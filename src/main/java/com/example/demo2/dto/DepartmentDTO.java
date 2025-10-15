package com.example.demo2.dto;

import java.util.UUID;

public class DepartmentDTO {
    private UUID id;
    private String nom;
    private String description;
    private int specialtyCount;

    // Constructors
    public DepartmentDTO() {
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getSpecialtyCount() {
        return specialtyCount;
    }

    public void setSpecialtyCount(int specialtyCount) {
        this.specialtyCount = specialtyCount;
    }
}
