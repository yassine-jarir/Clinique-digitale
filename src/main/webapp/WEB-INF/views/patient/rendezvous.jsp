<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Prendre Rendez-vous</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: #333;
        }

        /* Sidebar */
        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            height: 100vh;
            width: 280px;
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(10px);
            padding: 30px 0;
            box-shadow: 4px 0 20px rgba(0,0,0,0.1);
            z-index: 1000;
        }
        .sidebar-header {
            padding: 0 30px 30px 30px;
            border-bottom: 2px solid #f0f0f0;
        }

        .sidebar-header h2 {
            font-size: 1.8em;
            font-weight: 700;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 8px;
        }

        .sidebar-header p {
            font-size: 0.95em;
            color: #666;
            font-weight: 500;
        }

        .sidebar-menu {
            padding: 30px 0;
        }

        .menu-item {
            padding: 16px 30px;
            display: flex;
            align-items: center;
            color: #555;
            text-decoration: none;
            transition: all 0.3s;
            cursor: pointer;
            font-weight: 500;
            border-left: 3px solid transparent;
        }

        .menu-item:hover {
            background: #f8f9ff;
            color: #667eea;
            border-left-color: #667eea;
        }

        .menu-item.active {
            background: linear-gradient(90deg, rgba(102, 126, 234, 0.1) 0%, transparent 100%);
            color: #667eea;
            border-left-color: #667eea;
        }

        .menu-item .icon {
            font-size: 1.6em;
            margin-right: 15px;
            width: 32px;
            text-align: center;
        }

        /* Main Content */
        .main-content {
            margin-left: 280px;
            padding: 40px;
            min-height: 100vh;
        }

        .top-header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            padding: 30px 40px;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            margin-bottom: 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .top-header h1 {
            font-size: 2.2em;
            font-weight: 700;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .subtitle {
            color: #666;
            font-size: 1.1em;
            margin-top: 10px;
            font-weight: 500;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .user-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 700;
            font-size: 1.3em;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        .logout-btn {
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a6f 100%);
            color: white;
            border: none;
            padding: 12px 28px;
            border-radius: 12px;
            cursor: pointer;
            font-size: 0.95em;
            font-weight: 600;
            transition: all 0.3s;
            box-shadow: 0 4px 15px rgba(238, 90, 111, 0.3);
        }

        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(238, 90, 111, 0.4);
        }

        /* Breadcrumb Navigation */
        .breadcrumb {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            padding: 20px 30px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.08);
            margin-bottom: 30px;
            display: flex;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
        }

        .breadcrumb-item {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 1em;
            color: #666;
        }

        .breadcrumb-item.active {
            color: #667eea;
            font-weight: 600;
        }

        .breadcrumb-separator {
            color: #999;
            font-size: 1.2em;
        }

        /* Back Button */
        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            background: rgba(255, 255, 255, 0.95);
            color: #667eea;
            border: 2px solid #667eea;
            padding: 12px 24px;
            border-radius: 12px;
            cursor: pointer;
            font-size: 1em;
            font-weight: 600;
            transition: all 0.3s;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.2);
            margin-bottom: 30px;
            text-decoration: none;
        }

        .back-btn:hover {
            background: #667eea;
            color: white;
            transform: translateX(-5px);
        }

        /* Card Grid */
        .card-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 30px;
            animation: fadeIn 0.5s ease-in;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Department/Specialty Card */
        .info-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 40px 30px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.08);
            transition: all 0.3s;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            border: 3px solid transparent;
            position: relative;
            overflow: hidden;
            display: block;
            color: inherit;
        }

        .info-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
            transform: scaleX(0);
            transition: transform 0.3s;
        }

        .info-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 60px rgba(0,0,0,0.15);
            border-color: #667eea;
        }

        .info-card:hover::before {
            transform: scaleX(1);
        }

        .info-card-icon {
            width: 100px;
            height: 100px;
            margin: 0 auto 25px;
            border-radius: 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3em;
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
            transition: all 0.3s;
        }

        .info-card:hover .info-card-icon {
            transform: scale(1.1) rotate(5deg);
        }

        .info-card h3 {
            font-size: 1.6em;
            font-weight: 700;
            color: #333;
            margin-bottom: 15px;
        }

        .info-card p {
            color: #666;
            font-size: 1em;
            line-height: 1.6;
            margin-bottom: 20px;
            min-height: 50px;
        }

        .info-card .count-badge {
            display: inline-block;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 10px 24px;
            border-radius: 25px;
            font-weight: 600;
            font-size: 1em;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
            margin-bottom: 15px;
        }

        .info-card .arrow {
            margin-top: 10px;
            font-size: 2em;
            color: #667eea;
            transition: all 0.3s;
        }

        .info-card:hover .arrow {
            transform: translateX(10px);
        }

        /* Doctor Card */
        .doctor-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.08);
            transition: all 0.3s;
            border: 2px solid transparent;
            position: relative;
            overflow: hidden;
        }

        .doctor-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
            transform: scaleX(0);
            transition: transform 0.3s;
        }

        .doctor-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.15);
            border-color: #667eea;
        }

        .doctor-card:hover::before {
            transform: scaleX(1);
        }

        .doctor-header {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-bottom: 25px;
            padding-bottom: 20px;
            border-bottom: 2px solid #f0f0f0;
        }

        .doctor-avatar {
            width: 70px;
            height: 70px;
            border-radius: 18px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.8em;
            font-weight: 700;
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
        }

        .doctor-info h3 {
            color: #333;
            font-size: 1.4em;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .doctor-status {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            background: #d4f4dd;
            color: #2d8659;
            padding: 5px 14px;
            border-radius: 10px;
            font-size: 0.85em;
            font-weight: 600;
        }

        .doctor-details {
            margin: 25px 0;
            padding: 20px;
            background: #f8f9ff;
            border-radius: 14px;
        }

        .detail-item {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 12px;
            color: #555;
            font-size: 0.95em;
        }

        .detail-item:last-child {
            margin-bottom: 0;
        }

        .detail-item .icon {
            width: 32px;
            height: 32px;
            background: white;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2em;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }

        .availability-preview {
            margin: 20px 0;
            padding: 15px;
            background: white;
            border-radius: 12px;
            border: 2px solid #f0f0f0;
        }

        .availability-preview h4 {
            font-size: 0.95em;
            color: #667eea;
            margin-bottom: 12px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .availability-days {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
        }

        .day-badge {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 6px 12px;
            border-radius: 8px;
            font-size: 0.85em;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 5px;
            box-shadow: 0 2px 8px rgba(102, 126, 234, 0.2);
        }

        .availability-loading {
            color: #999;
            font-size: 0.9em;
            font-style: italic;
            padding: 8px 0;
        }

        .availability-empty {
            color: #ff6b6b;
            font-size: 0.9em;
            padding: 8px 0;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .btn-book {
            width: 100%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 16px;
            border-radius: 14px;
            font-size: 1.05em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            text-decoration: none;
        }

        .btn-book:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
        }

        .empty-state {
            text-align: center;
            padding: 80px 20px;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.08);
        }

        .empty-state .icon {
            font-size: 6em;
            margin-bottom: 25px;
            opacity: 0.7;
        }

        .empty-state h2 {
            color: #333;
            margin-bottom: 15px;
            font-size: 1.8em;
        }

        .empty-state p {
            color: #666;
            font-size: 1.1em;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .sidebar {
                width: 80px;
            }

            .sidebar-header h2,
            .sidebar-header p,
            .menu-item .text {
                display: none;
            }

            .main-content {
                margin-left: 80px;
                padding: 20px;
            }

            .menu-item {
                justify-content: center;
            }

            .menu-item .icon {
                margin-right: 0;
            }

            .card-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <h2>🏥 Clinique</h2>
            <p>Espace Patient</p>
        </div>
        <div class="sidebar-menu">
            <a href="${pageContext.request.contextPath}/patient/dashboard" class="menu-item">
                <span class="icon">🏠</span>
                <span class="text">Dashboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/patient/rendezvous" class="menu-item active">
                <span class="icon">📅</span>
                <span class="text">Prendre RDV</span>
            </a>
            <a href="${pageContext.request.contextPath}/patient/appointments" class="menu-item">
                <span class="icon">📋</span>
                <span class="text">Mes RDV</span>
            </a>
            <a href="#" class="menu-item" onclick="alert('Fonctionnalité à venir !'); return false;">
                <span class="icon">📄</span>
                <span class="text">Dossier Médical</span>
            </a>
            <a href="#" class="menu-item" onclick="alert('Fonctionnalité à venir !'); return false;">
                <span class="icon">👤</span>
                <span class="text">Mon Profil</span>
            </a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Header -->
        <div class="top-header">
            <div>
                <h1>Prendre Rendez-vous</h1>
                <p class="subtitle">
                    <c:choose>
                        <c:when test="${not empty selectedSpecialtyId}">Sélectionnez un médecin</c:when>
                        <c:when test="${not empty selectedDepartmentId}">Choisissez une spécialité</c:when>
                        <c:otherwise>Choisissez un département médical</c:otherwise>
                    </c:choose>
                </p>
            </div>
            <div class="user-info">
                <div class="user-avatar">${sessionScope.nom != null ? sessionScope.nom.substring(0,1).toUpperCase() : 'P'}</div>
                <button class="logout-btn" onclick="location.href='${pageContext.request.contextPath}/logout'">Déconnexion</button>
            </div>
        </div>

        <!-- Breadcrumb -->
        <c:if test="${not empty selectedDepartmentId or not empty selectedSpecialtyId}">
            <div class="breadcrumb">
                <a href="${pageContext.request.contextPath}/patient/rendezvous" class="breadcrumb-item" style="text-decoration: none;">
                    <span>🏥</span>
                    <span>Départements</span>
                </a>
                <c:if test="${not empty selectedDepartmentId}">
                    <span class="breadcrumb-separator">›</span>
                    <a href="${pageContext.request.contextPath}/patient/rendezvous?departmentId=${selectedDepartmentId}"
                       class="breadcrumb-item ${empty selectedSpecialtyId ? 'active' : ''}"
                       style="text-decoration: none;">
                        <span>📋</span>
                        <span>Spécialités</span>
                    </a>
                </c:if>
                <c:if test="${not empty selectedSpecialtyId}">
                    <span class="breadcrumb-separator">›</span>
                    <span class="breadcrumb-item active">
                        <span>👨‍⚕️</span>
                        <span>Médecins</span>
                    </span>
                </c:if>
            </div>
        </c:if>

        <!-- Step 1: Show Departments (default view) -->
        <c:if test="${empty selectedDepartmentId and empty selectedSpecialtyId}">
            <c:choose>
                <c:when test="${empty allDepartments}">
                    <div class="empty-state">
                        <div class="icon">🏥</div>
                        <h2>Aucun département disponible</h2>
                        <p>Il n'y a pas de départements disponibles pour le moment.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="card-grid">
                        <c:forEach var="dept" items="${allDepartments}">
                            <a href="${pageContext.request.contextPath}/patient/rendezvous?departmentId=${dept.id}" class="info-card">
                                <div class="info-card-icon">
                                    <c:choose>
                                        <c:when test="${dept.nom.toLowerCase().contains('urgence')}">🚑</c:when>
                                        <c:when test="${dept.nom.toLowerCase().contains('chirurgie')}">🔬</c:when>
                                        <c:when test="${dept.nom.toLowerCase().contains('médecine')}">⚕️</c:when>
                                        <c:when test="${dept.nom.toLowerCase().contains('pédiatri')}">👶</c:when>
                                        <c:when test="${dept.nom.toLowerCase().contains('radiologie')}">📷</c:when>
                                        <c:otherwise>🏥</c:otherwise>
                                    </c:choose>
                                </div>
                                <h3>${dept.nom}</h3>
                                <p>${dept.description != null && !dept.description.isEmpty() ? dept.description : 'Département médical de qualité avec des professionnels expérimentés'}</p>
                                <div class="count-badge">
                                    ${dept.specialtyCount} spécialité${dept.specialtyCount > 1 ? 's' : ''}
                                </div>
                                <div class="arrow">→</div>
                            </a>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </c:if>

        <!-- Step 2: Show Specialties for Selected Department -->
        <c:if test="${not empty selectedDepartmentId and empty selectedSpecialtyId}">
            <a href="${pageContext.request.contextPath}/patient/rendezvous" class="back-btn">
                <span>←</span>
                <span>Retour aux départements</span>
            </a>

            <c:choose>
                <c:when test="${empty departmentSpecialties}">
                    <div class="empty-state">
                        <div class="icon">📋</div>
                        <h2>Aucune spécialité disponible</h2>
                        <p>Ce département n'a pas de spécialités disponibles pour le moment.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="card-grid">
                        <c:forEach var="specialty" items="${departmentSpecialties}">
                            <a href="${pageContext.request.contextPath}/patient/rendezvous?departmentId=${selectedDepartmentId}&specialtyId=${specialty.id}" class="info-card">
                                <div class="info-card-icon">
                                    <c:choose>
                                        <c:when test="${specialty.nom.toLowerCase().contains('cardio')}">❤️</c:when>
                                        <c:when test="${specialty.nom.toLowerCase().contains('neuro')}">🧠</c:when>
                                        <c:when test="${specialty.nom.toLowerCase().contains('pédiatri') || specialty.nom.toLowerCase().contains('pediatr')}">👶</c:when>
                                        <c:when test="${specialty.nom.toLowerCase().contains('dermato')}">🩺</c:when>
                                        <c:when test="${specialty.nom.toLowerCase().contains('orthopéd') || specialty.nom.toLowerCase().contains('orthoped')}">🦴</c:when>
                                        <c:when test="${specialty.nom.toLowerCase().contains('gynéco') || specialty.nom.toLowerCase().contains('gyneco')}">👩‍⚕️</c:when>
                                        <c:when test="${specialty.nom.toLowerCase().contains('ophtalmol')}">👁️</c:when>
                                        <c:when test="${specialty.nom.toLowerCase().contains('oto')}">👂</c:when>
                                        <c:when test="${specialty.nom.toLowerCase().contains('psychiat')}">💭</c:when>
                                        <c:when test="${specialty.nom.toLowerCase().contains('urgence')}">🚑</c:when>
                                        <c:otherwise>🏥</c:otherwise>
                                    </c:choose>
                                </div>
                                <h3>${specialty.nom}</h3>
                                <p>${specialty.description != null && !specialty.description.isEmpty() ? specialty.description : 'Spécialité médicale avec des professionnels expérimentés'}</p>
                                <div class="arrow">→</div>
                            </a>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </c:if>

        <!-- Step 3: Show Doctors for Selected Specialty -->
        <c:if test="${not empty selectedSpecialtyId}">
            <a href="${pageContext.request.contextPath}/patient/rendezvous?departmentId=${selectedDepartmentId}" class="back-btn">
                <span>←</span>
                <span>Retour aux spécialités</span>
            </a>

            <c:choose>
                <c:when test="${empty specialtyDoctors}">
                    <div class="empty-state">
                        <div class="icon">👨‍⚕️</div>
                        <h2>Aucun médecin disponible</h2>
                        <p>Cette spécialité n'a pas de médecins disponibles pour le moment.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="card-grid">
                        <c:forEach var="doctor" items="${specialtyDoctors}">
                            <div class="doctor-card">
                                <div class="doctor-header">
                                    <div class="doctor-avatar">
                                        ${doctor.nom != null ? doctor.nom.substring(0,1).toUpperCase() : 'D'}
                                    </div>
                                    <div class="doctor-info">
                                        <h3>${doctor.titre != null ? doctor.titre : 'Dr'} ${doctor.nom}</h3>
                                        <c:if test="${doctor.actif}">
                                            <span class="doctor-status">✓ Disponible</span>
                                        </c:if>
                                    </div>
                                </div>

                                <div class="doctor-details">
                                    <div class="detail-item">
                                        <span class="icon">🏥</span>
                                        <span><strong>Spécialité:</strong> ${doctor.specialiteNom}</span>
                                    </div>
                                    <div class="detail-item">
                                        <span class="icon">📧</span>
                                        <span>${doctor.email}</span>
                                    </div>
                                    <c:if test="${doctor.matricule != null}">
                                        <div class="detail-item">
                                            <span class="icon">🆔</span>
                                            <span><strong>Matricule:</strong> ${doctor.matricule}</span>
                                        </div>
                                    </c:if>
                                </div>


                                <div class="availability-preview">
                                    <h4>
                                        <span>🗓️</span>
                                        <span>Disponibilité</span>
                                    </h4>
                                    <div class="availability-days" id="availability-${doctor.id}">
                                        <div class="availability-loading">Chargement...</div>
                                    </div>
                                </div>

                                <a href="${pageContext.request.contextPath}/patient/book-appointment?doctorId=${doctor.id}" class="btn-book">
                                    <span>📅</span>
                                    <span>Voir les créneaux disponibles</span>
                                </a>
                            </div>
                        </c:forEach>
                    </div>

                    <script>
                        // Load availability for each doctor
                        document.addEventListener('DOMContentLoaded', function() {
                            <c:forEach var="doctor" items="${specialtyDoctors}">
                                loadDoctorAvailability('${doctor.id}');
                            </c:forEach>
                        });

                        function loadDoctorAvailability(doctorId) {
                            const container = document.getElementById('availability-' + doctorId);

                            fetch('${pageContext.request.contextPath}/api/doctor-availability?doctorId=' + doctorId)
                                .then(response => response.json())
                                .then(data => {
                                    if (data && data.schedule && data.schedule.length > 0) {
                                        let html = '';
                                        data.schedule.forEach(daySchedule => {
                                            daySchedule.periods.forEach(period => {
                                                const dayShort = getDayShort(daySchedule.day);
                                                html += '<div class="day-badge">' + dayShort + ' <span class="time-range">' +
                                                        period.start + '-' + period.end + '</span></div>';
                                            });
                                        });
                                        container.innerHTML = html;
                                    } else {
                                        container.innerHTML = '<div class="availability-empty"><span>❌</span><span>Aucune disponibilité</span></div>';
                                    }
                                })
                                .catch(error => {
                                    console.error('Error loading availability:', error);
                                    container.innerHTML = '<div class="availability-empty"><span>❌</span><span>Erreur</span></div>';
                                });
                        }

                        function getDayShort(day) {
                            const shorts = {
                                'Lundi': 'Lu',
                                'Mardi': 'Ma',
                                'Mercredi': 'Me',
                                'Jeudi': 'Je',
                                'Vendredi': 'Ve',
                                'Samedi': 'Sa',
                                'Dimanche': 'Di'
                            };
                            return shorts[day] || day;
                        }
                    </script>
                </c:otherwise>
            </c:choose>
        </c:if>
    </div>
</body>
</html>
