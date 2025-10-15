package com.example.demo2.mapper;

import com.example.demo2.dto.DepartmentDTO;
import com.example.demo2.entity.Department;

public class DepartmentMapper {

    public static DepartmentDTO toDTO(Department department) {
        if (department == null) {
            return null;
        }

        DepartmentDTO dto = new DepartmentDTO();
        dto.setId(department.getId());
        dto.setNom(department.getNom());
        dto.setDescription(department.getDescription());

        return dto;
    }

    public static Department toEntity(DepartmentDTO dto) {
        if (dto == null) {
            return null;
        }

        Department department = new Department();
        department.setId(dto.getId());
        department.setNom(dto.getNom());
        department.setDescription(dto.getDescription());

        return department;
    }
}
