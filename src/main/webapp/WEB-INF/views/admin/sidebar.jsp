<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Admin Sidebar Component -->
<div class="sidebar" id="sidebar">
    <div class="sidebar-header">
        <a href="javascript:void(0)" onclick="loadContent('dashboard')" class="logo">
            <i class="fas fa-hospital"></i>
            <div class="logo-text">
                <h2>Clinique</h2>
                <span>Digital Platform</span>
            </div>
        </a>
        <button class="toggle-btn" onclick="toggleSidebar()">
            <i class="fas fa-bars"></i>
        </button>
    </div>

    <nav class="sidebar-menu">
        <a href="javascript:void(0)" onclick="loadContent('dashboard')"
           class="menu-item" data-page="dashboard">
            <i class="fas fa-chart-line"></i>
            <span class="menu-text">Dashboard</span>
        </a>
        <a href="javascript:void(0)" onclick="loadContent('departments')"
           class="menu-item" data-page="departments">
            <i class="fas fa-building"></i>
            <span class="menu-text">Départements</span>
        </a>
        <a href="javascript:void(0)" onclick="loadContent('specialties')"
           class="menu-item" data-page="specialties">
            <i class="fas fa-stethoscope"></i>
            <span class="menu-text">Spécialités</span>
        </a>
        <a href="javascript:void(0)" onclick="loadContent('accounts')"
           class="menu-item" data-page="accounts">
            <i class="fas fa-users-cog"></i>
            <span class="menu-text">Gestion Comptes</span>
        </a>
        <a href="javascript:void(0)" onclick="loadContent('doctors')"
           class="menu-item" data-page="doctors">
            <i class="fas fa-user-md"></i>
            <span class="menu-text">Docteurs</span>
        </a>
        <a href="javascript:void(0)" onclick="loadContent('patients')"
           class="menu-item" data-page="patients">
            <i class="fas fa-user-injured"></i>
            <span class="menu-text">Patients</span>
        </a>
        <a href="javascript:void(0)" onclick="loadContent('appointments')" class="menu-item" data-page="appointments">
            <i class="fas fa-calendar-check"></i>
            <span class="menu-text">Rendez-vous</span>
        </a>
        <a href="javascript:void(0)" onclick="loadContent('reports')" class="menu-item" data-page="reports">
            <i class="fas fa-chart-bar"></i>
            <span class="menu-text">Rapports</span>
        </a>
        <a href="javascript:void(0)" onclick="loadContent('settings')" class="menu-item" data-page="settings">
            <i class="fas fa-cog"></i>
            <span class="menu-text">Paramètres</span>
        </a>
    </nav>

    <div class="user-section">
        <div class="user-avatar">
            ${sessionScope.nom != null ? sessionScope.nom.substring(0,1).toUpperCase() : 'A'}
        </div>
        <div class="user-info">
            <span class="name">${sessionScope.nom != null ? sessionScope.nom : 'Admin'}</span>
            <span class="role">Administrateur</span>
        </div>
    </div>
</div>

<script>
    function toggleSidebar() {
        document.getElementById('sidebar').classList.toggle('collapsed');
    }

    // Set active menu item
    function setActiveMenuItem(page) {
        document.querySelectorAll('.menu-item').forEach(item => {
            item.classList.remove('active');
        });
        const activeItem = document.querySelector(`.menu-item[data-page="${page}"]`);
        if (activeItem) {
            activeItem.classList.add('active');
        }
    }
</script>
