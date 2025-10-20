package com.example.demo2.servlet;

import com.example.demo2.entity.Specialty;
import com.example.demo2.repository.DoctorRepository;
import com.example.demo2.repository.SpecialtyRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.UUID;

@WebServlet("/api/department-specialties")
public class DepartmentSpecialtiesApiServlet extends HttpServlet {
    private final SpecialtyRepository specialtyRepository = new SpecialtyRepository();
    private final DoctorRepository doctorRepository = new DoctorRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String departmentIdStr = req.getParameter("departmentId");
        if (departmentIdStr == null) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            resp.getWriter().write("{\"error\": \"departmentId is required\"}");
            return;
        }

        try {
            UUID departmentId = UUID.fromString(departmentIdStr);
            List<Specialty> specialties = specialtyRepository.findByDepartmentId(departmentId);

            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            PrintWriter out = resp.getWriter();

            out.write("[");
            for (int i = 0; i < specialties.size(); i++) {
                Specialty s = specialties.get(i);
                long count = doctorRepository.countBySpecialtyId(s.getId());
                out.write(String.format("{\"id\": \"%s\", \"nom\": \"%s\", \"doctorCount\": %d}",
                        s.getId(), escapeJson(s.getNom()), count));
                if (i < specialties.size() - 1) out.write(",");
            }
            out.write("]");
        } catch (Exception e) {
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");
        }
    }

    private String escapeJson(String s) {
        return s == null ? "" : s.replace("\\", "\\\\").replace("\"", "\\\"");
    }
}

