package com.example.demo2.dto;

import java.util.UUID;

public class SpecialtyDTO {
    private UUID id;
    private String nom;
    private String description;
    private UUID departmentId;
    private String departmentNom;

    // Constructors
    public SpecialtyDTO() {
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

    public UUID getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(UUID departmentId) {
        this.departmentId = departmentId;
    }

    public String getDepartmentNom() {
        return departmentNom;
    }

    public void setDepartmentNom(String departmentNom) {
        this.departmentNom = departmentNom;
    }
}

