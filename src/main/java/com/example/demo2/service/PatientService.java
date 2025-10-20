package com.example.demo2.service;

import com.example.demo2.dto.AvailabilityDTO;
import com.example.demo2.dto.DoctorDTO;
import com.example.demo2.dto.SpecialtyDTO;
import com.example.demo2.entity.Availability;
import com.example.demo2.entity.Doctor;
import com.example.demo2.entity.Specialty;
import com.example.demo2.repository.AvailabilityRepository;
import com.example.demo2.repository.PatientRepository;
import com.example.demo2.repository.SpecialtyRepository;
import java.util.List;
import java.util.UUID;

public class PatientService {

    private PatientRepository pationtRespository = new PatientRepository();
    private SpecialtyRepository specialtyRepository = new SpecialtyRepository();
    private AvailabilityRepository availabilityRepository = new AvailabilityRepository();

    public List<SpecialtyDTO> getAllSpecialties() {
        List<Specialty> specialties = specialtyRepository.findAll();
        System.out.println("DEBUG: Found " + specialties.size() + " specialties");
        return specialties.stream().map(s -> {
            SpecialtyDTO dto = new SpecialtyDTO();
            dto.setId(s.getId());
            dto.setNom(s.getNom());
            dto.setDescription(s.getDescription());
            return dto;
        }).toList();
    }

    public List<DoctorDTO> getAllDoctors(){
        List<Doctor> doctors = pationtRespository.findAllDoctores();
        System.out.println("DEBUG: Found " + doctors.size() + " doctors");

        return doctors.stream().map(d ->{
            DoctorDTO dto = new DoctorDTO();
            dto.setId(d.getId());
            dto.setNom(d.getNom());
            dto.setEmail(d.getEmail());
            dto.setMatricule(d.getMatricule());
            dto.setTitre(d.getTitre());
            if(d.getSpecialite() != null){
                dto.setSpecialiteId(d.getSpecialite().getId());
                dto.setSpecialiteNom(d.getSpecialite().getNom());
                System.out.println("DEBUG: Doctor " + d.getNom() + " has specialty: " + d.getSpecialite().getNom());
            } else {
                System.out.println("DEBUG: Doctor " + d.getNom() + " has no specialty");
            }
            dto.setActif(d.isActif());
            return dto;
        }).toList();
    }

    public List<DoctorDTO> getDoctorsBySpecialty(UUID specialtyId) {
        List<Doctor> doctors = pationtRespository.findDoctoresBySpecialty(specialtyId);
        System.out.println("DEBUG: Found " + doctors.size() + " doctors for specialty " + specialtyId);

        return doctors.stream().map(d ->{
            DoctorDTO dto = new DoctorDTO();
            dto.setId(d.getId());
            dto.setNom(d.getNom());
            dto.setEmail(d.getEmail());
            dto.setMatricule(d.getMatricule());
            dto.setTitre(d.getTitre());
            if(d.getSpecialite() != null){
                dto.setSpecialiteId(d.getSpecialite().getId());
                dto.setSpecialiteNom(d.getSpecialite().getNom());
            }
            dto.setActif(d.isActif());

            // Load availabilities for this doctor
            List<Availability> availabilities = availabilityRepository.findByDoctorId(d.getId());
            List<AvailabilityDTO> availabilityDTOs = availabilities.stream()
                .filter(a -> a.getValide() != null && a.getValide()) // Only valid availabilities
                .map(a -> {
                    AvailabilityDTO availDTO = new AvailabilityDTO();
                    availDTO.setId(a.getId());
                    availDTO.setJour(a.getJour());
                    availDTO.setHeureDebut(a.getHeureDebut());
                    availDTO.setHeureFin(a.getHeureFin());
                    availDTO.setStatut(a.getStatut());
                    availDTO.setValide(a.getValide());
                    return availDTO;
                }).toList();
            dto.setDisponibilites(availabilityDTOs);

            return dto;
        }).toList();
    }
}
