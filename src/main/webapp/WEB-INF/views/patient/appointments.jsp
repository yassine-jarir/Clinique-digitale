<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mes Rendez-vous</title>
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

        .top-nav {
            background: white;
            padding: 20px 40px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .nav-title h1 {
            font-size: 1.8em;
            color: #667eea;
        }

        .nav-actions {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .btn-secondary {
            background: white;
            color: #667eea;
            padding: 12px 25px;
            border: 2px solid #667eea;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s;
        }

        .btn-secondary:hover {
            background: #667eea;
            color: white;
        }

        .container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .alert {
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .alert.error {
            background: #fee;
            color: #c33;
            border-left: 4px solid #c33;
        }

        .alert.success {
            background: #efe;
            color: #3c3;
            border-left: 4px solid #3c3;
        }

        .appointments-grid {
            display: grid;
            gap: 20px;
        }

        .appointment-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            transition: all 0.3s;
            border-left: 5px solid #667eea;
        }

        .appointment-card:hover {
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            transform: translateY(-3px);
        }

        .appointment-card.canceled {
            border-left-color: #dc3545;
            opacity: 0.7;
        }

        .appointment-card.completed {
            border-left-color: #28a745;
        }

        .appointment-header {
            display: flex;
            justify-content: space-between;
            align-items: start;
            margin-bottom: 20px;
        }

        .appointment-date {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 1.3em;
            font-weight: 600;
            color: #333;
        }

        .status-badge {
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: 600;
            text-transform: uppercase;
        }

        .status-badge.planned {
            background: #e3f2fd;
            color: #1976d2;
        }

        .status-badge.completed {
            background: #e8f5e9;
            color: #388e3c;
        }

        .status-badge.canceled {
            background: #ffebee;
            color: #d32f2f;
        }

        .appointment-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-bottom: 20px;
        }

        .detail-item {
            display: flex;
            align-items: center;
            gap: 10px;
            color: #666;
        }

        .detail-item .icon {
            font-size: 1.3em;
        }

        .detail-item .label {
            font-size: 0.85em;
            color: #999;
        }

        .detail-item .value {
            font-weight: 600;
            color: #333;
        }

        .appointment-actions {
            display: flex;
            gap: 10px;
            padding-top: 15px;
            border-top: 1px solid #eee;
        }

        .btn-cancel {
            background: #dc3545;
            color: white;
            padding: 8px 20px;
            border: none;
            border-radius: 6px;
            font-size: 0.9em;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-cancel:hover {
            background: #c82333;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .empty-state .icon {
            font-size: 4em;
            margin-bottom: 20px;
        }

        .empty-state h2 {
            font-size: 1.5em;
            color: #666;
            margin-bottom: 10px;
        }

        .empty-state p {
            color: #999;
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
    <div class="top-nav">
        <div class="nav-title">
            <h1>📋 Mes Rendez-vous</h1>
        </div>
        <div class="nav-actions">
            <a href="${pageContext.request.contextPath}/patient/rendezvous" class="btn-primary">
                ➕ Nouveau rendez-vous
            </a>
            <a href="${pageContext.request.contextPath}/patient/dashboard" class="btn-secondary">
                ← Tableau de bord
            </a>
        </div>
    </div>

    <div class="container">
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

        <c:choose>
            <c:when test="${empty appointments}">
                <div class="empty-state">
                    <div class="icon">📅</div>
                    <h2>Aucun rendez-vous</h2>
                    <p>Vous n'avez pas encore de rendez-vous planifié.</p>
                    <a href="${pageContext.request.contextPath}/patient/rendezvous" class="btn-primary">
                        Prendre un rendez-vous
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="appointments-grid">
                    <c:forEach var="appointment" items="${appointments}">
                        <div class="appointment-card ${appointment.statut == 'CANCELED' ? 'canceled' : ''} ${appointment.statut == 'COMPLETED' ? 'completed' : ''}">
                            <div class="appointment-header">
                                <div class="appointment-date">
                                    <span>📅</span>
                                    <span>${appointment.dateRdv}</span>
                                    <span style="color: #667eea;">⏰ ${appointment.heure}</span>
                                </div>
                                <c:choose>
                                    <c:when test="${appointment.statut == 'PLANNED'}">
                                        <span class="status-badge planned">Planifié</span>
                                    </c:when>
                                    <c:when test="${appointment.statut == 'COMPLETED'}">
                                        <span class="status-badge completed">Terminé</span>
                                    </c:when>
                                    <c:when test="${appointment.statut == 'CANCELED'}">
                                        <span class="status-badge canceled">Annulé</span>
                                    </c:when>
                                </c:choose>
                            </div>

                            <div class="appointment-details">
                                <div class="detail-item">
                                    <span class="icon">👨‍⚕️</span>
                                    <div>
                                        <div class="label">Médecin</div>
                                        <div class="value">Dr. ${appointment.doctor.nom} ${appointment.doctor.prenom}</div>
                                    </div>
                                </div>
                                <div class="detail-item">
                                    <span class="icon">🏥</span>
                                    <div>
                                        <div class="label">Type</div>
                                        <div class="value">
                                            <c:choose>
                                                <c:when test="${appointment.type == 'CONSULTATION'}">Consultation</c:when>
                                                <c:when test="${appointment.type == 'FOLLOW_UP'}">Suivi</c:when>
                                                <c:when test="${appointment.type == 'EMERGENCY'}">Urgence</c:when>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                                <c:if test="${not empty appointment.doctor.department}">
                                    <div class="detail-item">
                                        <span class="icon">🏢</span>
                                        <div>
                                            <div class="label">Service</div>
                                            <div class="value">${appointment.doctor.department.nom}</div>
                                        </div>
                                    </div>
                                </c:if>
                            </div>

                            <c:if test="${appointment.statut == 'PLANNED'}">
                                <div class="appointment-actions">
                                    <form method="post" style="display: inline;"
                                          onsubmit="return confirm('Êtes-vous sûr de vouloir annuler ce rendez-vous ?');">
                                        <input type="hidden" name="appointmentId" value="${appointment.id}"/>
                                        <input type="hidden" name="action" value="cancel"/>
                                        <button type="submit" class="btn-cancel">🗑️ Annuler le rendez-vous</button>
                                    </form>
                                </div>
                            </c:if>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
