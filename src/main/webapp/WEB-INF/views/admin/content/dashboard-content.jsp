<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- Dashboard Content Only (no layout) -->
<!-- Top Bar -->
<div class="top-bar">
    <h1>Dashboard Overview</h1>
    <div class="top-bar-actions">
        <div class="search-box">
            <i class="fas fa-search"></i>
            <input type="text" placeholder="Rechercher...">
        </div>
        <button class="notification-btn">
            <i class="fas fa-bell"></i>
            <span class="notification-badge"></span>
        </button>
        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i>
        </a>
    </div>
</div>

<!-- Stats Grid -->
<div class="stats-grid">
    <div class="stat-card blue">
        <div class="stat-header">
            <div class="stat-info">
                <h3>Total Patients</h3>
                <div class="number">2,847</div>
            </div>
            <div class="stat-icon">
                <i class="fas fa-users"></i>
            </div>
        </div>
        <div class="stat-footer">
            <span class="stat-change positive">
                <i class="fas fa-arrow-up"></i> 12.5%
            </span>
            <span>vs last month</span>
        </div>
    </div>

    <div class="stat-card purple">
        <div class="stat-header">
            <div class="stat-info">
                <h3>Total Docteurs</h3>
                <div class="number">142</div>
            </div>
            <div class="stat-icon">
                <i class="fas fa-user-md"></i>
            </div>
        </div>
        <div class="stat-footer">
            <span class="stat-change positive">
                <i class="fas fa-arrow-up"></i> 8.2%
            </span>
            <span>vs last month</span>
        </div>
    </div>

    <div class="stat-card green">
        <div class="stat-header">
            <div class="stat-info">
                <h3>Rendez-vous</h3>
                <div class="number">1,524</div>
            </div>
            <div class="stat-icon">
                <i class="fas fa-calendar-check"></i>
            </div>
        </div>
        <div class="stat-footer">
            <span class="stat-change positive">
                <i class="fas fa-arrow-up"></i> 15.8%
            </span>
            <span>vs last month</span>
        </div>
    </div>

    <div class="stat-card orange">
        <div class="stat-header">
            <div class="stat-info">
                <h3>Revenus</h3>
                <div class="number">$48.2K</div>
            </div>
            <div class="stat-icon">
                <i class="fas fa-dollar-sign"></i>
            </div>
        </div>
        <div class="stat-footer">
            <span class="stat-change positive">
                <i class="fas fa-arrow-up"></i> 23.4%
            </span>
            <span>vs last month</span>
        </div>
    </div>
</div>

<!-- Data Tables Grid -->
<div class="charts-grid">
    <!-- Upcoming Appointments Table -->
    <div class="chart-card">
        <div class="chart-header">
            <h3>Rendez-vous à Venir</h3>
            <div class="chart-filter">
                <button class="filter-btn active">Aujourd'hui</button>
                <button class="filter-btn">Cette Semaine</button>
            </div>
        </div>
        <table class="appointments-table">
            <thead>
                <tr>
                    <th>Heure</th>
                    <th>Patient</th>
                    <th>Docteur</th>
                    <th>Spécialité</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="day-cell">09:00</td>
                    <td>Jean Dupont</td>
                    <td>Dr. Martin</td>
                    <td>Cardiologie</td>
                    <td><span class="count-badge">Confirmé</span></td>
                </tr>
                <tr>
                    <td class="day-cell">10:30</td>
                    <td>Marie Curie</td>
                    <td>Dr. Dupont</td>
                    <td>Neurologie</td>
                    <td><span class="count-badge">En Attente</span></td>
                </tr>
                <tr>
                    <td class="day-cell">11:00</td>
                    <td>Pierre Durand</td>
                    <td>Dr. Lefevre</td>
                    <td>Pédiatrie</td>
                    <td><span class="count-badge">Confirmé</span></td>
                </tr>
                <tr>
                    <td class="day-cell">14:00</td>
                    <td>Sophie Marceau</td>
                    <td>Dr. Moreau</td>
                    <td>Dermatologie</td>
                    <td><span class="count-badge">Annulé</span></td>
                </tr>
                <tr>
                    <td class="day-cell">15:30</td>
                    <td>Lucas Martin</td>
                    <td>Dr. Petit</td>
                    <td>Orthopédie</td>
                    <td><span class="count-badge">Confirmé</span></td>
                </tr>
            </tbody>
        </table>
    </div>

    <!-- Specialty Overview Table -->
    <div class="chart-card">
        <div class="chart-header">
            <h3>Aperçu par Spécialité</h3>
        </div>
        <div class="specialty-grid">
            <div class="specialty-item">
                <div class="specialty-header">
                    <div class="specialty-name">Cardiologie</div>
                    <div class="specialty-icon">
                        <i class="fas fa-heartbeat"></i>
                    </div>
                </div>
                <div class="specialty-stats">
                    <div>
                        <div class="specialty-count">350</div>
                        <div class="specialty-label">Patients</div>
                    </div>
                    <div>
                        <div class="specialty-percentage trend-up">+15%</div>
                    </div>
                </div>
            </div>

            <div class="specialty-item">
                <div class="specialty-header">
                    <div class="specialty-name">Neurologie</div>
                    <div class="specialty-icon">
                        <i class="fas fa-brain"></i>
                    </div>
                </div>
                <div class="specialty-stats">
                    <div>
                        <div class="specialty-count">220</div>
                        <div class="specialty-label">Patients</div>
                    </div>
                    <div>
                        <div class="specialty-percentage trend-up">+10%</div>
                    </div>
                </div>
            </div>

            <div class="specialty-item">
                <div class="specialty-header">
                    <div class="specialty-name">Pédiatrie</div>
                    <div class="specialty-icon">
                        <i class="fas fa-baby"></i>
                    </div>
                </div>
                <div class="specialty-stats">
                    <div>
                        <div class="specialty-count">180</div>
                        <div class="specialty-label">Patients</div>
                    </div>
                    <div>
                        <div class="specialty-percentage trend-down">-5%</div>
                    </div>
                </div>
            </div>

            <div class="specialty-item">
                <div class="specialty-header">
                    <div class="specialty-name">Dermatologie</div>
                    <div class="specialty-icon">
                        <i class="fas fa-skin"></i>
                    </div>
                </div>
                <div class="specialty-stats">
                    <div>
                        <div class="specialty-count">150</div>
                        <div class="specialty-label">Patients</div>
                    </div>
                    <div>
                        <div class="specialty-percentage trend-up">+8%</div>
                    </div>
                </div>
            </div>

            <div class="specialty-item">
                <div class="specialty-header">
                    <div class="specialty-name">Orthopédie</div>
                    <div class="specialty-icon">
                        <i class="fas fa-walking"></i>
                    </div>
                </div>
                <div class="specialty-stats">
                    <div>
                        <div class="specialty-count">90</div>
                        <div class="specialty-label">Patients</div>
                    </div>
                    <div>
                        <div class="specialty-percentage trend-up">+12%</div>
                    </div>
                </div>
            </div>
        </div>
        <button class="view-all-btn">
            <i class="fas fa-eye"></i> Voir Tous les Détails
        </button>
    </div>
</div>

<!-- Bottom Grid -->
<div class="bottom-grid">
    <!-- Recent Activity -->
    <div class="activity-card">
        <h3>Activités Récentes</h3>
        <div class="activity-item">
            <div class="activity-icon blue">
                <i class="fas fa-user-plus"></i>
            </div>
            <div class="activity-content">
                <p><strong>Nouveau patient enregistré</strong></p>
                <span>Dr. Sarah Ahmed a enregistré un nouveau patient</span>
                <br><span>Il y a 5 minutes</span>
            </div>
        </div>

        <div class="activity-item">
            <div class="activity-icon green">
                <i class="fas fa-calendar-check"></i>
            </div>
            <div class="activity-content">
                <p><strong>Rendez-vous confirmé</strong></p>
                <span>Patient #2847 - Consultation Cardiologie</span>
                <br><span>Il y a 12 minutes</span>
            </div>
        </div>

        <div class="activity-item">
            <div class="activity-icon purple">
                <i class="fas fa-user-md"></i>
            </div>
            <div class="activity-content">
                <p><strong>Nouveau docteur ajouté</strong></p>
                <span>Dr. Mohammed El Idrissi - Neurologie</span>
                <br><span>Il y a 1 heure</span>
            </div>
        </div>

        <div class="activity-item">
            <div class="activity-icon orange">
                <i class="fas fa-file-medical"></i>
            </div>
            <div class="activity-content">
                <p><strong>Rapport médical généré</strong></p>
                <span>Rapport mensuel - Octobre 2025</span>
                <br><span>Il y a 2 heures</span>
            </div>
        </div>

        <div class="activity-item">
            <div class="activity-icon blue">
                <i class="fas fa-building"></i>
            </div>
            <div class="activity-content">
                <p><strong>Département mis à jour</strong></p>
                <span>Service d'Urgences - Capacité étendue</span>
                <br><span>Il y a 3 heures</span>
            </div>
        </div>
    </div>

    <!-- Quick Actions -->
    <div class="quick-actions-card">
        <h3>Actions Rapides</h3>
        <a href="javascript:void(0)" onclick="loadContent('departments')" class="quick-action-btn">
            <i class="fas fa-building"></i>
            <div class="quick-action-text">
                <h4>Départements</h4>
                <p>Gérer les départements</p>
            </div>
        </a>

        <a href="javascript:void(0)" onclick="loadContent('specialties')" class="quick-action-btn">
            <i class="fas fa-stethoscope"></i>
            <div class="quick-action-text">
                <h4>Spécialités</h4>
                <p>Gérer les spécialités</p>
            </div>
        </a>

        <a href="javascript:void(0)" onclick="loadContent('doctors')" class="quick-action-btn">
            <i class="fas fa-user-md"></i>
            <div class="quick-action-text">
                <h4>Docteurs</h4>
                <p>Gérer les docteurs</p>
            </div>
        </a>

        <a href="javascript:void(0)" onclick="loadContent('patients')" class="quick-action-btn">
            <i class="fas fa-user-injured"></i>
            <div class="quick-action-text">
                <h4>Patients</h4>
                <p>Gérer les patients</p>
            </div>
        </a>
    </div>
</div>

