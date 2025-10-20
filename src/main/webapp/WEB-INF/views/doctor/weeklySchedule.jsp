<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mon Emploi du Temps Hebdomadaire</title>
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
            background: linear-gradient(180deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            padding: 20px 0;
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
            font-size: 2em;
            color: #1e3c72;
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
            background: linear-gradient(135deg, #667eea, #764ba2);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
        }

        .logout-btn {
            background: #dc3545;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s;
        }

        .logout-btn:hover {
            background: #c82333;
        }

        /* Alert Messages */
        .alert {
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .alert.success {
            background: #d4edda;
            color: #155724;
            border-left: 4px solid #28a745;
        }

        .alert.error {
            background: #f8d7da;
            color: #721c24;
            border-left: 4px solid #dc3545;
        }

        /* Cards */
        .card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 30px;
        }

        .card h2 {
            font-size: 1.5em;
            color: #1e3c72;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .info-box {
            background: #e3f2fd;
            border-left: 4px solid #2196f3;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 25px;
        }

        .info-box strong {
            color: #1565c0;
        }

        /* Weekly Schedule Table */
        .schedule-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 10px;
        }

        .schedule-table thead th {
            background: #f8f9fa;
            padding: 15px;
            text-align: left;
            font-weight: 600;
            color: #495057;
            border-bottom: 2px solid #dee2e6;
        }

        .schedule-table tbody tr {
            background: white;
            transition: all 0.3s;
        }

        .schedule-table tbody tr:hover {
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transform: translateY(-2px);
        }

        .schedule-table tbody td {
            padding: 15px;
            border-top: 1px solid #e9ecef;
            border-bottom: 1px solid #e9ecef;
        }

        .schedule-table tbody td:first-child {
            border-left: 1px solid #e9ecef;
            border-radius: 10px 0 0 10px;
        }

        .schedule-table tbody td:last-child {
            border-right: 1px solid #e9ecef;
            border-radius: 0 10px 10px 0;
        }

        .day-label {
            font-weight: 600;
            font-size: 1.1em;
            color: #495057;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .day-label .day-icon {
            font-size: 1.3em;
        }

        /* Toggle Switch */
        .toggle-switch {
            position: relative;
            display: inline-block;
            width: 60px;
            height: 30px;
        }

        .toggle-switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        .toggle-slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            transition: 0.4s;
            border-radius: 30px;
        }

        .toggle-slider:before {
            position: absolute;
            content: "";
            height: 22px;
            width: 22px;
            left: 4px;
            bottom: 4px;
            background-color: white;
            transition: 0.4s;
            border-radius: 50%;
        }

        input:checked + .toggle-slider {
            background-color: #4CAF50;
        }

        input:checked + .toggle-slider:before {
            transform: translateX(30px);
        }

        /* Time Inputs */
        .time-input-group {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .time-input-group input[type="time"] {
            padding: 10px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1em;
            transition: all 0.3s;
            width: 130px;
        }

        .time-input-group input[type="time"]:focus {
            outline: none;
            border-color: #4CAF50;
            box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.1);
        }

        .time-input-group input[type="time"]:disabled {
            background: #f5f5f5;
            cursor: not-allowed;
            opacity: 0.6;
        }

        .time-separator {
            font-weight: bold;
            color: #666;
            font-size: 1.2em;
        }

        /* Form Group */
        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            color: #495057;
            margin-bottom: 8px;
        }

        .form-group input[type="text"],
        .form-group input[type="date"] {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1em;
            transition: all 0.3s;
        }

        .form-group input:focus {
            outline: none;
            border-color: #4CAF50;
            box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.1);
        }

        .form-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }

        /* Buttons */
        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            font-size: 1em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
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
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .btn-success {
            background: #28a745;
            color: white;
        }

        .btn-success:hover {
            background: #218838;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(40, 167, 69, 0.4);
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background: #5a6268;
        }

        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 25px;
        }

        /* Calendar View */
        .calendar-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
            gap: 15px;
            margin-top: 20px;
        }

        .calendar-slot {
            padding: 15px;
            border-radius: 10px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
            border: 2px solid transparent;
        }

        .calendar-slot.available {
            background: #d4edda;
            border-color: #28a745;
        }

        .calendar-slot.blocked {
            background: #f8d7da;
            border-color: #dc3545;
        }

        .calendar-slot.booked {
            background: #cce5ff;
            border-color: #004085;
        }

        .calendar-slot:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }

        .slot-day {
            font-weight: 600;
            font-size: 0.9em;
            margin-bottom: 5px;
        }

        .slot-time {
            font-size: 0.85em;
            opacity: 0.8;
        }

        .legend {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 8px;
        }

        .legend-item {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .legend-color {
            width: 20px;
            height: 20px;
            border-radius: 4px;
        }

        .tabs {
            display: flex;
            gap: 10px;
            margin-bottom: 25px;
            border-bottom: 2px solid #e9ecef;
        }

        .tab-btn {
            padding: 12px 25px;
            background: none;
            border: none;
            border-bottom: 3px solid transparent;
            cursor: pointer;
            font-weight: 600;
            color: #6c757d;
            transition: all 0.3s;
        }

        .tab-btn.active {
            color: #1e3c72;
            border-bottom-color: #1e3c72;
        }

        .tab-content {
            display: none;
        }

        .tab-content.active {
            display: block;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <h2>Dr. ${doctor.nom}</h2>
            <p>Espace Médecin</p>
        </div>
        <div class="sidebar-menu">
            <a href="${pageContext.request.contextPath}/doctor/dashboard" class="menu-item">
                <span class="icon">🏠</span>
                <span class="text">Tableau de bord</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/weekly-schedule" class="menu-item active">
                <span class="icon">📅</span>
                <span class="text">Emploi du temps</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/availabilities" class="menu-item">
                <span class="icon">⏰</span>
                <span class="text">Disponibilités</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/appointments" class="menu-item">
                <span class="icon">📋</span>
                <span class="text">Rendez-vous</span>
            </a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Header -->
        <div class="top-header">
            <h1>📅 Mon Emploi du Temps Hebdomadaire</h1>
            <div class="user-info">
                <div class="user-avatar">Dr</div>
                <button class="logout-btn" onclick="location.href='${pageContext.request.contextPath}/logout'">Déconnexion</button>
            </div>
        </div>

        <!-- Success/Error Messages -->
        <c:if test="${not empty sessionScope.success}">
            <div class="alert success">
                <span style="font-size: 1.5em;">✅</span>
                <span>${sessionScope.success}</span>
            </div>
            <c:remove var="success" scope="session" />
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert error">
                <span style="font-size: 1.5em;">⚠️</span>
                <span>${error}</span>
            </div>
        </c:if>

        <!-- Tabs -->
        <div class="tabs">
            <button class="tab-btn active" onclick="switchTab('template')">📝 Configurer l'emploi du temps</button>
            <button class="tab-btn" onclick="switchTab('generate')">🔄 Générer les disponibilités</button>
            <button class="tab-btn" onclick="switchTab('calendar')">📆 Vue Calendrier</button>
        </div>

        <!-- Tab 1: Template Configuration -->
        <div id="template-tab" class="tab-content active">
            <div class="card">
                <h2>📝 Définir votre emploi du temps hebdomadaire</h2>
                <div class="info-box">
                    <strong>💡 Conseil:</strong> Configurez votre emploi du temps type pour la semaine.
                    Vous pourrez ensuite l'appliquer automatiquement sur plusieurs semaines.
                </div>

                <form method="post" action="${pageContext.request.contextPath}/doctor/weekly-schedule">
                    <input type="hidden" name="action" value="saveTemplate">

                    <div class="form-group">
                        <label for="templateName">Nom de l'emploi du temps (optionnel)</label>
                        <input type="text" id="templateName" name="templateName"
                               placeholder="Ex: Horaire d'hiver 2024"
                               value="${templates.size() > 0 ? templates[0].templateName : ''}">
                    </div>

                    <table class="schedule-table">
                        <thead>
                            <tr>
                                <th>Jour</th>
                                <th style="text-align: center;">Actif</th>
                                <th>Horaires</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="days" value="Lundi,Mardi,Mercredi,Jeudi,Vendredi,Samedi,Dimanche" />
                            <c:set var="icons" value="🌙,🔥,💚,⚡,🎉,🌟,☀️" />
                            <c:forEach var="day" items="${days.split(',')}" varStatus="status">
                                <c:set var="dayIcons" value="${icons.split(',')}" />
                                <c:set var="template" value="${null}" />
                                <c:forEach var="t" items="${templates}">
                                    <c:if test="${t.dayOfWeek == day}">
                                        <c:set var="template" value="${t}" />
                                    </c:if>
                                </c:forEach>

                                <tr>
                                    <td>
                                        <div class="day-label">
                                            <span class="day-icon">${dayIcons[status.index]}</span>
                                            <span>${day}</span>
                                        </div>
                                    </td>
                                    <td style="text-align: center;">
                                        <label class="toggle-switch">
                                            <input type="checkbox"
                                                   name="active_${day}"
                                                   id="active_${day}"
                                                   onchange="toggleDayInputs('${day}')"
                                                   ${template != null && template.isActive ? 'checked' : ''}>
                                            <span class="toggle-slider"></span>
                                        </label>
                                    </td>
                                    <td>
                                        <div class="time-input-group">
                                            <input type="time"
                                                   name="startTime_${day}"
                                                   id="startTime_${day}"
                                                   value="${template != null && template.startTime != null ? template.startTime : '08:00'}"
                                                   ${template == null || !template.isActive ? 'disabled' : ''}>
                                            <span class="time-separator">→</span>
                                            <input type="time"
                                                   name="endTime_${day}"
                                                   id="endTime_${day}"
                                                   value="${template != null && template.endTime != null ? template.endTime : '17:00'}"
                                                   ${template == null || !template.isActive ? 'disabled' : ''}>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <div class="button-group">
                        <button type="submit" class="btn btn-primary">
                            💾 Enregistrer l'emploi du temps
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Tab 2: Generate Availabilities -->
        <div id="generate-tab" class="tab-content">
            <div class="card">
                <h2>🔄 Générer les disponibilités à partir de l'emploi du temps</h2>
                <div class="info-box">
                    <strong>ℹ️ Information:</strong> Cette fonctionnalité applique votre emploi du temps hebdomadaire
                    sur la période sélectionnée. Les créneaux seront créés automatiquement.
                </div>

                <c:choose>
                    <c:when test="${empty templates or templates.stream().noneMatch(t -> t.isActive)}">
                        <div style="text-align: center; padding: 40px; color: #6c757d;">
                            <div style="font-size: 3em; margin-bottom: 15px;">📋</div>
                            <h3>Aucun emploi du temps défini</h3>
                            <p style="margin-top: 10px;">Veuillez d'abord configurer votre emploi du temps hebdomadaire.</p>
                            <button class="btn btn-primary" onclick="switchTab('template')" style="margin-top: 20px;">
                                Configurer maintenant
                            </button>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <form method="post" action="${pageContext.request.contextPath}/doctor/weekly-schedule">
                            <input type="hidden" name="action" value="generateAvailabilities">

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="startDate">Date de début *</label>
                                    <input type="date" id="startDate" name="startDate" required>
                                </div>
                                <div class="form-group">
                                    <label for="endDate">Date de fin *</label>
                                    <input type="date" id="endDate" name="endDate" required>
                                </div>
                            </div>

                            <div class="info-box" style="background: #fff3cd; border-color: #ffc107;">
                                <strong>⚠️ Attention:</strong> Cette opération créera des créneaux pour tous les jours actifs
                                de votre emploi du temps dans la période sélectionnée. Les créneaux existants ne seront pas dupliqués.
                            </div>

                            <div class="button-group">
                                <button type="submit" class="btn btn-success">
                                    🚀 Générer les disponibilités
                                </button>
                            </div>
                        </form>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Tab 3: Calendar View -->
        <div id="calendar-tab" class="tab-content">
            <div class="card">
                <h2>📆 Vue Calendrier de vos disponibilités</h2>

                <div class="legend">
                    <div class="legend-item">
                        <div class="legend-color" style="background: #d4edda; border: 2px solid #28a745;"></div>
                        <span>Disponible</span>
                    </div>
                    <div class="legend-item">
                        <div class="legend-color" style="background: #f8d7da; border: 2px solid #dc3545;"></div>
                        <span>Bloqué</span>
                    </div>
                    <div class="legend-item">
                        <div class="legend-color" style="background: #cce5ff; border: 2px solid #004085;"></div>
                        <span>Réservé</span>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${empty availabilities}">
                        <div style="text-align: center; padding: 40px; color: #6c757d;">
                            <div style="font-size: 3em; margin-bottom: 15px;">📅</div>
                            <h3>Aucune disponibilité</h3>
                            <p style="margin-top: 10px;">Générez vos disponibilités à partir de votre emploi du temps.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="calendar-grid">
                            <c:forEach var="availability" items="${availabilities}">
                                <div class="calendar-slot ${availability.statut == 'AVAILABLE' ? 'available' : availability.statut == 'BLOCKED' ? 'blocked' : 'booked'}"
                                     onclick="handleSlotClick('${availability.id}', '${availability.statut}')">
                                    <div class="slot-day">${availability.jour}</div>
                                    <div class="slot-time">${availability.heureDebut} - ${availability.heureFin}</div>
                                    <c:if test="${availability.statut == 'AVAILABLE'}">
                                        <small style="display: block; margin-top: 5px; color: #28a745;">✓ Libre</small>
                                    </c:if>
                                    <c:if test="${availability.statut == 'BLOCKED'}">
                                        <small style="display: block; margin-top: 5px; color: #dc3545;">🚫 Bloqué</small>
                                    </c:if>
                                    <c:if test="${availability.statut == 'BOOKED'}">
                                        <small style="display: block; margin-top: 5px; color: #004085;">📅 Réservé</small>
                                    </c:if>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <script>
        function switchTab(tabName) {
            // Hide all tabs
            document.querySelectorAll('.tab-content').forEach(tab => {
                tab.classList.remove('active');
            });
            document.querySelectorAll('.tab-btn').forEach(btn => {
                btn.classList.remove('active');
            });

            // Show selected tab
            document.getElementById(tabName + '-tab').classList.add('active');
            event.target.classList.add('active');
        }

        function toggleDayInputs(day) {
            const checkbox = document.getElementById('active_' + day);
            const startTime = document.getElementById('startTime_' + day);
            const endTime = document.getElementById('endTime_' + day);

            if (checkbox.checked) {
                startTime.disabled = false;
                endTime.disabled = false;
            } else {
                startTime.disabled = true;
                endTime.disabled = true;
            }
        }

        function handleSlotClick(availabilityId, status) {
            if (status === 'AVAILABLE') {
                if (confirm('Voulez-vous bloquer ce créneau ?')) {
                    const form = document.createElement('form');
                    form.method = 'POST';
                    form.action = '${pageContext.request.contextPath}/doctor/weekly-schedule';

                    const actionInput = document.createElement('input');
                    actionInput.type = 'hidden';
                    actionInput.name = 'action';
                    actionInput.value = 'blockSlot';

                    const idInput = document.createElement('input');
                    idInput.type = 'hidden';
                    idInput.name = 'availabilityId';
                    idInput.value = availabilityId;

                    form.appendChild(actionInput);
                    form.appendChild(idInput);
                    document.body.appendChild(form);
                    form.submit();
                }
            } else if (status === 'BLOCKED') {
                if (confirm('Voulez-vous débloquer ce créneau ?')) {
                    const form = document.createElement('form');
                    form.method = 'POST';
                    form.action = '${pageContext.request.contextPath}/doctor/weekly-schedule';

                    const actionInput = document.createElement('input');
                    actionInput.type = 'hidden';
                    actionInput.name = 'action';
                    actionInput.value = 'unblockSlot';

                    const idInput = document.createElement('input');
                    idInput.type = 'hidden';
                    idInput.name = 'availabilityId';
                    idInput.value = availabilityId;

                    form.appendChild(actionInput);
                    form.appendChild(idInput);
                    document.body.appendChild(form);
                    form.submit();
                }
            }
        }

        // Set minimum date to today
        document.addEventListener('DOMContentLoaded', function() {
            const today = new Date().toISOString().split('T')[0];
            const startDate = document.getElementById('startDate');
            const endDate = document.getElementById('endDate');

            if (startDate) {
                startDate.min = today;
                startDate.addEventListener('change', function() {
                    if (endDate) {
                        endDate.min = this.value;
                    }
                });
            }

            if (endDate) {
                endDate.min = today;
            }
        });
    </script>
</body>
</html>

