<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Comptes - Clinique</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f0f2f5;
        }

        /* Sidebar - Same as dashboard */
        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            height: 100vh;
            width: 280px;
            background: linear-gradient(180deg, #1e3c72 0%, #2a5298 100%);
            padding: 20px 0;
            z-index: 1000;
            box-shadow: 4px 0 15px rgba(0,0,0,0.1);
        }

        .sidebar-header {
            padding: 0 20px 30px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 12px;
            color: white;
            text-decoration: none;
        }

        .logo i {
            font-size: 32px;
            color: #4fc3f7;
        }

        .logo-text h2 {
            font-size: 20px;
            font-weight: 700;
        }

        .logo-text span {
            font-size: 12px;
            opacity: 0.8;
        }

        .sidebar-menu {
            margin-top: 30px;
            padding: 0 15px;
        }

        .menu-item {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 14px 15px;
            color: rgba(255,255,255,0.8);
            text-decoration: none;
            border-radius: 10px;
            margin-bottom: 8px;
            transition: all 0.3s;
        }

        .menu-item:hover {
            background: rgba(255,255,255,0.1);
            color: white;
            transform: translateX(5px);
        }

        .menu-item.active {
            background: rgba(79, 195, 247, 0.2);
            color: white;
        }

        .menu-item i {
            font-size: 20px;
            width: 25px;
        }

        /* Main Content */
        .main-content {
            margin-left: 280px;
            padding: 30px;
        }

        .page-header {
            background: white;
            padding: 25px 30px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .page-header h1 {
            color: #2d3748;
            font-size: 28px;
            font-weight: 700;
        }

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
        }

        .btn-success {
            background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
            color: white;
        }

        .btn-danger {
            background: linear-gradient(135deg, #f56565 0%, #e53e3e 100%);
            color: white;
            padding: 8px 16px;
            font-size: 13px;
        }

        .btn-sm {
            padding: 8px 16px;
            font-size: 13px;
        }

        /* Tab Navigation */
        .tabs-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            padding: 20px;
            margin-bottom: 30px;
        }

        .tabs {
            display: flex;
            gap: 10px;
            border-bottom: 2px solid #f0f2f5;
            margin-bottom: 25px;
        }

        .tab {
            padding: 12px 24px;
            background: none;
            border: none;
            color: #a0aec0;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            position: relative;
            transition: all 0.3s;
        }

        .tab:hover {
            color: #667eea;
        }

        .tab.active {
            color: #667eea;
        }

        .tab.active::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            right: 0;
            height: 2px;
            background: #667eea;
        }

        /* Table Styles */
        .account-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
        }

        .account-table thead tr {
            background: #f7fafc;
        }

        .account-table th {
            padding: 15px;
            text-align: left;
            font-size: 13px;
            font-weight: 600;
            color: #4a5568;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .account-table th:first-child {
            border-radius: 8px 0 0 0;
        }

        .account-table th:last-child {
            border-radius: 0 8px 0 0;
        }

        .account-table td {
            padding: 15px;
            font-size: 14px;
            color: #2d3748;
            border-bottom: 1px solid #f0f2f5;
        }

        .account-table tbody tr {
            transition: all 0.3s;
        }

        .account-table tbody tr:hover {
            background: #f7fafc;
        }

        .status-badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .status-active {
            background: #c6f6d5;
            color: #22543d;
        }

        .status-inactive {
            background: #fed7d7;
            color: #742a2a;
        }

        .tab-content {
            display: none;
        }

        .tab-content.active {
            display: block;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #a0aec0;
        }

        .empty-state i {
            font-size: 64px;
            margin-bottom: 20px;
        }

        .empty-state h3 {
            font-size: 20px;
            margin-bottom: 10px;
        }

        .action-buttons {
            display: flex;
            gap: 8px;
        }

        .btn-edit {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
            padding: 8px 16px;
            font-size: 13px;
        }

        .btn-edit:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(79, 172, 254, 0.3);
        }

        .btn-toggle {
            background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
            color: white;
            padding: 8px 16px;
            font-size: 13px;
        }

        .btn-toggle:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(250, 112, 154, 0.3);
        }

        .alert {
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .alert-success {
            background: #c6f6d5;
            color: #22543d;
            border-left: 4px solid #48bb78;
        }

        .alert-error {
            background: #fed7d7;
            color: #742a2a;
            border-left: 4px solid #f56565;
        }

        .role-badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .role-admin {
            background: rgba(245, 101, 101, 0.1);
            color: #f56565;
        }

        .role-doctor {
            background: rgba(102, 126, 234, 0.1);
            color: #667eea;
        }

        .role-patient {
            background: rgba(79, 172, 254, 0.1);
            color: #4facfe;
        }

        .role-staff {
            background: rgba(67, 233, 123, 0.1);
            color: #43e97b;
        }

        .create-buttons {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }

        .create-card {
            padding: 30px;
            border: 2px solid #e2e8f0;
            border-radius: 15px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            color: inherit;
        }

        .create-card:hover {
            border-color: #667eea;
            background: rgba(102, 126, 234, 0.05);
            transform: translateY(-5px);
        }

        .create-card i {
            font-size: 48px;
            margin-bottom: 15px;
            display: block;
        }

        .create-card.patient i {
            color: #4facfe;
        }

        .create-card.doctor i {
            color: #667eea;
        }

        .create-card.staff i {
            color: #43e97b;
        }

        .create-card h3 {
            font-size: 20px;
            margin-bottom: 8px;
            color: #2d3748;
        }

        .create-card p {
            color: #a0aec0;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="logo">
                <i class="fas fa-hospital"></i>
                <div class="logo-text">
                    <h2>Clinique</h2>
                    <span>Digital Platform</span>
                </div>
            </a>
        </div>

        <nav class="sidebar-menu">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="menu-item">
                <i class="fas fa-chart-line"></i>
                <span>Dashboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/departments" class="menu-item">
                <i class="fas fa-building"></i>
                <span>Départements</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/specialties" class="menu-item">
                <i class="fas fa-stethoscope"></i>
                <span>Spécialités</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/accounts" class="menu-item active">
                <i class="fas fa-users-cog"></i>
                <span>Gestion Comptes</span>
            </a>
        </nav>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Page Header -->
        <div class="page-header">
            <h1><i class="fas fa-users-cog"></i> Gestion des Comptes</h1>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">
                <i class="fas fa-sign-out-alt"></i> Déconnexion
            </a>
        </div>

        <!-- Success Message -->
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
            <div class="create-buttons">
                <a href="${pageContext.request.contextPath}/admin/accounts?action=createForm&type=PATIENT" class="create-card patient">
                    <i class="fas fa-user-injured"></i>
                    <h3>Patient</h3>
                    <p>Créer un compte patient</p>
                </a>

                <a href="${pageContext.request.contextPath}/admin/accounts?action=createForm&type=DOCTOR" class="create-card doctor">
                    <i class="fas fa-user-md"></i>
                    <h3>Docteur</h3>
                    <p>Créer un compte docteur</p>
                </a>

                <a href="${pageContext.request.contextPath}/admin/accounts?action=createForm&type=STAFF" class="create-card staff">
                    <i class="fas fa-user-tie"></i>
                    <h3>Staff</h3>
                    <p>Créer un compte staff</p>
                </a>
            </div>
        </div>

        <!-- Accounts List -->
        <div class="tabs-container">
            <div class="tabs">
                <button class="tab active" onclick="showTab('patients')">
                    <i class="fas fa-user-injured"></i> Patients
                </button>
                <button class="tab" onclick="showTab('doctors')">
                    <i class="fas fa-user-md"></i> Docteurs
                </button>
                <button class="tab" onclick="showTab('staff')">
                    <i class="fas fa-user-tie"></i> Staff
                </button>
            </div>

            <!-- Patients Tab -->
            <div id="patients" class="tab-content active">
                <c:choose>
                    <c:when test="${empty patients}">
                        <div class="empty-state">
                            <i class="fas fa-user-injured"></i>
                            <h3>Aucun patient trouvé</h3>
                            <p>Commencez par créer un compte patient</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <table class="account-table">
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
                                            <span class="status-badge ${patient.actif ? 'status-active' : 'status-inactive'}">
                                                ${patient.actif ? 'Actif' : 'Inactif'}
                                            </span>
                                        </td>
                                        <td>
                                            <div class="action-buttons">
                                                <a href="${pageContext.request.contextPath}/admin/accounts?action=editRoleForm&type=PATIENT&id=${patient.id}"
                                                   class="btn btn-edit btn-sm"
                                                   title="Modifier le rôle">
                                                    <i class="fas fa-user-shield"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/admin/accounts?action=toggleStatus&type=PATIENT&id=${patient.id}"
                                                   class="btn btn-toggle btn-sm"
                                                   title="Changer le statut">
                                                    <i class="fas fa-power-off"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/admin/accounts?action=delete&type=PATIENT&id=${patient.id}"
                                                   class="btn btn-danger btn-sm"
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
            <div id="doctors" class="tab-content">
                <c:choose>
                    <c:when test="${empty doctors}">
                        <div class="empty-state">
                            <i class="fas fa-user-md"></i>
                            <h3>Aucun docteur trouvé</h3>
                            <p>Commencez par créer un compte docteur</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <table class="account-table">
                            <thead>
                                <tr>
                                    <th>Nom</th>
                                    <th>Email</th>
                                    <th>Matricule</th>
                                    <th>Titre</th>
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
                                        <td>${doctor.titre}</td>
                                        <td>${doctor.specialite != null ? doctor.specialite.nom : 'N/A'}</td>
                                        <td>
                                            <span class="status-badge ${doctor.actif ? 'status-active' : 'status-inactive'}">
                                                ${doctor.actif ? 'Actif' : 'Inactif'}
                                            </span>
                                        </td>
                                        <td>
                                            <div class="action-buttons">
                                                <a href="${pageContext.request.contextPath}/admin/accounts?action=delete&type=DOCTOR&id=${doctor.id}"
                                                   class="btn btn-danger btn-sm"
                                                   onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce docteur?')">
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
            <div id="staff" class="tab-content">
                <c:choose>
                    <c:when test="${empty staff}">
                        <div class="empty-state">
                            <i class="fas fa-user-tie"></i>
                            <h3>Aucun staff trouvé</h3>
                            <p>Commencez par créer un compte staff</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <table class="account-table">
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
                                <c:forEach items="${staff}" var="staffMember">
                                    <tr>
                                        <td><strong>${staffMember.nom}</strong></td>
                                        <td>${staffMember.email}</td>
                                        <td>Staff</td>
                                        <td>
                                            <span class="status-badge ${staffMember.actif ? 'status-active' : 'status-inactive'}">
                                                ${staffMember.actif ? 'Actif' : 'Inactif'}
                                            </span>
                                        </td>
                                        <td>
                                            <div class="action-buttons">
                                                <a href="${pageContext.request.contextPath}/admin/accounts?action=editRoleForm&type=STAFF&id=${staffMember.id}"
                                                   class="btn btn-edit btn-sm"
                                                   title="Modifier le rôle">
                                                    <i class="fas fa-user-shield"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/admin/accounts?action=toggleStatus&type=STAFF&id=${staffMember.id}"
                                                   class="btn btn-toggle btn-sm"
                                                   title="Changer le statut">
                                                    <i class="fas fa-power-off"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/admin/accounts?action=delete&type=STAFF&id=${staffMember.id}"
                                                   class="btn btn-danger btn-sm"
                                                   onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce membre du staff?')"
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
    </div>

    <script>
        function showTab(tabName) {
            // Hide all tabs
            document.querySelectorAll('.tab-content').forEach(tab => {
                tab.classList.remove('active');
            });

            // Remove active class from all tab buttons
            document.querySelectorAll('.tab').forEach(tab => {
                tab.classList.remove('active');
            });

            // Show selected tab
            document.getElementById(tabName).classList.add('active');

            // Add active class to clicked tab button
            event.target.closest('.tab').classList.add('active');
        }
    </script>
</body>
</html>

