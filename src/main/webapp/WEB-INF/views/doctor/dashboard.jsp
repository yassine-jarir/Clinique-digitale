<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Médecin</title>
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

        /* Sidebar Styles */
        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            height: 100vh;
            width: 260px;
            background: linear-gradient(180deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            padding: 20px 0;
            transition: all 0.3s ease;
            z-index: 1000;
            box-shadow: 2px 0 10px rgba(0,0,0,0.1);
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
            background: rgba(255,255,255,0.1);
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

        .menu-item .text {
            font-size: 1em;
        }

        /* Main Content */
        .main-content {
            margin-left: 260px;
            padding: 30px;
            min-height: 100vh;
        }

        /* Header */
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
            color: #1e3c72;
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

        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.06);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }

        .stat-card .icon-wrapper {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2em;
            margin-bottom: 15px;
        }

        .stat-card.blue .icon-wrapper {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .stat-card.green .icon-wrapper {
            background: linear-gradient(135deg, #56ab2f 0%, #a8e063 100%);
        }

        .stat-card.orange .icon-wrapper {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        }

        .stat-card h3 {
            font-size: 0.95em;
            color: #666;
            margin-bottom: 8px;
            font-weight: 500;
        }

        .stat-card .value {
            font-size: 2em;
            font-weight: 700;
            color: #333;
        }

        /* Action Cards */
        .action-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
        }

        .action-card {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.06);
            text-align: center;
            transition: all 0.3s;
            cursor: pointer;
            text-decoration: none;
            color: inherit;
            display: block;
        }

        .action-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }

        .action-card .icon {
            font-size: 3em;
            margin-bottom: 15px;
        }

        .action-card h3 {
            color: #1e3c72;
            margin-bottom: 10px;
            font-size: 1.3em;
        }

        .action-card p {
            color: #666;
            font-size: 0.95em;
            line-height: 1.5;
        }

        .action-card .btn {
            margin-top: 20px;
            padding: 10px 25px;
            background: #1e3c72;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1em;
            transition: background 0.3s;
        }

        .action-card .btn:hover {
            background: #2a5298;
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
            }

            .menu-item {
                justify-content: center;
            }

            .menu-item .icon {
                margin-right: 0;
            }
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <h2>🏥 Clinique</h2>
            <p>Espace Médecin</p>
        </div>
        <div class="sidebar-menu">
            <a href="${pageContext.request.contextPath}/doctor/dashboard" class="menu-item active">
                <span class="icon">🏠</span>
                <span class="text">Dashboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/availabilities" class="menu-item">
                <span class="icon">🗓️</span>
                <span class="text">Disponibilités</span>
            </a>
            <a href="#" class="menu-item" onclick="alert('Fonctionnalité à venir !'); return false;">
                <span class="icon">📅</span>
                <span class="text">Rendez-vous</span>
            </a>
            <a href="#" class="menu-item" onclick="alert('Fonctionnalité à venir !'); return false;">
                <span class="icon">👥</span>
                <span class="text">Mes Patients</span>
            </a>
            <a href="#" class="menu-item" onclick="alert('Fonctionnalité à venir !'); return false;">
                <span class="icon">📊</span>
                <span class="text">Statistiques</span>
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
            <h1>Tableau de bord</h1>
            <div class="user-info">
                <div class="user-avatar">Dr</div>
                <button class="logout-btn" onclick="location.href='${pageContext.request.contextPath}/logout'">Déconnexion</button>
            </div>
        </div>

        <!-- Statistics Cards -->
        <div class="dashboard-grid">
            <div class="stat-card blue">
                <div class="icon-wrapper">📅</div>
                <h3>Rendez-vous aujourd'hui</h3>
                <div class="value">${todayCount != null ? todayCount : 0}</div>
            </div>
            <div class="stat-card green">
                <div class="icon-wrapper">✅</div>
                <h3>Disponibilités actives</h3>
                <div class="value">${activeAvailabilities != null ? activeAvailabilities : 0}</div>
            </div>
            <div class="stat-card orange">
                <div class="icon-wrapper">👥</div>
                <h3>Total patients</h3>
                <div class="value">${totalPatients != null ? totalPatients : 0}</div>
            </div>
        </div>

        <!-- Today's Appointments Section -->
        <c:if test="${not empty todayAppointments}">
            <div style="background: white; border-radius: 10px; padding: 25px; margin-bottom: 30px; box-shadow: 0 2px 10px rgba(0,0,0,0.05);">
                <h2 style="color: #1e3c72; margin-bottom: 20px; font-size: 1.5em;">📅 Rendez-vous d'aujourd'hui</h2>
                <div style="display: grid; gap: 15px;">
                    <c:forEach var="appointment" items="${todayAppointments}">
                        <div style="padding: 20px; background: #f8f9fa; border-radius: 8px; border-left: 4px solid #1e3c72; display: flex; justify-content: space-between; align-items: center;">
                            <div style="flex: 1;">
                                <div style="display: flex; align-items: center; gap: 15px; margin-bottom: 10px;">
                                    <span style="font-size: 1.3em; font-weight: 600; color: #1e3c72;">⏰ ${appointment.heure}</span>
                                    <span style="padding: 4px 12px; background: #e3f2fd; color: #1976d2; border-radius: 15px; font-size: 0.85em; font-weight: 600;">
                                        <c:choose>
                                            <c:when test="${appointment.type == 'CONSULTATION'}">Consultation</c:when>
                                            <c:when test="${appointment.type == 'FOLLOW_UP'}">Suivi</c:when>
                                            <c:when test="${appointment.type == 'EMERGENCY'}">Urgence</c:when>
                                        </c:choose>
                                    </span>
                                </div>
                                <div style="display: flex; align-items: center; gap: 10px;">
                                    <span style="font-size: 1.2em;">👤</span>
                                    <span style="font-size: 1.1em; font-weight: 600; color: #333;">
                                        ${appointment.patient.nom} ${appointment.patient.prenom}
                                    </span>
                                </div>
                                <c:if test="${not empty appointment.patient.telephone}">
                                    <div style="display: flex; align-items: center; gap: 10px; margin-top: 8px;">
                                        <span style="font-size: 1em;">📞</span>
                                        <span style="color: #666; font-size: 0.95em;">${appointment.patient.telephone}</span>
                                    </div>
                                </c:if>
                            </div>
                            <div>
                                <span style="padding: 8px 16px; background: #4CAF50; color: white; border-radius: 6px; font-size: 0.9em; font-weight: 600;">
                                    ${appointment.statut == 'PLANNED' ? 'Planifié' : 'Confirmé'}
                                </span>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:if>

        <!-- Action Cards -->
        <div class="action-cards">
            <a href="${pageContext.request.contextPath}/doctor/availabilities" class="action-card">
                <div class="icon">🗓️</div>
                <h3>Gérer mes disponibilités</h3>
                <p>Ajoutez, modifiez ou supprimez vos créneaux horaires disponibles pour les rendez-vous</p>
                <button class="btn">Accéder</button>
            </a>

            <div class="action-card" onclick="alert('Fonctionnalité à venir !')">
                <div class="icon">📋</div>
                <h3>Mes rendez-vous</h3>
                <p>Consultez et gérez vos rendez-vous à venir et l'historique des consultations</p>
                <button class="btn">Accéder</button>
            </div>

            <div class="action-card" onclick="alert('Fonctionnalité à venir !')">
                <div class="icon">👨‍⚕️</div>
                <h3>Mes patients</h3>
                <p>Accédez aux dossiers de vos patients et consultez leur historique médical</p>
                <button class="btn">Accéder</button>
            </div>
        </div>
    </div>
</body>
</html>
