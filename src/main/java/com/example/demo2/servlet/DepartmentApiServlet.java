package com.example.demo2.servlet;

import com.example.demo2.entity.Department;
import com.example.demo2.repository.DepartmentRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/api/departments")
public class DepartmentApiServlet extends HttpServlet {
    private final DepartmentRepository departmentRepository = new DepartmentRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<Department> departments = departmentRepository.findAll();

            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            PrintWriter out = resp.getWriter();

            out.write("[");
            for (int i = 0; i < departments.size(); i++) {
                Department d = departments.get(i);
                out.write(String.format("{\"id\": \"%s\", \"nom\": \"%s\"}", d.getId(), escapeJson(d.getNom())));
                if (i < departments.size() - 1) out.write(",");
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

