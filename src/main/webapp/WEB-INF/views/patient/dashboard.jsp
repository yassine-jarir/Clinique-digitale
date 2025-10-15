<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mon Espace Santé - Clinique</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: #f8f9fd;
            color: #2d3748;
        }

        /* Top Navigation */
        .top-nav {
            background: white;
            border-bottom: 1px solid #e8eaf2;
            padding: 0 32px;
            position: sticky;
            top: 0;
            z-index: 100;
            box-shadow: 0 2px 8px rgba(0,0,0,0.02);
        }

        .nav-content {
            max-width: 1400px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            height: 72px;
        }

        .logo-section {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .logo-icon {
            width: 42px;
            height: 42px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 20px;
        }

        .logo-text h1 {
            font-size: 20px;
            font-weight: 700;
            color: #1a202c;
        }

        .logo-text p {
            font-size: 12px;
            color: #718096;
        }

        .user-menu {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .notification-btn {
            position: relative;
            width: 40px;
            height: 40px;
            border-radius: 10px;
            background: #f7fafc;
            border: none;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s;
        }

        .notification-btn:hover {
            background: #edf2f7;
        }

        .notification-badge {
            position: absolute;
            top: 6px;
            right: 6px;
            width: 8px;
            height: 8px;
            background: #f56565;
            border-radius: 50%;
            border: 2px solid white;
        }

        .user-profile {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 8px 16px 8px 8px;
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.2s;
        }

        .user-profile:hover {
            background: #f7fafc;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 700;
            font-size: 16px;
        }

        .user-info {
            text-align: left;
        }

        .user-name {
            font-size: 14px;
            font-weight: 600;
            color: #2d3748;
            display: block;
        }

        .user-role {
            font-size: 12px;
            color: #718096;
        }

        .logout-link {
            padding: 10px 20px;
            background: #fff5f5;
            color: #e53e3e;
            border-radius: 10px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.2s;
        }

        .logout-link:hover {
            background: #fed7d7;
        }

        /* Main Container */
        .main-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 32px;
        }

        /* Hero Section */
        .hero-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 24px;
            padding: 48px;
            margin-bottom: 32px;
            position: relative;
            overflow: hidden;
        }

        .hero-section::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -20%;
            width: 400px;
            height: 400px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
        }

        .hero-content {
            position: relative;
            z-index: 1;
        }

        .hero-greeting {
            color: rgba(255, 255, 255, 0.9);
            font-size: 16px;
            margin-bottom: 8px;
        }

        .hero-title {
            color: white;
            font-size: 36px;
            font-weight: 800;
            margin-bottom: 12px;
        }

        .hero-subtitle {
            color: rgba(255, 255, 255, 0.85);
            font-size: 18px;
            max-width: 600px;
        }

        /* Quick Actions */
        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
            margin-bottom: 32px;
        }

        .action-card {
            background: white;
            border-radius: 20px;
            padding: 28px;
            display: flex;
            align-items: flex-start;
            gap: 20px;
            cursor: pointer;
            transition: all 0.3s;
            border: 2px solid transparent;
            text-decoration: none;
            color: inherit;
        }

        .action-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 24px rgba(0,0,0,0.08);
            border-color: #e8eaf2;
        }

        .action-icon {
            width: 56px;
            height: 56px;
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            flex-shrink: 0;
        }

        .action-card:nth-child(1) .action-icon {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .action-card:nth-child(2) .action-icon {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
        }

        .action-card:nth-child(3) .action-icon {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
        }

        .action-card:nth-child(4) .action-icon {
            background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
            color: white;
        }

        .action-content h3 {
            font-size: 18px;
            font-weight: 700;
            margin-bottom: 6px;
            color: #1a202c;
        }

        .action-content p {
            font-size: 14px;
            color: #718096;
            line-height: 1.5;
        }

        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
            margin-bottom: 32px;
        }

        .stat-card {
            background: white;
            border-radius: 20px;
            padding: 24px;
            position: relative;
            overflow: hidden;
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
        }

        .stat-card:nth-child(1)::before {
            background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
        }

        .stat-card:nth-child(2)::before {
            background: linear-gradient(90deg, #f093fb 0%, #f5576c 100%);
        }

        .stat-card:nth-child(3)::before {
            background: linear-gradient(90deg, #4facfe 0%, #00f2fe 100%);
        }

        .stat-label {
            font-size: 13px;
            color: #718096;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .stat-value {
            font-size: 32px;
            font-weight: 800;
            color: #1a202c;
            margin-bottom: 4px;
        }

        .stat-trend {
            font-size: 13px;
            color: #48bb78;
            font-weight: 600;
        }

        /* Content Grid */
        .content-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 24px;
        }

        @media (max-width: 1024px) {
            .content-grid {
                grid-template-columns: 1fr;
            }
        }

        /* Card Styles */
        .content-card {
            background: white;
            border-radius: 20px;
            padding: 28px;
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
        }

        .card-title {
            font-size: 20px;
            font-weight: 700;
            color: #1a202c;
        }

        .view-all-btn {
            font-size: 14px;
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: all 0.2s;
        }

        .view-all-btn:hover {
            gap: 10px;
        }

        /* Appointment List */
        .appointment-item {
            padding: 20px;
            border-radius: 16px;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            gap: 16px;
            transition: all 0.2s;
            border: 2px solid #f7fafc;
        }

        .appointment-item:hover {
            border-color: #e8eaf2;
            background: #f7fafc;
        }

        .appointment-date {
            width: 64px;
            height: 64px;
            border-radius: 14px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: white;
            flex-shrink: 0;
        }

        .appointment-day {
            font-size: 24px;
            font-weight: 800;
            line-height: 1;
        }

        .appointment-month {
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
        }

        .appointment-info {
            flex: 1;
        }

        .appointment-doctor {
            font-size: 16px;
            font-weight: 700;
            color: #1a202c;
            margin-bottom: 4px;
        }

        .appointment-specialty {
            font-size: 14px;
            color: #718096;
            margin-bottom: 4px;
        }

        .appointment-time {
            font-size: 13px;
            color: #667eea;
            font-weight: 600;
        }

        .appointment-status {
            padding: 6px 14px;
            border-radius: 8px;
            font-size: 12px;
            font-weight: 700;
        }

        .status-confirmed {
            background: #c6f6d5;
            color: #22543d;
        }

        .status-pending {
            background: #feebc8;
            color: #7c2d12;
        }

        /* Health Tips */
        .health-tip {
            padding: 20px;
            border-radius: 16px;
            margin-bottom: 16px;
            border-left: 4px solid;
        }

        .health-tip:nth-child(1) {
            background: #f0f4ff;
            border-color: #667eea;
        }

        .health-tip:nth-child(2) {
            background: #fff5f7;
            border-color: #f093fb;
        }

        .health-tip:nth-child(3) {
            background: #f0fdf4;
            border-color: #43e97b;
        }

        .tip-icon {
            font-size: 24px;
            margin-bottom: 12px;
        }

        .tip-title {
            font-size: 16px;
            font-weight: 700;
            color: #1a202c;
            margin-bottom: 8px;
        }

        .tip-content {
            font-size: 14px;
            color: #4a5568;
            line-height: 1.6;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 48px 20px;
        }

        .empty-icon {
            font-size: 64px;
            color: #cbd5e0;
            margin-bottom: 16px;
        }

        .empty-title {
            font-size: 18px;
            font-weight: 600;
            color: #4a5568;
            margin-bottom: 8px;
        }

        .empty-text {
            font-size: 14px;
            color: #718096;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .main-container {
                padding: 20px;
            }

            .hero-section {
                padding: 32px 24px;
            }

            .hero-title {
                font-size: 28px;
            }

            .quick-actions {
                grid-template-columns: 1fr;
            }

            .nav-content {
                padding: 0 16px;
            }
        }
    </style>
</head>
<body>
    <!-- Top Navigation -->
    <nav class="top-nav">
        <div class="nav-content">
            <div class="logo-section">
                <div class="logo-icon">
                    <i class="fas fa-heartbeat"></i>
                </div>
                <div class="logo-text">
                    <h1>Clinique Digitale</h1>
                    <p>Votre santé, notre priorité</p>
                </div>
            </div>

            <div class="user-menu">
                <button class="notification-btn">
                    <i class="fas fa-bell"></i>
                    <span class="notification-badge"></span>
                </button>

                <div class="user-profile">
                    <div class="user-avatar">
                        ${sessionScope.nom.substring(0,1).toUpperCase()}
                    </div>
                    <div class="user-info">
                        <span class="user-name">${sessionScope.nom}</span>
                        <span class="user-role">Patient</span>
                    </div>
                </div>

                <a href="${pageContext.request.contextPath}/logout" class="logout-link">
                    <i class="fas fa-sign-out-alt"></i> Déconnexion
                </a>
            </div>
        </div>
    </nav>

    <!-- Main Container -->
    <div class="main-container">
        <!-- Hero Section -->
        <div class="hero-section">
            <div class="hero-content">
                <p class="hero-greeting">Bonjour,</p>
                <h2 class="hero-title">Bienvenue ${sessionScope.nom} 👋</h2>
                <p class="hero-subtitle">Gérez vos rendez-vous médicaux, consultez votre dossier et restez en contact avec vos médecins</p>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="quick-actions">
            <a href="#" class="action-card">
                <div class="action-icon">
                    <i class="fas fa-calendar-plus"></i>
                </div>
                <div class="action-content">
                    <h3>Nouveau Rendez-vous</h3>
                    <p>Prenez rendez-vous avec un spécialiste</p>
                </div>
            </a>

            <a href="#" class="action-card">
                <div class="action-icon">
                    <i class="fas fa-folder-open"></i>
                </div>
                <div class="action-content">
                    <h3>Mon Dossier</h3>
                    <p>Consultez votre historique médical</p>
                </div>
            </a>

            <a href="#" class="action-card">
                <div class="action-icon">
                    <i class="fas fa-user-md"></i>
                </div>
                <div class="action-content">
                    <h3>Mes Médecins</h3>
                    <p>Voir tous vos médecins traitants</p>
                </div>
            </a>

            <a href="#" class="action-card">
                <div class="action-icon">
                    <i class="fas fa-file-prescription"></i>
                </div>
                <div class="action-content">
                    <h3>Ordonnances</h3>
                    <p>Accédez à vos prescriptions</p>
                </div>
            </a>
        </div>

        <!-- Stats Grid -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-label">Rendez-vous ce mois</div>
                <div class="stat-value">3</div>
                <div class="stat-trend">
                    <i class="fas fa-arrow-up"></i> +2 ce mois
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-label">Consultations totales</div>
                <div class="stat-value">12</div>
                <div class="stat-trend">
                    <i class="fas fa-check-circle"></i> Depuis 6 mois
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-label">Prochain RDV</div>
                <div class="stat-value">18 Oct</div>
                <div class="stat-trend">
                    <i class="fas fa-clock"></i> Dans 4 jours
                </div>
            </div>
        </div>

        <!-- Content Grid -->
        <div class="content-grid">
            <!-- Appointments -->
            <div class="content-card">
                <div class="card-header">
                    <h3 class="card-title">Mes Prochains Rendez-vous</h3>
                    <a href="#" class="view-all-btn">
                        Voir tout <i class="fas fa-arrow-right"></i>
                    </a>
                </div>

                <div class="appointment-item">
                    <div class="appointment-date">
                        <span class="appointment-day">18</span>
                        <span class="appointment-month">Oct</span>
                    </div>
                    <div class="appointment-info">
                        <div class="appointment-doctor">Dr. Sarah Martin</div>
                        <div class="appointment-specialty">Cardiologie</div>
                        <div class="appointment-time">
                            <i class="fas fa-clock"></i> 10:00 - 10:30
                        </div>
                    </div>
                    <span class="appointment-status status-confirmed">Confirmé</span>
                </div>

                <div class="appointment-item">
                    <div class="appointment-date">
                        <span class="appointment-day">22</span>
                        <span class="appointment-month">Oct</span>
                    </div>
                    <div class="appointment-info">
                        <div class="appointment-doctor">Dr. Ahmed Benali</div>
                        <div class="appointment-specialty">Médecine Générale</div>
                        <div class="appointment-time">
                            <i class="fas fa-clock"></i> 14:30 - 15:00
                        </div>
                    </div>
                    <span class="appointment-status status-pending">En attente</span>
                </div>

                <div class="appointment-item">
                    <div class="appointment-date">
                        <span class="appointment-day">25</span>
                        <span class="appointment-month">Oct</span>
                    </div>
                    <div class="appointment-info">
                        <div class="appointment-doctor">Dr. Fatima El Idrissi</div>
                        <div class="appointment-specialty">Dermatologie</div>
                        <div class="appointment-time">
                            <i class="fas fa-clock"></i> 11:00 - 11:30
                        </div>
                    </div>
                    <span class="appointment-status status-confirmed">Confirmé</span>
                </div>
            </div>

            <!-- Health Tips -->
            <div class="content-card">
                <div class="card-header">
                    <h3 class="card-title">Conseils Santé</h3>
                </div>

                <div class="health-tip">
                    <div class="tip-icon">💧</div>
                    <div class="tip-title">Hydratation</div>
                    <div class="tip-content">
                        Buvez au moins 1,5L d'eau par jour pour maintenir une bonne hydratation.
                    </div>
                </div>

                <div class="health-tip">
                    <div class="tip-icon">🏃‍♂️</div>
                    <div class="tip-title">Activité Physique</div>
                    <div class="tip-content">
                        30 minutes de marche quotidienne améliorent votre santé cardiovasculaire.
                    </div>
                </div>

                <div class="health-tip">
                    <div class="tip-icon">😴</div>
                    <div class="tip-title">Sommeil Réparateur</div>
                    <div class="tip-content">
                        Visez 7-8 heures de sommeil pour une récupération optimale.
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

