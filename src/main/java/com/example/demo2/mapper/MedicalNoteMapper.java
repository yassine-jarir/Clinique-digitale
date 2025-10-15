package com.example.demo2.mapper;

import com.example.demo2.dto.MedicalNoteDTO;
import com.example.demo2.entity.MedicalNote;

public class MedicalNoteMapper {

    public static MedicalNoteDTO toDTO(MedicalNote medicalNote) {
        if (medicalNote == null) {
            return null;
        }

        MedicalNoteDTO dto = new MedicalNoteDTO();
        dto.setId(medicalNote.getId());
        dto.setContenu(medicalNote.getContenu());
        dto.setLocked(medicalNote.isLocked());

        if (medicalNote.getAppointment() != null) {
            dto.setAppointmentId(medicalNote.getAppointment().getId());
        }

        return dto;
    }

    public static MedicalNote toEntity(MedicalNoteDTO dto) {
        if (dto == null) {
            return null;
        }

        MedicalNote medicalNote = new MedicalNote();
        medicalNote.setId(dto.getId());
        medicalNote.setContenu(dto.getContenu());

        return medicalNote;
    }
}

