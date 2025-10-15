package com.example.demo2.mapper;

import com.example.demo2.dto.SpecialtyDTO;
import com.example.demo2.entity.Specialty;

public class SpecialtyMapper {

    public static SpecialtyDTO toDTO(Specialty specialty) {
        if (specialty == null) {
            return null;
        }

        SpecialtyDTO dto = new SpecialtyDTO();
        dto.setId(specialty.getId());
        dto.setNom(specialty.getNom());
        dto.setDescription(specialty.getDescription());

        if (specialty.getDepartment() != null) {
            dto.setDepartmentId(specialty.getDepartment().getId());
            dto.setDepartmentNom(specialty.getDepartment().getNom());
        }

        return dto;
    }

    public static Specialty toEntity(SpecialtyDTO dto) {
        if (dto == null) {
            return null;
        }

        Specialty specialty = new Specialty();
        specialty.setId(dto.getId());
        specialty.setNom(dto.getNom());
        specialty.setDescription(dto.getDescription());

        return specialty;
    }
}

