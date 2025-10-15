package com.example.demo2.service;

import com.example.demo2.dto.UserDTO;
import com.example.demo2.entity.User;
import com.example.demo2.entity.Patient;
import com.example.demo2.enums.UserRole;
import com.example.demo2.repository.UserRepository;
import com.example.demo2.util.PasswordUtil;

import java.util.Optional;
import java.util.UUID;

public class AuthService {
    
    private final UserRepository userRepository;
    
    public AuthService() {
        this.userRepository = new UserRepository();
    }
    
    /**
     * Authenticate user with email and password
     */
    public UserDTO login(String email, String password) {
        Optional<User> userOpt = userRepository.findByEmail(email);
        
        if (userOpt.isEmpty()) {
            return null;
        }
        
        User user = userOpt.get();
        
        // Check if user is active
        if (!user.isActif()) {
            throw new IllegalStateException("Account is deactivated. Please contact administrator.");
        }
        
        // Verify password
        if (!PasswordUtil.verifyPassword(password, user.getPassword())) {
            return null;
        }
        
        // Return user DTO
        return convertToDTO(user);
    }
    
    /**
     * Register a new patient
     */
    public boolean registerPatient(String nom, String email, String password, String cin) {
        if (userRepository.existsByEmail(email)) {
            throw new IllegalArgumentException("Email already exists");
        }
        
        Patient patient = new Patient();
        patient.setNom(nom);
        patient.setEmail(email);
        patient.setPassword(PasswordUtil.hashPassword(password));
        patient.setCin(cin);
        patient.setRole(UserRole.PATIENT);
        patient.setActif(true);
        
        userRepository.save(patient);
        return true;
    }
    
    /**
     * Change password
     */
    public boolean changePassword(UUID userId, String oldPassword, String newPassword) {
        Optional<User> userOpt = userRepository.findById(userId);
        
        if (userOpt.isEmpty()) {
            return false;
        }
        
        User user = userOpt.get();
        
        // Verify old password
        if (!PasswordUtil.verifyPassword(oldPassword, user.getPassword())) {
            return false;
        }
        
        // Update with new password
        user.setPassword(PasswordUtil.hashPassword(newPassword));
        userRepository.update(user);
        
        return true;
    }
    
    /**
     * Check database connectivity
     */
    public boolean testDatabaseConnection() {
        try {
            userRepository.findAll();
            return true;
        } catch (Exception e) {
            System.err.println("Database connection failed: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Convert User entity to UserDTO
     */
    private UserDTO convertToDTO(User user) {
        UserDTO dto = new UserDTO();
        dto.setId(user.getId());
        dto.setNom(user.getNom());
        dto.setEmail(user.getEmail());
        dto.setRole(user.getRole());
        dto.setActif(user.isActif());
        return dto;
    }
}

