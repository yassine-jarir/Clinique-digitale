package com.example.demo2.mapper;

import com.example.demo2.dto.AvailabilityDTO;
import com.example.demo2.entity.Availability;

public class AvailabilityMapper {

    public static AvailabilityDTO toDTO(Availability availability) {
        if (availability == null) {
            return null;
        }

        AvailabilityDTO dto = new AvailabilityDTO();
        dto.setId(availability.getId());
        dto.setJour(availability.getJour());
        dto.setHeureDebut(availability.getHeureDebut());
        dto.setHeureFin(availability.getHeureFin());
        dto.setStatut(availability.getStatut());
        dto.setValide(availability.getValide());

        if (availability.getDoctor() != null) {
            dto.setDoctorId(availability.getDoctor().getId());
            dto.setDoctorNom(availability.getDoctor().getNom());
        }

        return dto;
    }

    public static Availability toEntity(AvailabilityDTO dto) {
        if (dto == null) {
            return null;
        }

        Availability availability = new Availability();
        availability.setId(dto.getId());
        availability.setJour(dto.getJour());
        availability.setHeureDebut(dto.getHeureDebut());
        availability.setHeureFin(dto.getHeureFin());
        availability.setStatut(dto.getStatut());
        availability.setValide(dto.getValide());

        return availability;
    }
}

