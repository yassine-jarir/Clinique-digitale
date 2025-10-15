package com.example.demo2.servlet;

import com.example.demo2.dto.DepartmentDTO;
import com.example.demo2.dto.SpecialtyDTO;
import com.example.demo2.service.DepartmentService;
import com.example.demo2.service.SpecialtyService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

@WebServlet("/admin/specialties")
public class SpecialtyServlet extends HttpServlet {

    private final SpecialtyService specialtyService = new SpecialtyService();
    private final DepartmentService departmentService = new DepartmentService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        if (!"ADMIN".equals(session.getAttribute("role"))) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied: Admins only.");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("edit".equals(action)) {
                String idStr = request.getParameter("id");
                if (idStr != null) {
                    UUID id = UUID.fromString(idStr);
                    SpecialtyDTO specialty = specialtyService.getSpecialtyById(id);
                    request.setAttribute("specialty", specialty);
                    request.setAttribute("action", "edit");
                }
            }

            List<SpecialtyDTO> specialties = specialtyService.getAllSpecialties();
            List<DepartmentDTO> departments = departmentService.getAllDepartments();

            request.setAttribute("specialties", specialties);
            request.setAttribute("departments", departments);

            // Check if this is an AJAX request or if content parameter is present
            String contentParam = request.getParameter("content");
            String ajaxHeader = request.getHeader("X-Requested-With");
            boolean isAjax = "XMLHttpRequest".equals(ajaxHeader) || "specialties".equals(contentParam);

            // Serve content-only version for AJAX requests
            if (isAjax) {
                request.getRequestDispatcher("/WEB-INF/views/admin/content/specialties-content.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("/WEB-INF/views/admin/specialties.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading specialties: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/admin/specialties.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        if (!"ADMIN".equals(session.getAttribute("role"))) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied: Admins only.");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("delete".equals(action)) {
                String idStr = request.getParameter("id");
                if (idStr != null) {
                    UUID id = UUID.fromString(idStr);
                    specialtyService.deleteSpecialty(id);
                    request.getSession().setAttribute("success", "Specialty deleted successfully!");
                }
            } else {
                String nom = request.getParameter("nom");
                String description = request.getParameter("description");
                String departmentIdStr = request.getParameter("departmentId");

                SpecialtyDTO specialtyDTO = new SpecialtyDTO();
                specialtyDTO.setNom(nom);
                specialtyDTO.setDescription(description);

                if (departmentIdStr != null && !departmentIdStr.isEmpty()) {
                    specialtyDTO.setDepartmentId(UUID.fromString(departmentIdStr));
                }

                String idStr = request.getParameter("id");
                if (idStr != null && !idStr.isEmpty()) {
                    // Update
                    UUID id = UUID.fromString(idStr);
                    specialtyService.updateSpecialty(id, specialtyDTO);
                    request.getSession().setAttribute("success", "Specialty updated successfully!");
                } else {
                    // Create
                    specialtyService.createSpecialty(specialtyDTO);
                    request.getSession().setAttribute("success", "Specialty created successfully!");
                }
            }

            response.sendRedirect(request.getContextPath() + "/admin/dashboard#specialties");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
            doGet(request, response);
        }
    }
}
