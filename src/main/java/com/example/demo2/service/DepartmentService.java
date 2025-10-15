package com.example.demo2.service;
import com.example.demo2.dto.DepartmentDTO;

import com.example.demo2.entity.Department;
import com.example.demo2.mapper.DepartmentMapper;
import com.example.demo2.repository.DepartmentRepository;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

public class DepartmentService {

    private final DepartmentRepository departmentRepository;

    public DepartmentService() {
        this.departmentRepository = new DepartmentRepository();
    }

    public DepartmentDTO createDepartment(DepartmentDTO departmentDTO) {
        Department department = new Department();
        department.setNom(departmentDTO.getNom());
        department.setDescription(departmentDTO.getDescription());

        departmentRepository.save(department);
        return DepartmentMapper.toDTO(department);
    }

    public DepartmentDTO updateDepartment(UUID id, DepartmentDTO departmentDTO) {
        Department department = departmentRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Department not found"));

        department.setNom(departmentDTO.getNom());
        department.setDescription(departmentDTO.getDescription());

        departmentRepository.update(department);
        return DepartmentMapper.toDTO(department);
    }

    public void deleteDepartment(UUID id) {
        departmentRepository.delete(id);
    }

    public DepartmentDTO getDepartmentById(UUID id) {
        Department department = departmentRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Department not found"));
        return DepartmentMapper.toDTO(department);
    }

    public List<DepartmentDTO> getAllDepartments() {
        return departmentRepository.findAll().stream()
                .map(department -> {
                    DepartmentDTO dto = DepartmentMapper.toDTO(department);
                    long count = departmentRepository.countSpecialtiesByDepartmentId(department.getId());
                    dto.setSpecialtyCount((int) count);
                    return dto;
                })
                .collect(Collectors.toList());
    }
}
