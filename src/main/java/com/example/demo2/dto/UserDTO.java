package com.example.demo2.dto;

import com.example.demo2.enums.UserRole;
import java.util.UUID;

public class UserDTO {
    private UUID id;
    private String nom;
    private String email;
    private UserRole role;
    private boolean actif;
    
    // Constructors
    public UserDTO() {
    }
    
    public UserDTO(UUID id, String nom, String email, UserRole role, boolean actif) {
        this.id = id;
        this.nom = nom;
        this.email = email;
        this.role = role;
        this.actif = actif;
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
    
    public UserRole getRole() {
        return role;
    }
    
    public void setRole(UserRole role) {
        this.role = role;
    }
    
    public boolean isActif() {
        return actif;
    }
    
    public void setActif(boolean actif) {
        this.actif = actif;
    }
}

