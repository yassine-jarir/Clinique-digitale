<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Dashboard</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f7fa;
            color: #333;
        }

        /* Sidebar */
        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            height: 100vh;
            width: 260px;
            background: linear-gradient(180deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px 0;
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
            z-index: 1000;
        }

        .sidebar-header {
            padding: 0 20px 30px 20px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        .sidebar-header h2 {
            font-size: 1.5em;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .sidebar-header p {
            font-size: 0.9em;
            opacity: 0.8;
        }

        .sidebar-menu {
            padding: 20px 0;
        }

        .menu-item {
            padding: 15px 25px;
            display: flex;
            align-items: center;
            color: rgba(255,255,255,0.85);
            text-decoration: none;
            transition: all 0.3s;
            cursor: pointer;
        }

        .menu-item:hover, .menu-item.active {
            background: rgba(255,255,255,0.15);
            color: white;
            border-left: 4px solid #4CAF50;
            padding-left: 21px;
        }

        .menu-item .icon {
            font-size: 1.5em;
            margin-right: 15px;
            width: 30px;
            text-align: center;
        }

        /* Main Content */
        .main-content {
            margin-left: 260px;
            padding: 30px;
            min-height: 100vh;
        }

        .top-header {
            background: white;
            padding: 20px 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .top-header h1 {
            color: #667eea;
            font-size: 1.8em;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .user-avatar {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 1.2em;
        }

        .logout-btn {
            background: #dc3545;
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 0.9em;
            transition: background 0.3s;
        }

        .logout-btn:hover {
            background: #c82333;
        }

        /* Dashboard Cards */
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }

        .card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.06);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }

        .card-icon {
            font-size: 3em;
            margin-bottom: 15px;
        }

        .card h3 {
            color: #555;
            font-size: 1.1em;
            margin-bottom: 10px;
        }

        .card-value {
            font-size: 2.5em;
            font-weight: bold;
            color: #667eea;
        }

        .card-link {
            display: inline-block;
            margin-top: 15px;
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s;
        }

        .card-link:hover {
            color: #764ba2;
        }

        /* Quick Actions */
        .quick-actions {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.06);
            margin-bottom: 30px;
        }

        .quick-actions h2 {
            color: #667eea;
            margin-bottom: 20px;
            font-size: 1.4em;
        }

        .action-buttons {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
        }

        .action-btn {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 15px 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1em;
            text-decoration: none;
            transition: all 0.3s;
        }

        .action-btn:hover {
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .action-btn .icon {
            font-size: 1.8em;
        }

        /* Recent Appointments */
        .recent-section {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.06);
        }

        .recent-section h2 {
            color: #667eea;
            margin-bottom: 20px;
            font-size: 1.4em;
        }

        .appointment-item {
            padding: 20px;
            border-left: 4px solid #667eea;
            background: #f8f9ff;
            margin-bottom: 15px;
            border-radius: 5px;
        }

        .appointment-date {
            font-weight: bold;
            color: #667eea;
            margin-bottom: 5px;
        }

        .empty-state {
            text-align: center;
            padding: 40px;
            color: #999;
        }

        .empty-state .icon {
            font-size: 4em;
            margin-bottom: 15px;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .sidebar {
                width: 70px;
            }

            .sidebar-header h2,
            .sidebar-header p,
            .menu-item .text {
                display: none;
            }

            .main-content {
                margin-left: 70px;
                padding: 15px;
            }

            .menu-item {
                justify-content: center;
            }

            .menu-item .icon {
                margin-right: 0;
            }

            .dashboard-grid {
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
            <a href="${pageContext.request.contextPath}/patient/dashboard" class="menu-item active">
                <span class="icon">🏠</span>
                <span class="text">Dashboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/patient/rendezvous" class="menu-item">
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
            <a href="#" class="menu-item" onclick="alert('Fonctionnalité à venir !'); return false;">
                <span class="icon">⚙️</span>
                <span class="text">Paramètres</span>
            </a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Header -->
        <div class="top-header">
            <h1>Bienvenue, ${sessionScope.nom}!</h1>
            <div class="user-info">
                <div class="user-avatar">${sessionScope.nom.substring(0,1).toUpperCase()}</div>
                <button class="logout-btn" onclick="location.href='${pageContext.request.contextPath}/logout'">Déconnexion</button>
            </div>
        </div>

        <!-- Dashboard Cards -->
        <div class="dashboard-grid">
            <div class="card">
                <div class="card-icon">📅</div>
                <h3>Rendez-vous à venir</h3>
                <div class="card-value">${upcomingCount != null ? upcomingCount : 0}</div>
                <a href="${pageContext.request.contextPath}/patient/appointments" class="card-link">Voir tous →</a>
            </div>

            <div class="card">
                <div class="card-icon">✅</div>
                <h3>Consultations passées</h3>
                <div class="card-value">${pastCount != null ? pastCount : 0}</div>
                <a href="${pageContext.request.contextPath}/patient/appointments" class="card-link">Historique →</a>
            </div>

            <div class="card">
                <div class="card-icon">👨‍⚕️</div>
                <h3>Médecins disponibles</h3>
                <div class="card-value">${doctorCount != null ? doctorCount : 0}</div>
                <a href="${pageContext.request.contextPath}/patient/book-appointment" class="card-link">Consulter →</a>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="quick-actions">
            <h2>Actions rapides</h2>
            <div class="action-buttons">
                <a href="${pageContext.request.contextPath}/patient/book-appointment" class="action-btn">
                    <span class="icon">📅</span>
                    <span>Prendre un rendez-vous</span>
                </a>
                <a href="${pageContext.request.contextPath}/patient/appointments" class="action-btn">
                    <span class="icon">📋</span>
                    <span>Mes rendez-vous</span>
                </a>
                <a href="#" class="action-btn" onclick="alert('Fonctionnalité à venir !'); return false;">
                    <span class="icon">📄</span>
                    <span>Mon dossier médical</span>
                </a>
                <a href="#" class="action-btn" onclick="alert('Fonctionnalité à venir !'); return false;">
                    <span class="icon">👤</span>
                    <span>Modifier mon profil</span>
                </a>
            </div>
        </div>

        <!-- Recent Appointments -->
        <div class="recent-section">
            <h2>Rendez-vous récents</h2>
            <c:choose>
                <c:when test="${empty recentAppointments}">
                    <div class="empty-state">
                        <div class="icon">📭</div>
                        <p>Aucun rendez-vous pour le moment</p>
                        <p style="font-size: 0.9em; margin-top: 10px;">
                            <a href="${pageContext.request.contextPath}/patient/book-appointment" style="color: #667eea;">Prenez votre premier rendez-vous</a>
                        </p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="appointment" items="${recentAppointments}">
                        <div class="appointment-item">
                            <div class="appointment-date">📅 ${appointment.dateRdv} à ${appointment.heure}</div>
                            <div>👨‍⚕️ Dr. ${appointment.doctorNom}</div>
                            <div style="margin-top: 5px; color: #666;">Statut: ${appointment.statut}</div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
