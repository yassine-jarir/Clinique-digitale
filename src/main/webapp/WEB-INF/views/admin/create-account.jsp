<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Créer un Compte - Clinique</title>
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

        .main-content {
            margin-left: 280px;
            padding: 30px;
            min-height: 100vh;
        }

        .form-container {
            max-width: 800px;
            margin: 0 auto;
        }

        .page-header {
            background: white;
            padding: 25px 30px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 30px;
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .back-btn {
            width: 45px;
            height: 45px;
            border-radius: 12px;
            background: #f7fafc;
            border: none;
            color: #4a5568;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s;
            text-decoration: none;
        }

        .back-btn:hover {
            background: #edf2f7;
            transform: translateX(-5px);
        }

        .page-header h1 {
            color: #2d3748;
            font-size: 28px;
            font-weight: 700;
        }

        .form-card {
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .account-type-badge {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 10px 20px;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 30px;
        }

        .account-type-badge.patient {
            background: rgba(79, 172, 254, 0.1);
            color: #4facfe;
        }

        .account-type-badge.doctor {
            background: rgba(102, 126, 234, 0.1);
            color: #667eea;
        }

        .account-type-badge.staff {
            background: rgba(67, 233, 123, 0.1);
            color: #43e97b;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group.full-width {
            grid-column: span 2;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #2d3748;
            font-weight: 600;
            font-size: 14px;
        }

        .form-group label .required {
            color: #f56565;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            font-size: 14px;
            transition: all 0.3s;
            font-family: inherit;
        }

        .form-control:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .form-control:disabled {
            background: #f7fafc;
            cursor: not-allowed;
        }

        select.form-control {
            cursor: pointer;
        }

        .form-actions {
            display: flex;
            gap: 15px;
            margin-top: 30px;
            padding-top: 30px;
            border-top: 2px solid #f0f2f5;
        }

        .btn {
            padding: 14px 32px;
            border: none;
            border-radius: 10px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            text-decoration: none;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            flex: 1;
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
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .alert-danger {
            background: #fed7d7;
            color: #742a2a;
            border-left: 4px solid #f56565;
        }

        .form-section-title {
            font-size: 18px;
            font-weight: 600;
            color: #2d3748;
            margin: 30px 0 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #f0f2f5;
        }

        .form-section-title:first-child {
            margin-top: 0;
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
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="form-container">
            <!-- Page Header -->
            <div class="page-header">
                <a href="${pageContext.request.contextPath}/admin/accounts" class="back-btn">
                    <i class="fas fa-arrow-left"></i>
                </a>
                <h1>Créer un Nouveau Compte</h1>
            </div>

            <!-- Form Card -->
            <div class="form-card">
                <c:choose>
                    <c:when test="${accountType == 'PATIENT'}">
                        <div class="account-type-badge patient">
                            <i class="fas fa-user-injured"></i>
                            <span>Compte Patient</span>
                        </div>
                    </c:when>
                    <c:when test="${accountType == 'DOCTOR'}">
                        <div class="account-type-badge doctor">
                            <i class="fas fa-user-md"></i>
                            <span>Compte Docteur</span>
                        </div>
                    </c:when>
                    <c:when test="${accountType == 'STAFF'}">
                        <div class="account-type-badge staff">
                            <i class="fas fa-user-tie"></i>
                            <span>Compte Staff</span>
                        </div>
                    </c:when>
                </c:choose>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-circle"></i>
                        <span>${error}</span>
                    </div>
                </c:if>

                <form method="post" action="${pageContext.request.contextPath}/admin/accounts">
                    <input type="hidden" name="action" value="create">
                    <input type="hidden" name="accountType" value="${accountType}">

                    <div class="form-section-title">Informations de Connexion</div>

                    <div class="form-grid">
                        <div class="form-group full-width">
                            <label>Nom Complet <span class="required">*</span></label>
                            <input type="text" name="nom" class="form-control" required>
                        </div>

                        <div class="form-group">
                            <label>Email <span class="required">*</span></label>
                            <input type="email" name="email" class="form-control" required>
                        </div>

                        <div class="form-group">
                            <label>Mot de Passe <span class="required">*</span></label>
                            <input type="password" name="password" class="form-control" required>
                        </div>
                    </div>

                    <!-- Patient Specific Fields -->
                    <c:if test="${accountType == 'PATIENT'}">
                        <div class="form-section-title">Informations Patient</div>

                        <div class="form-grid">
                            <div class="form-group">
                                <label>CIN <span class="required">*</span></label>
                                <input type="text" name="cin" class="form-control" required>
                            </div>

                            <div class="form-group">
                                <label>Date de Naissance</label>
                                <input type="date" name="dateNaissance" class="form-control">
                            </div>

                            <div class="form-group">
                                <label>Sexe</label>
                                <select name="sexe" class="form-control">
                                    <option value="">Sélectionner...</option>
                                    <option value="MALE">Homme</option>
                                    <option value="FEMALE">Femme</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label>Téléphone</label>
                                <input type="tel" name="telephone" class="form-control">
                            </div>

                            <div class="form-group">
                                <label>Groupe Sanguin</label>
                                <select name="sang" class="form-control">
                                    <option value="">Sélectionner...</option>
                                    <option value="A_POSITIVE">A+</option>
                                    <option value="A_NEGATIVE">A-</option>
                                    <option value="B_POSITIVE">B+</option>
                                    <option value="B_NEGATIVE">B-</option>
                                    <option value="O_POSITIVE">O+</option>
                                    <option value="O_NEGATIVE">O-</option>
                                    <option value="AB_POSITIVE">AB+</option>
                                    <option value="AB_NEGATIVE">AB-</option>
                                </select>
                            </div>

                            <div class="form-group full-width">
                                <label>Adresse</label>
                                <input type="text" name="adresse" class="form-control">
                            </div>
                        </div>
                    </c:if>

                    <!-- Doctor Specific Fields -->
                    <c:if test="${accountType == 'DOCTOR'}">
                        <div class="form-section-title">Informations Docteur</div>

                        <div class="form-grid">
                            <div class="form-group full-width">
                                <label>
                                    <i class="fas fa-info-circle" style="color: #4facfe;"></i>
                                    Matricule (Auto-généré)
                                </label>
                                <input type="text" class="form-control" value="Sera généré automatiquement (Format: DR-YYYYMMDD-XXXX)" disabled>
                                <small style="color: #a0aec0; font-size: 12px; margin-top: 5px; display: block;">
                                    Le matricule sera généré automatiquement lors de la création du compte
                                </small>
                            </div>

                            <div class="form-group">
                                <label>Titre (Dr., Prof., etc.)</label>
                                <input type="text" name="titre" class="form-control" placeholder="Dr.">
                            </div>

                            <div class="form-group">
                                <label>Spécialité</label>
                                <select name="specialtyId" class="form-control">
                                    <option value="">Sélectionner une spécialité...</option>
                                    <c:forEach items="${specialties}" var="specialty">
                                        <option value="${specialty.id}">${specialty.nom}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </c:if>

                    <!-- Form Actions -->
                    <div class="form-actions">
                        <a href="${pageContext.request.contextPath}/admin/accounts" class="btn btn-secondary">
                            <i class="fas fa-times"></i>
                            Annuler
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-check"></i>
                            Créer le Compte
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
