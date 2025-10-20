<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gérer mes disponibilités</title>
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

        /* Tabs */
        .tabs {
            display: flex;
            gap: 10px;
            margin-bottom: 30px;
            background: white;
            padding: 10px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .tab-btn {
            flex: 1;
            padding: 15px 20px;
            background: transparent;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 1em;
            font-weight: 500;
            color: #666;
            transition: all 0.3s;
        }

        .tab-btn.active {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
        }

        .tab-btn:hover:not(.active) {
            background: #f0f0f0;
        }

        .tab-content {
            display: none;
        }

        .tab-content.active {
            display: block;
        }

        /* Alert Messages */
        .alert {
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .alert.error {
            background: #fee;
            border-left: 4px solid #dc3545;
            color: #721c24;
        }

        .alert.success {
            background: #d4edda;
            border-left: 4px solid #28a745;
            color: #155724;
        }

        /* Form Card */
        .form-card {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.06);
            margin-bottom: 30px;
        }

        .form-card h2 {
            color: #1e3c72;
            margin-bottom: 20px;
            font-size: 1.4em;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 500;
        }

        .form-group select,
        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 1em;
            transition: border-color 0.3s;
        }

        .form-group select:focus,
        .form-group input:focus {
            outline: none;
            border-color: #1e3c72;
        }

        .form-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
        }

        /* Weekly Schedule Styles */
        .schedule-grid {
            display: flex;
            flex-direction: column;
            gap: 15px;
            margin-top: 20px;
        }

        .schedule-row {
            display: grid;
            grid-template-columns: 150px 1fr;
            gap: 20px;
            padding: 20px;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            transition: all 0.3s;
            align-items: center;
        }

        .schedule-row.active {
            border-color: #1e3c72;
            background: #f8f9ff;
        }

        .day-checkbox {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .day-checkbox input[type="checkbox"] {
            width: 20px;
            height: 20px;
            cursor: pointer;
        }

        .day-checkbox label {
            font-weight: 600;
            cursor: pointer;
            margin: 0;
        }

        .time-inputs {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .time-inputs.disabled {
            opacity: 0.5;
        }

        .time-group {
            display: flex;
            flex-direction: column;
            flex: 1;
        }

        .time-group label {
            font-size: 0.85em;
            color: #666;
            margin-bottom: 5px;
        }

        .time-separator {
            font-size: 1.5em;
            color: #1e3c72;
            font-weight: bold;
            margin-top: 20px;
        }

        .quick-actions {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }

        .btn-secondary {
            padding: 8px 16px;
            background: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.9em;
            transition: all 0.3s;
        }

        .btn-secondary:hover {
            background: #e9ecef;
        }

        .btn-primary {
            background: #1e3c72;
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 6px;
            font-size: 1em;
            cursor: pointer;
            transition: background 0.3s;
        }

        .btn-primary:hover {
            background: #2a5298;
        }

        /* Table */
        .table-card {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.06);
        }

        .table-card h2 {
            color: #1e3c72;
            margin-bottom: 20px;
            font-size: 1.4em;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: #f8f9fa;
        }

        th {
            padding: 15px;
            text-align: left;
            font-weight: 600;
            color: #555;
            border-bottom: 2px solid #dee2e6;
        }

        td {
            padding: 15px;
            border-bottom: 1px solid #dee2e6;
        }

        tbody tr:hover {
            background: #f8f9fa;
        }

        .btn-delete {
            background: #dc3545;
            color: white;
            border: none;
            padding: 6px 15px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.9em;
            transition: background 0.3s;
        }

        .btn-delete:hover {
            background: #c82333;
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

        .info-box {
            background: #e7f3ff;
            border-left: 4px solid #1e3c72;
            padding: 15px 20px;
            border-radius: 8px;
            margin-top: 20px;
            font-size: 0.95em;
        }

        .info-box strong {
            color: #1e3c72;
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

            .form-row {
                grid-template-columns: 1fr;
            }

            .schedule-row {
                grid-template-columns: 1fr;
            }

            table {
                font-size: 0.9em;
            }

            th, td {
                padding: 10px;
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
            <a href="${pageContext.request.contextPath}/doctor/dashboard" class="menu-item">
                <span class="icon">🏠</span>
                <span class="text">Dashboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/doctor/availabilities" class="menu-item active">
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
            <h1>Gérer mes disponibilités</h1>
            <div class="user-info">
                <div class="user-avatar">Dr</div>
                <button class="logout-btn" onclick="location.href='${pageContext.request.contextPath}/logout'">Déconnexion</button>
            </div>
        </div>

        <!-- Error Message -->
        <c:if test="${not empty error}">
            <div class="alert error">
                <span style="font-size: 1.5em;">⚠️</span>
                <span>${error}</span>
            </div>
        </c:if>

        <!-- Bulk Availability Tab -->
        <div id="bul-tab" class="ta-content">
            <div class="form-card">
                <h2>📅 Planification hebdomadaire</h2>
                <p style="color: #666; margin-bottom: 20px;">Définissez votre emploi du temps pour une période donnée</p>

                <form method="post" action="${pageContext.request.contextPath}/doctor/availabilities/bulk" id="bulkForm">
                    <!-- Date Range -->
                    <div class="form-row">
                        <div class="form-group">
                            <label for="startDate">Date de début *</label>
                            <input type="date" name="startDate" id="startDate" required>
                        </div>
                        <div class="form-group">
                            <label for="endDate">Date de fin *</label>
                            <input type="date" name="endDate" id="endDate" required>
                        </div>
                    </div>

                    <!-- Quick Actions -->
                    <div class="quick-actions">
                        <button type="button" class="btn-secondary" onclick="toggleAllDays(true)">Tout sélectionner</button>
                        <button type="button" class="btn-secondary" onclick="toggleAllDays(false)">Tout désélectionner</button>
                        <button type="button" class="btn-secondary" onclick="copyTimesToAll()">Copier les horaires</button>
                    </div>

                    <!-- Schedule Grid -->
                    <div class="schedule-grid">
                        <div class="schedule-row" data-day="Lundi">
                            <div class="day-checkbox">
                                <input type="checkbox" id="day-1" name="days" value="Lundi" onchange="toggleDay(this)">
                                <label for="day-1">Lundi</label>
                            </div>
                            <div class="time-inputs disabled">
                                <div class="time-group">
                                    <label>Début</label>
                                    <input type="time" name="startTime_Lundi" value="08:00" disabled>
                                </div>
                                <span class="time-separator">→</span>
                                <div class="time-group">
                                    <label>Fin</label>
                                    <input type="time" name="endTime_Lundi" value="17:00" disabled>
                                </div>
                            </div>
                        </div>

                        <div class="schedule-row" data-day="Mardi">
                            <div class="day-checkbox">
                                <input type="checkbox" id="day-2" name="days" value="Mardi" onchange="toggleDay(this)">
                                <label for="day-2">Mardi</label>
                            </div>
                            <div class="time-inputs disabled">
                                <div class="time-group">
                                    <label>Début</label>
                                    <input type="time" name="startTime_Mardi" value="08:00" disabled>
                                </div>
                                <span class="time-separator">→</span>
                                <div class="time-group">
                                    <label>Fin</label>
                                    <input type="time" name="endTime_Mardi" value="17:00" disabled>
                                </div>
                            </div>
                        </div>

                        <div class="schedule-row" data-day="Mercredi">
                            <div class="day-checkbox">
                                <input type="checkbox" id="day-3" name="days" value="Mercredi" onchange="toggleDay(this)">
                                <label for="day-3">Mercredi</label>
                            </div>
                            <div class="time-inputs disabled">
                                <div class="time-group">
                                    <label>Début</label>
                                    <input type="time" name="startTime_Mercredi" value="08:00" disabled>
                                </div>
                                <span class="time-separator">→</span>
                                <div class="time-group">
                                    <label>Fin</label>
                                    <input type="time" name="endTime_Mercredi" value="17:00" disabled>
                                </div>
                            </div>
                        </div>

                        <div class="schedule-row" data-day="Jeudi">
                            <div class="day-checkbox">
                                <input type="checkbox" id="day-4" name="days" value="Jeudi" onchange="toggleDay(this)">
                                <label for="day-4">Jeudi</label>
                            </div>
                            <div class="time-inputs disabled">
                                <div class="time-group">
                                    <label>Début</label>
                                    <input type="time" name="startTime_Jeudi" value="08:00" disabled>
                                </div>
                                <span class="time-separator">→</span>
                                <div class="time-group">
                                    <label>Fin</label>
                                    <input type="time" name="endTime_Jeudi" value="17:00" disabled>
                                </div>
                            </div>
                        </div>

                        <div class="schedule-row" data-day="Vendredi">
                            <div class="day-checkbox">
                                <input type="checkbox" id="day-5" name="days" value="Vendredi" onchange="toggleDay(this)">
                                <label for="day-5">Vendredi</label>
                            </div>
                            <div class="time-inputs disabled">
                                <div class="time-group">
                                    <label>Début</label>
                                    <input type="time" name="startTime_Vendredi" value="08:00" disabled>
                                </div>
                                <span class="time-separator">→</span>
                                <div class="time-group">
                                    <label>Fin</label>
                                    <input type="time" name="endTime_Vendredi" value="17:00" disabled>
                                </div>
                            </div>
                        </div>

                        <div class="schedule-row" data-day="Samedi">
                            <div class="day-checkbox">
                                <input type="checkbox" id="day-6" name="days" value="Samedi" onchange="toggleDay(this)">
                                <label for="day-6">Samedi</label>
                            </div>
                            <div class="time-inputs disabled">
                                <div class="time-group">
                                    <label>Début</label>
                                    <input type="time" name="startTime_Samedi" value="08:00" disabled>
                                </div>
                                <span class="time-separator">→</span>
                                <div class="time-group">
                                    <label>Fin</label>
                                    <input type="time" name="endTime_Samedi" value="17:00" disabled>
                                </div>
                            </div>
                        </div>

                        <div class="schedule-row" data-day="Dimanche">
                            <div class="day-checkbox">
                                <input type="checkbox" id="day-7" name="days" value="Dimanche" onchange="toggleDay(this)">
                                <label for="day-7">Dimanche</label>
                            </div>
                            <div class="time-inputs disabled">
                                <div class="time-group">
                                    <label>Début</label>
                                    <input type="time" name="startTime_Dimanche" value="08:00" disabled>
                                </div>
                                <span class="time-separator">→</span>
                                <div class="time-group">
                                    <label>Fin</label>
                                    <input type="time" name="endTime_Dimanche" value="17:00" disabled>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="info-box">
                        <p><strong>💡 Astuce :</strong> Les disponibilités seront créées pour chaque jour sélectionné dans la période définie.</p>
                    </div>

                    <button type="submit" class="btn-primary">✅ Enregistrer la planification</button>
                </form>
            </div>
        </div>

        <!-- Availabilities List -->
        <div class="table-card">
            <h2>📋 Mes disponibilités</h2>
            <c:choose>
                <c:when test="${empty availabilities}">
                    <div class="empty-state">
                        <div class="icon">📭</div>
                        <p>Aucune disponibilité enregistrée.</p>
                        <p style="font-size: 0.9em; margin-top: 10px;">Ajoutez vos créneaux horaires ci-dessus pour permettre aux patients de prendre rendez-vous.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <table>
                        <thead>
                            <tr>
                                <th>Jour</th>
                                <th>Heure de début</th>
                                <th>Heure de fin</th>
                                <th>Statut</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="availability" items="${availabilities}">
                                <tr>
                                    <td><strong>${availability.jour}</strong></td>
                                    <td>${availability.heureDebut}</td>
                                    <td>${availability.heureFin}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${availability.valide}">
                                                <span style="color: #28a745; font-weight: 500;">✓ Active</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="color: #dc3545; font-weight: 500;">✗ Inactive</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <form method="post" style="display: inline;" action="${pageContext.request.contextPath}/doctor/availabilities">
                                            <input type="hidden" name="id" value="${availability.id}"/>
                                            <input type="hidden" name="action" value="delete"/>
                                            <button type="submit" class="btn-delete">🗑️ Supprimer</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script>

        function toggleDay(checkbox) {
            const row = checkbox.closest('.schedule-row');
            const timeInputs = row.querySelector('.time-inputs');
            const inputs = timeInputs.querySelectorAll('input[type="time"]');

            if (checkbox.checked) {
                row.classList.add('active');
                timeInputs.classList.remove('disabled');
                inputs.forEach(input => input.disabled = false);
            } else {
                row.classList.remove('active');
                timeInputs.classList.add('disabled');
                inputs.forEach(input => input.disabled = true);
            }
        }

        function toggleAllDays(checked) {
            document.querySelectorAll('input[name="days"]').forEach(checkbox => {
                checkbox.checked = checked;
                toggleDay(checkbox);
            });
        }

        function copyTimesToAll() {
            const firstActive = document.querySelector('.schedule-row.active');
            if (!firstActive) {
                alert('Veuillez d\'abord sélectionner et configurer un jour');
                return;
            }

            const startTime = firstActive.querySelector('input[type="time"][name^="startTime"]').value;
            const endTime = firstActive.querySelector('input[type="time"][name^="endTime"]').value;

            document.querySelectorAll('.schedule-row.active').forEach(row => {
                row.querySelector('input[type="time"][name^="startTime"]').value = startTime;
                row.querySelector('input[type="time"][name^="endTime"]').value = endTime;
            });
        }

        // Set minimum date to today
        document.addEventListener('DOMContentLoaded', function() {
            const today = new Date().toISOString().split('T')[0];
            document.getElementById('startDate').min = today;
            document.getElementById('endDate').min = today;

            document.getElementById('startDate').addEventListener('change', function() {
                document.getElementById('endDate').min = this.value;
            });
        });
    </script>
</body>
</html>
