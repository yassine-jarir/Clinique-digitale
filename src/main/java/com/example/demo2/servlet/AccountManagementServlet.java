package com.example.demo2.servlet;

import com.example.demo2.entity.Doctor;
import com.example.demo2.entity.Patient;
import com.example.demo2.entity.User;
import com.example.demo2.enums.BloodType;
import com.example.demo2.enums.Gender;
import com.example.demo2.enums.UserRole;
import com.example.demo2.repository.DoctorRepository;
import com.example.demo2.repository.PatientRepository;
import com.example.demo2.repository.SpecialtyRepository;
import com.example.demo2.repository.UserRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;
import java.time.LocalDate;
import java.util.UUID;

@WebServlet("/admin/accounts")
public class AccountManagementServlet extends HttpServlet {

    private final PatientRepository patientRepository = new PatientRepository();
    private final DoctorRepository doctorRepository = new DoctorRepository();
    private final UserRepository userRepository = new UserRepository();
    private final SpecialtyRepository specialtyRepository = new SpecialtyRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "list":
                    listAccounts(request, response);
                    break;
                case "createForm":
                    showCreateForm(request, response);
                    break;
                case "editRoleForm":
                    showEditRoleForm(request, response);
                    break;
                case "delete":
                    deleteAccount(request, response);
                    break;
                case "toggleStatus":
                    toggleAccountStatus(request, response);
                    break;
                default:
                    listAccounts(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur: " + e.getMessage());
            listAccounts(request, response);
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if ("create".equals(action)) {
                createAccount(request, response);
            } else if ("updateRole".equals(action)) {
                updateUserRole(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors de l'opération: " + e.getMessage());
            if ("updateRole".equals(action)) {
                response.sendRedirect(request.getContextPath() + "/admin/accounts?error=update");
            } else {
                showCreateForm(request, response);
            }
        }
    }

    private void listAccounts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("patients", patientRepository.findAll());
        request.setAttribute("doctors", doctorRepository.findAll());
        request.setAttribute("staff", userRepository.findByRole(UserRole.STAFF));

        String contentParam = request.getParameter("content");
        String ajaxHeader = request.getHeader("X-Requested-With");
        boolean isAjax = "XMLHttpRequest".equals(ajaxHeader) || "accounts".equals(contentParam);

        if (isAjax) {
            request.getRequestDispatcher("/WEB-INF/views/admin/content/accounts-content.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/WEB-INF/views/admin/accounts.jsp").forward(request, response);
        }
    }
    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accountType = request.getParameter("type");
        request.setAttribute("accountType", accountType);
        request.setAttribute("specialties", specialtyRepository.findAll());

        request.getRequestDispatcher("/WEB-INF/views/admin/create-account.jsp").forward(request, response);
    }
    private void createAccount(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accountType = request.getParameter("accountType");
        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Hash password
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        switch (accountType) {
            case "PATIENT":
                createPatient(request, nom, email, hashedPassword);
                break;
            case "DOCTOR":
                // Auto-generate matricule for doctor
                String matricule = generateMatricule();
                createDoctor(request, nom, email, hashedPassword, matricule);
                break;
            case "STAFF":
                createStaff(nom, email, hashedPassword);
                break;
        }

        response.sendRedirect(request.getContextPath() + "/admin/accounts?success=created");
    }

    /**
     * Generate a unique matricule for a doctor
     * Format: DR-YYYYMMDD-XXXX (e.g., DR-20251014-0001)
     */
    private String generateMatricule() {
        // Get current date
        LocalDate now = LocalDate.now();
        String datePrefix = now.toString().replace("-", "");

        // Get count of doctors created today
        String baseMatricule = "DR-" + datePrefix + "-";

        // Try to find a unique matricule
        int counter = 1;
        String matricule;
        do {
            matricule = baseMatricule + String.format("%04d", counter);
            counter++;
        } while (doctorRepository.existsByMatricule(matricule) && counter < 10000);

        return matricule;
    }

    private void createPatient(HttpServletRequest request, String nom, String email, String hashedPassword) {
        Patient patient = new Patient(nom, email, hashedPassword, request.getParameter("cin"));

        String dateNaissance = request.getParameter("dateNaissance");
        if (dateNaissance != null && !dateNaissance.isEmpty()) {
            patient.setDateNaissance(LocalDate.parse(dateNaissance));
        }

        String sexe = request.getParameter("sexe");
        if (sexe != null && !sexe.isEmpty()) {
            patient.setSexe(Gender.valueOf(sexe));
        }

        patient.setAdresse(request.getParameter("adresse"));
        patient.setTelephone(request.getParameter("telephone"));

        String sang = request.getParameter("sang");
        if (sang != null && !sang.isEmpty()) {
            patient.setSang(BloodType.valueOf(sang));
        }

        patientRepository.save(patient);
    }

    private void createDoctor(HttpServletRequest request, String nom, String email, String hashedPassword, String matricule) {
        Doctor doctor = new Doctor(nom, email, hashedPassword, matricule);

        doctor.setTitre(request.getParameter("titre"));

        String specialtyId = request.getParameter("specialtyId");
        if (specialtyId != null && !specialtyId.isEmpty()) {
            specialtyRepository.findById(UUID.fromString(specialtyId))
                    .ifPresent(doctor::setSpecialite);
        }

        doctorRepository.save(doctor);
    }

    private void createStaff(String nom, String email, String hashedPassword) {
        User staff = new User(nom, email, hashedPassword, UserRole.STAFF);
        userRepository.save(staff);
    }

    private void deleteAccount(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String accountType = request.getParameter("type");
        String id = request.getParameter("id");

        UUID uuid = UUID.fromString(id);
        switch (accountType) {
            case "PATIENT":
                patientRepository.delete(uuid);
                break;
            case "DOCTOR":
                doctorRepository.delete(uuid);
                break;
            case "STAFF":
                userRepository.delete(uuid);
                break;
        }

        response.sendRedirect(request.getContextPath() + "/admin/accounts?success=deleted");
    }

    private void showEditRoleForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");
        String accountType = request.getParameter("type");

        request.setAttribute("accountType", accountType);

        switch (accountType) {
            case "PATIENT":
                patientRepository.findById(UUID.fromString(id)).ifPresent(patient ->
                    request.setAttribute("patient", patient));
                break;
            case "DOCTOR":
                doctorRepository.findById(UUID.fromString(id)).ifPresent(doctor ->
                    request.setAttribute("doctor", doctor));
                break;
            case "STAFF":
                userRepository.findById(UUID.fromString(id)).ifPresent(user ->
                    request.setAttribute("user", user));
                break;
        }

        request.getRequestDispatcher("/WEB-INF/views/admin/edit-role.jsp").forward(request, response);
    }

    private void updateUserRole(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String id = request.getParameter("id");
        String newRole = request.getParameter("role");

        User user = userRepository.findById(UUID.fromString(id)).orElseThrow(() -> new IllegalArgumentException("Invalid user ID"));
        user.setRole(UserRole.valueOf(newRole));

        userRepository.update(user);

        response.sendRedirect(request.getContextPath() + "/admin/accounts?success=roleUpdated");
    }

    private void toggleAccountStatus(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String id = request.getParameter("id");
        String accountType = request.getParameter("type");

        switch (accountType) {
            case "PATIENT":
                patientRepository.findById(UUID.fromString(id)).ifPresent(patient -> {
                    patient.setActif(!patient.isActif());
                    patientRepository.update(patient);
                });
                break;
            case "DOCTOR":
                doctorRepository.findById(UUID.fromString(id)).ifPresent(doctor -> {
                    doctor.setActif(!doctor.isActif());
                    doctorRepository.update(doctor);
                });
                break;
            case "STAFF":
                userRepository.findById(UUID.fromString(id)).ifPresent(user -> {
                    user.setActif(!user.isActif());
                    userRepository.update(user);
                });
                break;
        }

        response.sendRedirect(request.getContextPath() + "/admin/accounts?success=statusToggled");
    }
}
