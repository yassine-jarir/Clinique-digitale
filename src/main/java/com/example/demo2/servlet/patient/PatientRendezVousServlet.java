package com.example.demo2.servlet.patient;

import com.example.demo2.dto.UserDTO;
import com.example.demo2.enums.UserRole;
import com.example.demo2.service.PatientService;
import com.example.demo2.service.DepartmentService;
import com.example.demo2.service.SpecialtyService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.UUID;

@WebServlet(name = "patientrendezvousServlet", urlPatterns = {"/patient/rendezvous"})
public class PatientRendezVousServlet extends HttpServlet {
    private final PatientService patientService = new PatientService();
    private final DepartmentService departmentService = new DepartmentService();
    private final SpecialtyService specialtyService = new SpecialtyService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        var session = req.getSession(false);
        if (req.getParameter("dev") != null && req.getParameter("dev").equals("true")) {
            UserDTO devUser = new UserDTO();
            devUser.setId(UUID.randomUUID());
            devUser.setNom("DevPatient");
            devUser.setEmail("dev@local");
            devUser.setRole(UserRole.PATIENT);
            devUser.setActif(true);
            session = req.getSession(true);
            session.setAttribute("user", devUser);
            session.setAttribute("userId", devUser.getId());
            session.setAttribute("userRole", devUser.getRole());
            session.setAttribute("role", devUser.getRole().toString());
            session.setAttribute("nom", devUser.getNom());
        }

        UserDTO user = (session != null) ? (UserDTO) session.getAttribute("user") : null;

        if (user == null || user.getRole() != UserRole.PATIENT) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String departmentIdParam = req.getParameter("departmentId");
        String specialtyIdParam = req.getParameter("specialtyId");

        // Load all departments
        var allDepartments = departmentService.getAllDepartments();
        req.setAttribute("allDepartments", allDepartments);
        System.out.println("=== DEBUG: Loaded " + allDepartments.size() + " departments ===");

        // If department is selected, load its specialties
        if (departmentIdParam != null && !departmentIdParam.isEmpty()) {
            req.setAttribute("selectedDepartmentId", departmentIdParam);
            var specialties = specialtyService.getSpecialtiesByDepartment(UUID.fromString(departmentIdParam));
            req.setAttribute("departmentSpecialties", specialties);
            System.out.println("=== DEBUG: Loaded " + specialties.size() + " specialties for department " + departmentIdParam + " ===");
        }

        // If specialty is selected, load its doctors
        if (specialtyIdParam != null && !specialtyIdParam.isEmpty()) {
            req.setAttribute("selectedSpecialtyId", specialtyIdParam);
            var doctors = patientService.getDoctorsBySpecialty(UUID.fromString(specialtyIdParam));
            req.setAttribute("specialtyDoctors", doctors);
            System.out.println("=== DEBUG: Loaded " + doctors.size() + " doctors for specialty " + specialtyIdParam + " ===");
        }

        req.getRequestDispatcher("/WEB-INF/views/patient/rendezvous.jsp").forward(req, resp);
    }

}
