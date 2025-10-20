package com.example.demo2.servlet;

import com.example.demo2.dto.DepartmentDTO;
import com.example.demo2.service.DepartmentService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

@WebServlet("/admin/departments")
public class DepartmentServlet extends HttpServlet {

    private final DepartmentService departmentService = new DepartmentService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !"ADMIN".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("edit".equals(action)) {
                String idStr = request.getParameter("id");
                if (idStr != null) {
                    UUID id = UUID.fromString(idStr);
                    DepartmentDTO department = departmentService.getDepartmentById(id);
                    request.setAttribute("department", department);
                    request.setAttribute("action", "edit");
                }
            }

            List<DepartmentDTO> departments = departmentService.getAllDepartments();
            request.setAttribute("departments", departments);

            String contentParam = request.getParameter("content");
            String ajaxHeader = request.getHeader("X-Requested-With");
            boolean isAjax = "XMLHttpRequest".equals(ajaxHeader) || "departments".equals(contentParam);

            if (isAjax) {
                request.getRequestDispatcher("/WEB-INF/views/admin/content/departments-content.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("/WEB-INF/views/admin/departments.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading departments: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/admin/departments.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !"ADMIN".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("delete".equals(action)) {
                String idStr = request.getParameter("id");
                if (idStr != null) {
                    UUID id = UUID.fromString(idStr);
                    departmentService.deleteDepartment(id);
                    request.getSession().setAttribute("success", "Department deleted successfully!");
                }
            } else {
                String nom = request.getParameter("nom");
                String description = request.getParameter("description");

                DepartmentDTO departmentDTO = new DepartmentDTO();
                departmentDTO.setNom(nom);
                departmentDTO.setDescription(description);

                String idStr = request.getParameter("id");
                if (idStr != null && !idStr.isEmpty()) {
                    UUID id = UUID.fromString(idStr);
                    departmentService.updateDepartment(id, departmentDTO);
                    request.getSession().setAttribute("success", "Department updated successfully!");
                } else {
                    departmentService.createDepartment(departmentDTO);
                    request.getSession().setAttribute("success", "Department created successfully!");
                }
            }

            response.sendRedirect(request.getContextPath() + "/admin/departments");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
            doGet(request, response);
        }
    }
}
