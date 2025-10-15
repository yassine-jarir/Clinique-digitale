<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Clinique Digitale</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <!-- Include Layout Styles -->
    <%@ include file="layout-styles.jsp" %>

    <style>
        /* Dashboard Specific Styles */
        .top-bar {
            background: white;
            padding: 20px 30px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .top-bar h1 {
            color: #2d3748;
            font-size: 28px;
            font-weight: 700;
        }

        .top-bar-actions {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .search-box {
            position: relative;
        }

        .search-box input {
            padding: 10px 15px 10px 40px;
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            width: 300px;
            font-size: 14px;
            transition: all 0.3s;
        }

        .search-box input:focus {
            outline: none;
            border-color: #4fc3f7;
        }

        .search-box i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #a0aec0;
        }

        .notification-btn, .logout-btn {
            width: 45px;
            height: 45px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
        }

        .notification-btn {
            background: #f7fafc;
            color: #4a5568;
            position: relative;
            border: none;
        }

        .notification-btn:hover {
            background: #edf2f7;
        }

        .notification-badge {
            position: absolute;
            top: 8px;
            right: 8px;
            width: 8px;
            height: 8px;
            background: #f56565;
            border-radius: 50%;
        }

        .logout-btn {
            background: linear-gradient(135deg, #f56565 0%, #e53e3e 100%);
            color: white;
        }

        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(245, 101, 101, 0.3);
        }

        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            position: relative;
            overflow: hidden;
            transition: all 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
        }

        .stat-card.blue::before {
            background: linear-gradient(90deg, #4facfe 0%, #00f2fe 100%);
        }

        .stat-card.purple::before {
            background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
        }

        .stat-card.green::before {
            background: linear-gradient(90deg, #43e97b 0%, #38f9d7 100%);
        }

        .stat-card.orange::before {
            background: linear-gradient(90deg, #fa709a 0%, #fee140 100%);
        }

        .stat-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 15px;
        }

        .stat-icon {
            width: 55px;
            height: 55px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
        }

        .stat-card.blue .stat-icon {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            color: white;
        }

        .stat-card.purple .stat-icon {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .stat-card.green .stat-icon {
            background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
            color: white;
        }

        .stat-card.orange .stat-icon {
            background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
            color: white;
        }

        .stat-info h3 {
            color: #a0aec0;
            font-size: 14px;
            font-weight: 500;
            margin-bottom: 8px;
        }

        .stat-info .number {
            color: #2d3748;
            font-size: 32px;
            font-weight: 700;
        }

        .stat-footer {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #f7fafc;
        }

        .stat-change {
            font-size: 13px;
            font-weight: 600;
            padding: 4px 8px;
            border-radius: 6px;
        }

        .stat-change.positive {
            background: #c6f6d5;
            color: #22543d;
        }

        .stat-change.negative {
            background: #fed7d7;
            color: #742a2a;
        }

        .stat-footer span {
            font-size: 13px;
            color: #a0aec0;
        }

        /* Other dashboard specific styles... */
        .charts-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }

        .chart-card {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .chart-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .chart-header h3 {
            color: #2d3748;
            font-size: 18px;
            font-weight: 600;
        }

        .chart-filter {
            display: flex;
            gap: 10px;
        }

        .filter-btn {
            padding: 6px 12px;
            border: 1px solid #e2e8f0;
            background: white;
            border-radius: 8px;
            font-size: 13px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .filter-btn:hover, .filter-btn.active {
            background: #667eea;
            color: white;
            border-color: #667eea;
        }

        /* Appointments Table Styles */
        .appointments-table {
            width: 100%;
            border-collapse: collapse;
        }

        .appointments-table thead {
            background: #f7fafc;
        }

        .appointments-table th {
            padding: 12px;
            text-align: left;
            font-size: 13px;
            font-weight: 600;
            color: #4a5568;
            border-bottom: 2px solid #e2e8f0;
        }

        .appointments-table td {
            padding: 12px;
            font-size: 14px;
            color: #2d3748;
            border-bottom: 1px solid #f7fafc;
        }

        .appointments-table tbody tr:hover {
            background: #f7fafc;
        }

        .day-cell {
            font-weight: 600;
            color: #667eea;
        }

        .count-badge {
            padding: 4px 12px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 600;
            background: #c6f6d5;
            color: #22543d;
        }

        /* Specialty Grid Styles */
        .specialty-grid {
            display: grid;
            gap: 15px;
            margin-bottom: 20px;
        }

        .specialty-item {
            padding: 15px;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            transition: all 0.3s;
        }

        .specialty-item:hover {
            border-color: #667eea;
            background: #f7fafc;
        }

        .specialty-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }

        .specialty-name {
            font-weight: 600;
            color: #2d3748;
            font-size: 15px;
        }

        .specialty-icon {
            width: 35px;
            height: 35px;
            border-radius: 8px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .specialty-stats {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .specialty-count {
            font-size: 24px;
            font-weight: 700;
            color: #2d3748;
        }

        .specialty-label {
            font-size: 12px;
            color: #a0aec0;
        }

        .specialty-percentage {
            font-size: 13px;
            font-weight: 600;
            padding: 4px 8px;
            border-radius: 6px;
        }

        .specialty-percentage.trend-up {
            background: #c6f6d5;
            color: #22543d;
        }

        .specialty-percentage.trend-down {
            background: #fed7d7;
            color: #742a2a;
        }

        .view-all-btn {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .view-all-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
        }

        .bottom-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 25px;
        }

        .activity-card, .quick-actions-card {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .activity-card h3, .quick-actions-card h3 {
            color: #2d3748;
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 20px;
        }

        /* Activity Items */
        .activity-item {
            display: flex;
            gap: 15px;
            padding: 15px;
            border-bottom: 1px solid #f7fafc;
            transition: all 0.3s;
        }

        .activity-item:last-child {
            border-bottom: none;
        }

        .activity-item:hover {
            background: #f7fafc;
            border-radius: 10px;
        }

        .activity-icon {
            width: 45px;
            height: 45px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            color: white;
            font-size: 18px;
        }

        .activity-icon.blue {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        }

        .activity-icon.green {
            background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
        }

        .activity-icon.purple {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .activity-icon.orange {
            background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
        }

        .activity-content {
            flex: 1;
        }

        .activity-content p {
            margin-bottom: 5px;
            color: #2d3748;
        }

        .activity-content span {
            font-size: 13px;
            color: #a0aec0;
        }

        /* Quick Actions */
        .quick-action-btn {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 15px;
            background: #f7fafc;
            border-radius: 10px;
            margin-bottom: 12px;
            text-decoration: none;
            transition: all 0.3s;
        }

        .quick-action-btn:last-child {
            margin-bottom: 0;
        }

        .quick-action-btn:hover {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            transform: translateX(5px);
        }

        .quick-action-btn:hover .quick-action-text h4,
        .quick-action-btn:hover .quick-action-text p,
        .quick-action-btn:hover i {
            color: white;
        }

        .quick-action-btn i {
            font-size: 24px;
            color: #667eea;
            width: 40px;
            text-align: center;
        }

        .quick-action-text h4 {
            color: #2d3748;
            font-size: 15px;
            font-weight: 600;
            margin-bottom: 3px;
        }

        .quick-action-text p {
            color: #a0aec0;
            font-size: 12px;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
            }

            .sidebar.active {
                transform: translateX(0);
            }

            .main-content {
                margin-left: 0;
            }

            .bottom-grid {
                grid-template-columns: 1fr;
            }

            .charts-grid {
                grid-template-columns: 1fr;
            }

            .search-box input {
                width: 200px;
            }
        }

        /* Loading Animation */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .stat-card, .chart-card, .activity-card, .quick-actions-card {
            animation: fadeInUp 0.6s ease-out;
        }
    </style>
</head>
<body>
    <!-- Include Sidebar -->
    <jsp:include page="sidebar.jsp">
        <jsp:param name="page" value="dashboard" />
    </jsp:include>

    <!-- Main Content -->
    <div class="main-content" id="main-content">
        <!-- Content will be loaded dynamically here -->
        <jsp:include page="content/dashboard-content.jsp" />
    </div>

    <script>
        // Dynamic content loading function
        function loadContent(page) {
            const mainContent = document.getElementById('main-content');

            // Add loading state
            mainContent.style.opacity = '0.5';

            // Update active menu item
            setActiveMenuItem(page);

            // For specialties and departments, we need to fetch data and render content
            if (page === 'specialties') {
                loadSpecialtiesContent(mainContent);
                return;
            }

            if (page === 'departments') {
                loadDepartmentsContent(mainContent);
                return;
            }

            // Map page names to content-only JSP paths
            const pageMap = {
                'dashboard': '${pageContext.request.contextPath}/admin/dashboard?content=dashboard',
                'accounts': '${pageContext.request.contextPath}/admin/accounts?content=accounts',
                'doctors': '${pageContext.request.contextPath}/admin/dashboard?content=doctors',
                'patients': '${pageContext.request.contextPath}/admin/dashboard?content=patients',
                'appointments': '${pageContext.request.contextPath}/admin/dashboard?content=appointments',
                'reports': '${pageContext.request.contextPath}/admin/dashboard?content=reports',
                'settings': '${pageContext.request.contextPath}/admin/dashboard?content=settings'
            };

            const url = pageMap[page] || pageMap['dashboard'];

            // Fetch content
            fetch(url)
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.text();
                })
                .then(html => {
                    // Extract only the content part (not the full page)
                    const parser = new DOMParser();
                    const doc = parser.parseFromString(html, 'text/html');
                    const content = doc.querySelector('#dynamic-content');

                    if (content) {
                        mainContent.innerHTML = content.innerHTML;
                    } else {
                        mainContent.innerHTML = html;
                    }

                    // Execute scripts in the loaded content
                    const scripts = mainContent.querySelectorAll('script');
                    scripts.forEach(oldScript => {
                        const newScript = document.createElement('script');
                        Array.from(oldScript.attributes).forEach(attr => {
                            newScript.setAttribute(attr.name, attr.value);
                        });
                        newScript.textContent = oldScript.textContent;
                        oldScript.parentNode.replaceChild(newScript, oldScript);
                    });

                    mainContent.style.opacity = '1';

                    // Re-attach event listeners for dynamically loaded content
                    attachDynamicEventListeners();

                    // Update browser history
                    history.pushState({page: page}, '', '#${page}');
                })
                .catch(error => {
                    console.error('Error loading content:', error);
                    mainContent.innerHTML = `
                        <div class="page-header">
                            <h1><i class="fas fa-exclamation-circle"></i> Page en construction</h1>
                        </div>
                        <div class="alert alert-error">
                            <i class="fas fa-exclamation-circle"></i>
                            Cette fonctionnalité sera bientôt disponible.
                        </div>`;
                    mainContent.style.opacity = '1';
                });
        }

        // Load specialties content with AJAX
        function loadSpecialtiesContent(mainContent) {
            fetch('${pageContext.request.contextPath}/admin/specialties?content=specialties')
                .then(response => response.text())
                .then(html => {
                    mainContent.innerHTML = html;

                    // Execute scripts in the loaded content
                    const scripts = mainContent.querySelectorAll('script');
                    scripts.forEach(oldScript => {
                        const newScript = document.createElement('script');
                        Array.from(oldScript.attributes).forEach(attr => {
                            newScript.setAttribute(attr.name, attr.value);
                        });
                        newScript.textContent = oldScript.textContent;
                        oldScript.parentNode.replaceChild(newScript, oldScript);
                    });

                    mainContent.style.opacity = '1';
                    history.pushState({page: 'specialties'}, '', '#specialties');
                })
                .catch(error => {
                    console.error('Error loading specialties:', error);
                    mainContent.innerHTML = '<div class="alert alert-error">Error loading specialties</div>';
                    mainContent.style.opacity = '1';
                });
        }

        // Load departments content with AJAX
        function loadDepartmentsContent(mainContent) {
            fetch('${pageContext.request.contextPath}/admin/departments?content=departments')
                .then(response => response.text())
                .then(html => {
                    mainContent.innerHTML = html;

                    // Execute scripts in the loaded content
                    const scripts = mainContent.querySelectorAll('script');
                    scripts.forEach(oldScript => {
                        const newScript = document.createElement('script');
                        Array.from(oldScript.attributes).forEach(attr => {
                            newScript.setAttribute(attr.name, attr.value);
                        });
                        newScript.textContent = oldScript.textContent;
                        oldScript.parentNode.replaceChild(newScript, oldScript);
                    });

                    mainContent.style.opacity = '1';
                    history.pushState({page: 'departments'}, '', '#departments');
                })
                .catch(error => {
                    console.error('Error loading departments:', error);
                    mainContent.innerHTML = '<div class="alert alert-error">Error loading departments</div>';
                    mainContent.style.opacity = '1';
                });
        }

        // Attach event listeners to dynamically loaded content
        function attachDynamicEventListeners() {
            // Filter buttons
            document.querySelectorAll('.filter-btn').forEach(btn => {
                btn.addEventListener('click', function() {
                    this.parentElement.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
                    this.classList.add('active');
                });
            });

            // Any other dynamic content event listeners
        }

        // Handle browser back/forward buttons
        window.addEventListener('popstate', function(e) {
            if (e.state && e.state.page) {
                loadContent(e.state.page);
            }
        });

        // Load initial page based on URL hash
        window.addEventListener('DOMContentLoaded', function() {
            const hash = window.location.hash.substring(1);
            if (hash) {
                loadContent(hash);
            } else {
                setActiveMenuItem('dashboard');
                history.replaceState({page: 'dashboard'}, '', '#dashboard');
            }

            // Initial event listeners
            attachDynamicEventListeners();
        });

        // Mobile menu toggle
        if (window.innerWidth <= 768) {
            document.querySelector('.toggle-btn').addEventListener('click', function() {
                document.getElementById('sidebar').classList.toggle('active');
            });
        }
    </script>
</body>
</html>
