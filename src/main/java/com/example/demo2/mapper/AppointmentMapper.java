package com.example.demo2.mapper;

import com.example.demo2.dto.AppointmentDTO;
import com.example.demo2.entity.Appointment;

public class AppointmentMapper {

    public static AppointmentDTO toDTO(Appointment appointment) {
        if (appointment == null) {
            return null;
        }

        AppointmentDTO dto = new AppointmentDTO();
        dto.setId(appointment.getId());
        dto.setDateRdv(appointment.getDateRdv());
        dto.setHeure(appointment.getHeure());
        dto.setStatut(appointment.getStatut());
        dto.setType(appointment.getType());

        if (appointment.getDoctor() != null) {
            dto.setDoctorId(appointment.getDoctor().getId());
            dto.setDoctorNom(appointment.getDoctor().getNom());
        }

        if (appointment.getPatient() != null) {
            dto.setPatientId(appointment.getPatient().getId());
            dto.setPatientNom(appointment.getPatient().getNom());
        }

        dto.setHasMedicalNote(appointment.getMedicalNote() != null);

        return dto;
    }

    public static Appointment toEntity(AppointmentDTO dto) {
        if (dto == null) {
            return null;
        }

        Appointment appointment = new Appointment();
        appointment.setId(dto.getId());
        appointment.setDateRdv(dto.getDateRdv());
        appointment.setHeure(dto.getHeure());
        appointment.setStatut(dto.getStatut());
        appointment.setType(dto.getType());

        return appointment;
    }
}

