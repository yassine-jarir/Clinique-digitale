<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- Accounts Content Only (no layout) -->
<!-- Page Header -->
<div class="page-header">
    <h1><i class="fas fa-users-cog"></i> Gestion des Comptes</h1>
</div>

<!-- Success Messages -->
<c:if test="${param.success == 'created'}">
    <div class="alert alert-success">
        <i class="fas fa-check-circle"></i>
        <span>Compte créé avec succès!</span>
    </div>
</c:if>

<c:if test="${param.success == 'deleted'}">
    <div class="alert alert-success">
        <i class="fas fa-check-circle"></i>
        <span>Compte supprimé avec succès!</span>
    </div>
</c:if>

<c:if test="${param.success == 'roleUpdated'}">
    <div class="alert alert-success">
        <i class="fas fa-check-circle"></i>
        <span>Rôle mis à jour avec succès!</span>
    </div>
</c:if>

<c:if test="${param.success == 'statusToggled'}">
    <div class="alert alert-success">
        <i class="fas fa-check-circle"></i>
        <span>Statut du compte modifié avec succès!</span>
    </div>
</c:if>

<c:if test="${param.error == 'update'}">
    <div class="alert alert-error">
        <i class="fas fa-exclamation-circle"></i>
        <span>Erreur lors de la mise à jour du rôle!</span>
    </div>
</c:if>

<!-- Create Account Section -->
<div class="tabs-container" style="margin-bottom: 40px;">
    <h2 style="margin-bottom: 25px; color: #2d3748;">Créer un Nouveau Compte</h2>
    <div class="create-buttons" style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px;">
        <a href="${pageContext.request.contextPath}/admin/accounts?action=createForm&type=PATIENT" class="create-card patient" style="padding: 30px; border: 2px solid #e2e8f0; border-radius: 15px; text-align: center; text-decoration: none; color: inherit; transition: all 0.3s;">
            <i class="fas fa-user-injured" style="font-size: 48px; color: #4facfe; display: block; margin-bottom: 15px;"></i>
            <h3 style="font-size: 20px; margin-bottom: 8px; color: #2d3748;">Patient</h3>
            <p style="color: #a0aec0; font-size: 14px;">Créer un compte patient</p>
        </a>

        <a href="${pageContext.request.contextPath}/admin/accounts?action=createForm&type=DOCTOR" class="create-card doctor" style="padding: 30px; border: 2px solid #e2e8f0; border-radius: 15px; text-align: center; text-decoration: none; color: inherit; transition: all 0.3s;">
            <i class="fas fa-user-md" style="font-size: 48px; color: #667eea; display: block; margin-bottom: 15px;"></i>
            <h3 style="font-size: 20px; margin-bottom: 8px; color: #2d3748;">Docteur</h3>
            <p style="color: #a0aec0; font-size: 14px;">Créer un compte docteur</p>
        </a>

        <a href="${pageContext.request.contextPath}/admin/accounts?action=createForm&type=STAFF" class="create-card staff" style="padding: 30px; border: 2px solid #e2e8f0; border-radius: 15px; text-align: center; text-decoration: none; color: inherit; transition: all 0.3s;">
            <i class="fas fa-user-tie" style="font-size: 48px; color: #43e97b; display: block; margin-bottom: 15px;"></i>
            <h3 style="font-size: 20px; margin-bottom: 8px; color: #2d3748;">Staff</h3>
            <p style="color: #a0aec0; font-size: 14px;">Créer un compte staff</p>
        </a>
    </div>
</div>

<!-- Accounts List -->
<div class="tabs-container" style="background: white; border-radius: 15px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); padding: 20px;">
    <div class="tabs" style="display: flex; gap: 10px; border-bottom: 2px solid #f0f2f5; margin-bottom: 25px;">
        <button class="tab active" onclick="showTab('patients')" style="padding: 12px 24px; background: none; border: none; color: #667eea; font-size: 15px; font-weight: 600; cursor: pointer; position: relative;">
            <i class="fas fa-user-injured"></i> Patients
        </button>
        <button class="tab" onclick="showTab('doctors')" style="padding: 12px 24px; background: none; border: none; color: #a0aec0; font-size: 15px; font-weight: 600; cursor: pointer;">
            <i class="fas fa-user-md"></i> Docteurs
        </button>
        <button class="tab" onclick="showTab('staff')" style="padding: 12px 24px; background: none; border: none; color: #a0aec0; font-size: 15px; font-weight: 600; cursor: pointer;">
            <i class="fas fa-user-tie"></i> Staff
        </button>
    </div>

    <!-- Patients Tab -->
    <div id="patients" class="tab-content active">
        <c:choose>
            <c:when test="${empty patients}">
                <div class="empty-state" style="text-align: center; padding: 60px 20px; color: #a0aec0;">
                    <i class="fas fa-user-injured" style="font-size: 64px; margin-bottom: 20px;"></i>
                    <h3 style="font-size: 20px; margin-bottom: 10px;">Aucun patient trouvé</h3>
                    <p>Commencez par créer un compte patient</p>
                </div>
            </c:when>
            <c:otherwise>
                <table class="appointments-table">
                    <thead>
                        <tr>
                            <th>Nom</th>
                            <th>Email</th>
                            <th>CIN</th>
                            <th>Téléphone</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${patients}" var="patient">
                            <tr>
                                <td><strong>${patient.nom}</strong></td>
                                <td>${patient.email}</td>
                                <td>${patient.cin}</td>
                                <td>${patient.telephone}</td>
                                <td>
                                    <span class="count-badge" style="${patient.actif ? 'background: #c6f6d5; color: #22543d;' : 'background: #fed7d7; color: #742a2a;'}">
                                        ${patient.actif ? 'Actif' : 'Inactif'}
                                    </span>
                                </td>
                                <td>
                                    <div style="display: flex; gap: 8px;">
                                        <a href="${pageContext.request.contextPath}/admin/accounts?action=toggleStatus&type=PATIENT&id=${patient.id}"
                                           class="btn btn-primary" style="padding: 8px 16px; font-size: 13px;"
                                           title="Changer le statut">
                                            <i class="fas fa-power-off"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/accounts?action=delete&type=PATIENT&id=${patient.id}"
                                           class="btn btn-danger" style="padding: 8px 16px; font-size: 13px;"
                                           onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce patient?')"
                                           title="Supprimer">
                                            <i class="fas fa-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Doctors Tab -->
    <div id="doctors" class="tab-content" style="display: none;">
        <c:choose>
            <c:when test="${empty doctors}">
                <div class="empty-state" style="text-align: center; padding: 60px 20px; color: #a0aec0;">
                    <i class="fas fa-user-md" style="font-size: 64px; margin-bottom: 20px;"></i>
                    <h3 style="font-size: 20px; margin-bottom: 10px;">Aucun docteur trouvé</h3>
                    <p>Commencez par créer un compte docteur</p>
                </div>
            </c:when>
            <c:otherwise>
                <table class="appointments-table">
                    <thead>
                        <tr>
                            <th>Nom</th>
                            <th>Email</th>
                            <th>Matricule</th>
                            <th>Spécialité</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${doctors}" var="doctor">
                            <tr>
                                <td><strong>${doctor.nom}</strong></td>
                                <td>${doctor.email}</td>
                                <td>${doctor.matricule}</td>
                                <td>${doctor.specialite != null ? doctor.specialite.nom : 'N/A'}</td>
                                <td>
                                    <span class="count-badge" style="${doctor.actif ? 'background: #c6f6d5; color: #22543d;' : 'background: #fed7d7; color: #742a2a;'}">
                                        ${doctor.actif ? 'Actif' : 'Inactif'}
                                    </span>
                                </td>
                                <td>
                                    <div style="display: flex; gap: 8px;">
                                        <a href="${pageContext.request.contextPath}/admin/accounts?action=toggleStatus&type=DOCTOR&id=${doctor.id}"
                                           class="btn btn-primary" style="padding: 8px 16px; font-size: 13px;"
                                           title="Changer le statut">
                                            <i class="fas fa-power-off"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/accounts?action=delete&type=DOCTOR&id=${doctor.id}"
                                           class="btn btn-danger" style="padding: 8px 16px; font-size: 13px;"
                                           onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce docteur?')"
                                           title="Supprimer">
                                            <i class="fas fa-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Staff Tab -->
    <div id="staff" class="tab-content" style="display: none;">
        <c:choose>
            <c:when test="${empty staff}">
                <div class="empty-state" style="text-align: center; padding: 60px 20px; color: #a0aec0;">
                    <i class="fas fa-user-tie" style="font-size: 64px; margin-bottom: 20px;"></i>
                    <h3 style="font-size: 20px; margin-bottom: 10px;">Aucun staff trouvé</h3>
                    <p>Commencez par créer un compte staff</p>
                </div>
            </c:when>
            <c:otherwise>
                <table class="appointments-table">
                    <thead>
                        <tr>
                            <th>Nom</th>
                            <th>Email</th>
                            <th>Rôle</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${staff}" var="user">
                            <tr>
                                <td><strong>${user.nom}</strong></td>
                                <td>${user.email}</td>
                                <td>
                                    <span class="count-badge" style="background: rgba(67, 233, 123, 0.2); color: #43e97b;">
                                        ${user.role}
                                    </span>
                                </td>
                                <td>
                                    <span class="count-badge" style="${user.actif ? 'background: #c6f6d5; color: #22543d;' : 'background: #fed7d7; color: #742a2a;'}">
                                        ${user.actif ? 'Actif' : 'Inactif'}
                                    </span>
                                </td>
                                <td>
                                    <div style="display: flex; gap: 8px;">
                                        <a href="${pageContext.request.contextPath}/admin/accounts?action=editRoleForm&type=STAFF&id=${user.id}"
                                           class="btn btn-primary" style="padding: 8px 16px; font-size: 13px;"
                                           title="Modifier le rôle">
                                            <i class="fas fa-user-shield"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/accounts?action=toggleStatus&type=STAFF&id=${user.id}"
                                           class="btn btn-primary" style="padding: 8px 16px; font-size: 13px;"
                                           title="Changer le statut">
                                            <i class="fas fa-power-off"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/accounts?action=delete&type=STAFF&id=${user.id}"
                                           class="btn btn-danger" style="padding: 8px 16px; font-size: 13px;"
                                           onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce staff?')"
                                           title="Supprimer">
                                            <i class="fas fa-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<style>
    .tab.active::after {
        content: '';
        position: absolute;
        bottom: -2px;
        left: 0;
        right: 0;
        height: 2px;
        background: #667eea;
    }

    .create-card:hover {
        border-color: #667eea !important;
        background: rgba(102, 126, 234, 0.05);
        transform: translateY(-5px);
    }
</style>

<script>
    function showTab(tabName) {
        // Hide all tab contents
        document.querySelectorAll('.tab-content').forEach(content => {
            content.style.display = 'none';
        });

        // Remove active class from all tabs
        document.querySelectorAll('.tab').forEach(tab => {
            tab.classList.remove('active');
            tab.style.color = '#a0aec0';
        });

        // Show selected tab content
        document.getElementById(tabName).style.display = 'block';

        // Add active class to selected tab
        event.target.classList.add('active');
        event.target.style.color = '#667eea';
    }
</script>

