package com.example.demo2.mapper;

import com.example.demo2.dto.DoctorDTO;
import com.example.demo2.entity.Doctor;

public class DoctorMapper {

    public static DoctorDTO toDTO(Doctor doctor) {
        if (doctor == null) {
            return null;
        }

        DoctorDTO dto = new DoctorDTO();
        dto.setId(doctor.getId());
        dto.setNom(doctor.getNom());
        dto.setEmail(doctor.getEmail());
        dto.setMatricule(doctor.getMatricule());
        dto.setTitre(doctor.getTitre());
        dto.setActif(doctor.isActif());

        if (doctor.getSpecialite() != null) {
            dto.setSpecialiteId(doctor.getSpecialite().getId());
            dto.setSpecialiteNom(doctor.getSpecialite().getNom());
        }

        return dto;
    }

    public static Doctor toEntity(DoctorDTO dto) {
        if (dto == null) {
            return null;
        }

        Doctor doctor = new Doctor();
        doctor.setId(dto.getId());
        doctor.setNom(dto.getNom());
        doctor.setEmail(dto.getEmail());
        doctor.setMatricule(dto.getMatricule());
        doctor.setTitre(dto.getTitre());
        doctor.setActif(dto.isActif());

        return doctor;
    }
}

