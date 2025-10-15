<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Spécialités - Admin</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
        }

        .header {
            background: white;
            padding: 20px 30px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h1 {
            color: #f5576c;
            font-size: 28px;
        }

        .back-btn {
            background: #f5576c;
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            text-decoration: none;
            transition: background 0.3s;
        }

        .back-btn:hover {
            background: #e4465a;
        }

        .alert {
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            animation: slideIn 0.3s ease;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .close-alert {
            background: none;
            border: none;
            font-size: 20px;
            cursor: pointer;
            color: inherit;
            padding: 0 5px;
        }

        @keyframes slideIn {
            from {
                transform: translateY(-20px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .content-card {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }

        .form-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #e2e8f0;
        }

        .form-header h2 {
            color: #2d3748;
            font-size: 24px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            color: #4a5568;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .form-group input,
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 15px;
            transition: border-color 0.3s;
            font-family: inherit;
        }

        .form-group input:focus,
        .form-group textarea:focus,
        .form-group select:focus {
            outline: none;
            border-color: #f5576c;
            box-shadow: 0 0 0 3px rgba(245, 87, 108, 0.1);
        }

        .form-group textarea {
            resize: vertical;
            min-height: 100px;
        }

        .btn-group {
            display: flex;
            gap: 10px;
        }

        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
        }

        .btn-primary {
            background: #f5576c;
            color: white;
        }

        .btn-primary:hover {
            background: #e4465a;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(245, 87, 108, 0.4);
        }

        .btn-secondary {
            background: #718096;
            color: white;
        }

        .btn-secondary:hover {
            background: #4a5568;
        }

        .search-filter-section {
            margin-bottom: 20px;
            display: flex;
            gap: 15px;
            align-items: center;
            flex-wrap: wrap;
        }

        .search-box {
            flex: 1;
            min-width: 250px;
            position: relative;
        }

        .search-box input {
            width: 100%;
            padding: 12px 15px 12px 45px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 15px;
        }

        .search-box input:focus {
            outline: none;
            border-color: #f5576c;
        }

        .search-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #718096;
            font-size: 18px;
        }

        .filter-select {
            padding: 12px 15px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 15px;
            min-width: 200px;
        }

        .stats-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .stat-card h3 {
            font-size: 14px;
            opacity: 0.9;
            margin-bottom: 10px;
        }

        .stat-card .number {
            font-size: 32px;
            font-weight: bold;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        thead {
            background: #f7fafc;
        }

        th {
            padding: 15px;
            text-align: left;
            color: #4a5568;
            font-weight: 600;
            border-bottom: 2px solid #e2e8f0;
            cursor: pointer;
            user-select: none;
        }

        th:hover {
            background: #edf2f7;
        }

        td {
            padding: 15px;
            border-bottom: 1px solid #e2e8f0;
        }

        tbody tr {
            transition: background 0.2s;
        }

        tbody tr:hover {
            background: #f7fafc;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
        }

        .btn-sm {
            padding: 6px 12px;
            font-size: 13px;
        }

        .btn-edit {
            background: #4299e1;
            color: white;
        }

        .btn-edit:hover {
            background: #3182ce;
        }

        .btn-delete {
            background: #f56565;
            color: white;
        }

        .btn-delete:hover {
            background: #e53e3e;
        }

        .empty-state {
            text-align: center;
            padding: 60px 40px;
            color: #718096;
        }

        .empty-state .icon {
            font-size: 64px;
            margin-bottom: 15px;
            opacity: 0.3;
        }

        .empty-state h3 {
            font-size: 20px;
            margin-bottom: 10px;
        }

        .badge {
            display: inline-block;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 1000;
            animation: fadeIn 0.3s ease;
        }

        .modal.active {
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .modal-content {
            background: white;
            padding: 30px;
            border-radius: 15px;
            max-width: 500px;
            width: 90%;
            animation: slideUp 0.3s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideUp {
            from {
                transform: translateY(50px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .char-counter {
            text-align: right;
            font-size: 12px;
            color: #718096;
            margin-top: 5px;
        }

        .required-field::after {
            content: " *";
            color: #f56565;
        }

        .alert-warning {
            background: #fff3cd;
            color: #856404;
            border: 1px solid #ffeaa7;
            padding: 12px 20px;
            border-radius: 8px;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>⚕️ Gestion des Spécialités</h1>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="back-btn">← Retour au Dashboard</a>
        </div>

        <c:if test="${not empty sessionScope.success}">
            <div class="alert alert-success">
                <span>${sessionScope.success}</span>
                <button class="close-alert" onclick="this.parentElement.style.display='none'">×</button>
                <c:remove var="success" scope="session"/>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-error">
                <span>${error}</span>
                <button class="close-alert" onclick="this.parentElement.style.display='none'">×</button>
            </div>
        </c:if>

        <!-- Stats Cards -->
        <div class="stats-cards">
            <div class="stat-card">
                <h3>Total Spécialités</h3>
                <div class="number">${not empty specialties ? specialties.size() : 0}</div>
            </div>
            <div class="stat-card">
                <h3>Départements Disponibles</h3>
                <div class="number">${not empty departments ? departments.size() : 0}</div>
            </div>
        </div>

        <c:if test="${empty departments}">
            <div class="alert-warning">
                ⚠️ Aucun département trouvé. <a href="${pageContext.request.contextPath}/admin/departments" style="color: #856404; text-decoration: underline;">Créez d'abord un département</a> avant de créer des spécialités.
            </div>
        </c:if>

        <!-- Form Section -->
        <div class="content-card">
            <div class="form-header">
                <h2>
                    <c:choose>
                        <c:when test="${action == 'edit'}">✏️ Modifier la Spécialité</c:when>
                        <c:otherwise>➕ Nouvelle Spécialité</c:otherwise>
                    </c:choose>
                </h2>
            </div>

            <form method="post" action="${pageContext.request.contextPath}/admin/specialties" id="specialtyForm">
                <c:if test="${action == 'edit'}">
                    <input type="hidden" name="id" value="${specialty.id}">
                </c:if>

                <div class="form-group">
                    <label for="nom" class="required-field">Nom de la Spécialité</label>
                    <input type="text" id="nom" name="nom" value="${specialty.nom}" required
                           maxlength="100" placeholder="Ex: Cardiologie, Neurologie...">
                    <div class="char-counter">
                        <span id="nomCounter">0</span>/100 caractères
                    </div>
                </div>

                <div class="form-group">
                    <label for="departmentId" class="required-field">Département</label>
                    <select id="departmentId" name="departmentId" required>
                        <option value="">-- Sélectionner un département --</option>
                        <c:forEach var="dept" items="${departments}">
                            <option value="${dept.id}"
                                ${specialty.departmentId == dept.id ? 'selected' : ''}>
                                ${dept.nom}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea id="description" name="description" maxlength="500"
                              placeholder="Description détaillée de la spécialité...">${specialty.description}</textarea>
                    <div class="char-counter">
                        <span id="descCounter">0</span>/500 caractères
                    </div>
                </div>

                <div class="btn-group">
                    <button type="submit" class="btn btn-primary" ${empty departments ? 'disabled' : ''}>
                        <c:choose>
                            <c:when test="${action == 'edit'}">💾 Mettre à jour</c:when>
                            <c:otherwise>✨ Créer</c:otherwise>
                        </c:choose>
                    </button>
                    <c:if test="${action == 'edit'}">
                        <a href="${pageContext.request.contextPath}/admin/specialties" class="btn btn-secondary">❌ Annuler</a>
                    </c:if>
                </div>
            </form>
        </div>

        <!-- List Section -->
        <div class="content-card">
            <div class="form-header">
                <h2>📋 Liste des Spécialités</h2>
            </div>

            <c:if test="${not empty specialties}">
                <div class="search-filter-section">
                    <div class="search-box">
                        <span class="search-icon">🔍</span>
                        <input type="text" id="searchInput" placeholder="Rechercher une spécialité..."
                               onkeyup="filterTable()">
                    </div>
                    <select id="departmentFilter" class="filter-select" onchange="filterByDepartment()">
                        <option value="">Tous les départements</option>
                        <c:forEach var="dept" items="${departments}">
                            <option value="${dept.nom}">${dept.nom}</option>
                        </c:forEach>
                    </select>
                </div>
            </c:if>

            <c:choose>
                <c:when test="${empty specialties}">
                    <div class="empty-state">
                        <div class="icon">⚕️</div>
                        <h3>Aucune spécialité trouvée</h3>
                        <p>Créez votre première spécialité en utilisant le formulaire ci-dessus.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <table id="specialtiesTable">
                        <thead>
                            <tr>
                                <th onclick="sortTable(0)">Nom ⇅</th>
                                <th onclick="sortTable(1)">Département ⇅</th>
                                <th onclick="sortTable(2)">Description ⇅</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="spec" items="${specialties}">
                                <tr data-department="${spec.departmentNom}">
                                    <td><strong>${spec.nom}</strong></td>
                                    <td>
                                        <c:if test="${not empty spec.departmentNom}">
                                            <span class="badge">${spec.departmentNom}</span>
                                        </c:if>
                                    </td>
                                    <td>${spec.description}</td>
                                    <td>
                                        <div class="action-buttons">
                                            <a href="${pageContext.request.contextPath}/admin/specialties?action=edit&id=${spec.id}"
                                               class="btn btn-sm btn-edit">✏️ Modifier</a>
                                            <button onclick="confirmDelete('${spec.id}', '${spec.nom}')"
                                                    class="btn btn-sm btn-delete">🗑️ Supprimer</button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div id="deleteModal" class="modal">
        <div class="modal-content">
            <h2 style="margin-bottom: 15px; color: #2d3748;">⚠️ Confirmer la suppression</h2>
            <p style="margin-bottom: 20px; color: #718096;">
                Êtes-vous sûr de vouloir supprimer la spécialité <strong id="specName"></strong> ?
                Cette action est irréversible.
            </p>
            <form method="post" action="${pageContext.request.contextPath}/admin/specialties" id="deleteForm">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="id" id="deleteId">
                <div class="btn-group">
                    <button type="submit" class="btn btn-delete">Confirmer</button>
                    <button type="button" class="btn btn-secondary" onclick="closeModal()">Annuler</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Character counters
        document.getElementById('nom').addEventListener('input', function() {
            document.getElementById('nomCounter').textContent = this.value.length;
        });

        document.getElementById('description').addEventListener('input', function() {
            document.getElementById('descCounter').textContent = this.value.length;
        });

        // Initialize counters on page load
        window.addEventListener('load', function() {
            const nomField = document.getElementById('nom');
            const descField = document.getElementById('description');
            if (nomField.value) {
                document.getElementById('nomCounter').textContent = nomField.value.length;
            }
            if (descField.value) {
                document.getElementById('descCounter').textContent = descField.value.length;
            }
        });

        // Search/Filter function
        function filterTable() {
            const input = document.getElementById('searchInput');
            const filter = input.value.toLowerCase();
            const table = document.getElementById('specialtiesTable');
            const tr = table.getElementsByTagName('tr');

            for (let i = 1; i < tr.length; i++) {
                const td = tr[i].getElementsByTagName('td');
                let found = false;

                for (let j = 0; j < td.length - 1; j++) {
                    if (td[j]) {
                        const txtValue = td[j].textContent || td[j].innerText;
                        if (txtValue.toLowerCase().indexOf(filter) > -1) {
                            found = true;
                            break;
                        }
                    }
                }

                // Check if row passes department filter too
                const deptFilter = document.getElementById('departmentFilter').value;
                const rowDept = tr[i].getAttribute('data-department');

                if (deptFilter && rowDept !== deptFilter) {
                    found = false;
                }

                tr[i].style.display = found ? '' : 'none';
            }
        }

        // Filter by department
        function filterByDepartment() {
            const select = document.getElementById('departmentFilter');
            const filterValue = select.value;
            const table = document.getElementById('specialtiesTable');
            const tr = table.getElementsByTagName('tr');

            for (let i = 1; i < tr.length; i++) {
                const rowDept = tr[i].getAttribute('data-department');

                if (!filterValue || rowDept === filterValue) {
                    // Also check search filter
                    const searchInput = document.getElementById('searchInput');
                    if (searchInput && searchInput.value) {
                        filterTable();
                    } else {
                        tr[i].style.display = '';
                    }
                } else {
                    tr[i].style.display = 'none';
                }
            }
        }

        // Sort table function
        function sortTable(columnIndex) {
            const table = document.getElementById('specialtiesTable');
            let rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
            switching = true;
            dir = "asc";

            while (switching) {
                switching = false;
                rows = table.rows;

                for (i = 1; i < (rows.length - 1); i++) {
                    shouldSwitch = false;
                    x = rows[i].getElementsByTagName("TD")[columnIndex];
                    y = rows[i + 1].getElementsByTagName("TD")[columnIndex];

                    if (dir == "asc") {
                        if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                            shouldSwitch = true;
                            break;
                        }
                    } else if (dir == "desc") {
                        if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                            shouldSwitch = true;
                            break;
                        }
                    }
                }

                if (shouldSwitch) {
                    rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                    switching = true;
                    switchcount++;
                } else {
                    if (switchcount == 0 && dir == "asc") {
                        dir = "desc";
                        switching = true;
                    }
                }
            }
        }

        // Delete confirmation modal
        function confirmDelete(id, name) {
            document.getElementById('deleteId').value = id;
            document.getElementById('specName').textContent = name;
            document.getElementById('deleteModal').classList.add('active');
        }

        function closeModal() {
            document.getElementById('deleteModal').classList.remove('active');
        }

        // Close modal on background click
        document.getElementById('deleteModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closeModal();
            }
        });

        // Auto-hide alerts after 5 seconds
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                alert.style.transition = 'opacity 0.5s';
                alert.style.opacity = '0';
                setTimeout(() => alert.style.display = 'none', 500);
            });
        }, 5000);
    </script>
</body>
</html>

