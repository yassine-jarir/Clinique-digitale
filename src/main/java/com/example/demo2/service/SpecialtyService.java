package com.example.demo2.service;

import com.example.demo2.dto.SpecialtyDTO;
import com.example.demo2.entity.Department;
import com.example.demo2.entity.Specialty;
import com.example.demo2.mapper.SpecialtyMapper;
import com.example.demo2.repository.DepartmentRepository;
import com.example.demo2.repository.SpecialtyRepository;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

public class SpecialtyService {

    private final SpecialtyRepository specialtyRepository;
    private final DepartmentRepository departmentRepository;

    public SpecialtyService() {
        this.specialtyRepository = new SpecialtyRepository();
        this.departmentRepository = new DepartmentRepository();
    }

    public SpecialtyDTO createSpecialty(SpecialtyDTO specialtyDTO) {
        Specialty specialty = new Specialty();
        specialty.setNom(specialtyDTO.getNom());
        specialty.setDescription(specialtyDTO.getDescription());

        if (specialtyDTO.getDepartmentId() != null) {
            Department department = departmentRepository.findById(specialtyDTO.getDepartmentId())
                    .orElseThrow(() -> new RuntimeException("Department not found"));
            specialty.setDepartment(department);
        }

        specialtyRepository.save(specialty);
        return SpecialtyMapper.toDTO(specialty);
    }

    public SpecialtyDTO updateSpecialty(UUID id, SpecialtyDTO specialtyDTO) {
        Specialty specialty = specialtyRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Specialty not found"));

        specialty.setNom(specialtyDTO.getNom());
        specialty.setDescription(specialtyDTO.getDescription());

        if (specialtyDTO.getDepartmentId() != null) {
            Department department = departmentRepository.findById(specialtyDTO.getDepartmentId())
                    .orElseThrow(() -> new RuntimeException("Department not found"));
            specialty.setDepartment(department);
        }

        specialtyRepository.update(specialty);
        return SpecialtyMapper.toDTO(specialty);
    }

    public void deleteSpecialty(UUID id) {
        specialtyRepository.delete(id);
    }

    public SpecialtyDTO getSpecialtyById(UUID id) {
        Specialty specialty = specialtyRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Specialty not found"));
        return SpecialtyMapper.toDTO(specialty);
    }

    public List<SpecialtyDTO> getAllSpecialties() {
        return specialtyRepository.findAll().stream()
                .map(SpecialtyMapper::toDTO)
                .collect(Collectors.toList());
    }

    public List<SpecialtyDTO> getSpecialtiesByDepartment(UUID departmentId) {
        return specialtyRepository.findByDepartmentId(departmentId).stream()
                .map(SpecialtyMapper::toDTO)
                .collect(Collectors.toList());
    }
}
