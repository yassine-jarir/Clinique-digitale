<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifier le Rôle - Clinique</title>
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
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 30px;
        }

        .role-edit-card {
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            max-width: 500px;
            width: 100%;
        }

        .card-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .card-header i {
            font-size: 64px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 20px;
        }

        .card-header h1 {
            color: #2d3748;
            font-size: 28px;
            margin-bottom: 10px;
        }

        .card-header p {
            color: #a0aec0;
            font-size: 14px;
        }

        .user-info {
            background: #f7fafc;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 30px;
        }

        .user-info-item {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #e2e8f0;
        }

        .user-info-item:last-child {
            border-bottom: none;
        }

        .user-info-label {
            color: #a0aec0;
            font-size: 13px;
            font-weight: 600;
            text-transform: uppercase;
        }

        .user-info-value {
            color: #2d3748;
            font-weight: 600;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            margin-bottom: 10px;
            color: #2d3748;
            font-weight: 600;
            font-size: 14px;
        }

        .role-options {
            display: grid;
            gap: 12px;
        }

        .role-option {
            position: relative;
        }

        .role-option input[type="radio"] {
            position: absolute;
            opacity: 0;
        }

        .role-option label {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 15px 20px;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.3s;
            font-weight: 500;
        }

        .role-option input[type="radio"]:checked + label {
            border-color: #667eea;
            background: rgba(102, 126, 234, 0.05);
        }

        .role-option label i {
            font-size: 24px;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 10px;
        }

        .role-option.admin label i {
            background: rgba(245, 101, 101, 0.1);
            color: #f56565;
        }

        .role-option.doctor label i {
            background: rgba(102, 126, 234, 0.1);
            color: #667eea;
        }

        .role-option.patient label i {
            background: rgba(79, 172, 254, 0.1);
            color: #4facfe;
        }

        .role-option.staff label i {
            background: rgba(67, 233, 123, 0.1);
            color: #43e97b;
        }

        .role-option label:hover {
            border-color: #667eea;
            transform: translateX(5px);
        }

        .role-description {
            margin-left: 55px;
            font-size: 12px;
            color: #a0aec0;
        }

        .form-actions {
            display: flex;
            gap: 12px;
            margin-top: 30px;
        }

        .btn {
            flex: 1;
            padding: 14px 24px;
            border: none;
            border-radius: 10px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            text-decoration: none;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
        }

        .btn-secondary {
            background: #f7fafc;
            color: #4a5568;
        }

        .btn-secondary:hover {
            background: #edf2f7;
        }

        .alert {
            padding: 12px 16px;
            border-radius: 10px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 14px;
        }

        .alert-warning {
            background: #fef5e7;
            color: #85651d;
            border-left: 4px solid #f39c12;
        }
    </style>
</head>
<body>
    <div class="role-edit-card">
        <div class="card-header">
            <i class="fas fa-user-shield"></i>
            <h1>Attribuer un Rôle</h1>
            <p>Modifiez le rôle de l'utilisateur dans le système</p>
        </div>

        <div class="alert alert-warning">
            <i class="fas fa-exclamation-triangle"></i>
            <span>Attention : La modification du rôle peut affecter les permissions de l'utilisateur</span>
        </div>

        <c:choose>
            <c:when test="${not empty patient}">
                <c:set var="user" value="${patient}"/>
            </c:when>
            <c:when test="${not empty doctor}">
                <c:set var="user" value="${doctor}"/>
            </c:when>
            <c:otherwise>
                <c:set var="user" value="${user}"/>
            </c:otherwise>
        </c:choose>

        <div class="user-info">
            <div class="user-info-item">
                <span class="user-info-label">Nom</span>
                <span class="user-info-value">${user.nom}</span>
            </div>
            <div class="user-info-item">
                <span class="user-info-label">Email</span>
                <span class="user-info-value">${user.email}</span>
            </div>
            <div class="user-info-item">
                <span class="user-info-label">Rôle Actuel</span>
                <span class="user-info-value">${user.role}</span>
            </div>
        </div>

        <form method="post" action="${pageContext.request.contextPath}/admin/accounts">
            <input type="hidden" name="action" value="updateRole">
            <input type="hidden" name="id" value="${user.id}">

            <div class="form-group">
                <label>Sélectionner le Nouveau Rôle</label>
                <div class="role-options">
                    <div class="role-option admin">
                        <input type="radio" id="admin" name="role" value="ADMIN" ${user.role == 'ADMIN' ? 'checked' : ''}>
                        <label for="admin">
                            <i class="fas fa-user-shield"></i>
                            <div>
                                <div>Administrateur</div>
                                <div class="role-description">Accès complet à toutes les fonctionnalités</div>
                            </div>
                        </label>
                    </div>

                    <div class="role-option doctor">
                        <input type="radio" id="doctor" name="role" value="DOCTOR" ${user.role == 'DOCTOR' ? 'checked' : ''}>
                        <label for="doctor">
                            <i class="fas fa-user-md"></i>
                            <div>
                                <div>Docteur</div>
                                <div class="role-description">Gestion des consultations et patients</div>
                            </div>
                        </label>
                    </div>

                    <div class="role-option patient">
                        <input type="radio" id="patient" name="role" value="PATIENT" ${user.role == 'PATIENT' ? 'checked' : ''}>
                        <label for="patient">
                            <i class="fas fa-user-injured"></i>
                            <div>
                                <div>Patient</div>
                                <div class="role-description">Consultation du dossier médical</div>
                            </div>
                        </label>
                    </div>

                    <div class="role-option staff">
                        <input type="radio" id="staff" name="role" value="STAFF" ${user.role == 'STAFF' ? 'checked' : ''}>
                        <label for="staff">
                            <i class="fas fa-user-tie"></i>
                            <div>
                                <div>Staff</div>
                                <div class="role-description">Personnel administratif</div>
                            </div>
                        </label>
                    </div>
                </div>
            </div>

            <div class="form-actions">
                <a href="${pageContext.request.contextPath}/admin/accounts" class="btn btn-secondary">
                    <i class="fas fa-times"></i>
                    Annuler
                </a>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-check"></i>
                    Mettre à Jour le Rôle
                </button>
            </div>
        </form>
    </div>
</body>
</html>

