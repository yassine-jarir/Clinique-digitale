<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Départements - Admin</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
            color: #667eea;
            font-size: 28px;
        }

        .back-btn {
            background: #667eea;
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            text-decoration: none;
            transition: background 0.3s;
        }

        .back-btn:hover {
            background: #5568d3;
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
        .form-group textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 15px;
            transition: border-color 0.3s;
            font-family: inherit;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
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
            background: #667eea;
            color: white;
        }

        .btn-primary:hover {
            background: #5568d3;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
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
        }

        .search-box {
            flex: 1;
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
            border-color: #667eea;
        }

        .search-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #718096;
            font-size: 18px;
        }

        .stats-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🏢 Gestion des Départements</h1>
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
                <h3>Total Départements</h3>
                <div class="number">${not empty departments ? departments.size() : 0}</div>
            </div>
        </div>

        <!-- Form Section -->
        <div class="content-card">
            <div class="form-header">
                <h2>
                    <c:choose>
                        <c:when test="${action == 'edit'}">✏️ Modifier le Département</c:when>
                        <c:otherwise>➕ Nouveau Département</c:otherwise>
                    </c:choose>
                </h2>
            </div>

            <form method="post" action="${pageContext.request.contextPath}/admin/departments" id="departmentForm">
                <c:if test="${action == 'edit'}">
                    <input type="hidden" name="id" value="${department.id}">
                </c:if>

                <div class="form-group">
                    <label for="nom" class="required-field">Nom du Département</label>
                    <input type="text" id="nom" name="nom" value="${department.nom}" required
                           maxlength="100" placeholder="Ex: Cardiologie, Pédiatrie...">
                    <div class="char-counter">
                        <span id="nomCounter">0</span>/100 caractères
                    </div>
                </div>

                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea id="description" name="description" maxlength="500"
                              placeholder="Description détaillée du département...">${department.description}</textarea>
                    <div class="char-counter">
                        <span id="descCounter">0</span>/500 caractères
                    </div>
                </div>

                <div class="btn-group">
                    <button type="submit" class="btn btn-primary">
                        <c:choose>
                            <c:when test="${action == 'edit'}">💾 Mettre à jour</c:when>
                            <c:otherwise>✨ Créer</c:otherwise>
                        </c:choose>
                    </button>
                    <c:if test="${action == 'edit'}">
                        <a href="${pageContext.request.contextPath}/admin/departments" class="btn btn-secondary">❌ Annuler</a>
                    </c:if>
                </div>
            </form>
        </div>

        <!-- List Section -->
        <div class="content-card">
            <div class="form-header">
                <h2>📋 Liste des Départements</h2>
            </div>

            <c:if test="${not empty departments}">
                <div class="search-filter-section">
                    <div class="search-box">
                        <span class="search-icon">🔍</span>
                        <input type="text" id="searchInput" placeholder="Rechercher un département..."
                               onkeyup="filterTable()">
                    </div>
                </div>
            </c:if>

            <c:choose>
                <c:when test="${empty departments}">
                    <div class="empty-state">
                        <div class="icon">🏢</div>
                        <h3>Aucun département trouvé</h3>
                        <p>Créez votre premier département en utilisant le formulaire ci-dessus.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <table id="departmentsTable">
                        <thead>
                            <tr>
                                <th onclick="sortTable(0)">Nom ⇅</th>
                                <th onclick="sortTable(1)">Description ⇅</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="dept" items="${departments}">
                                <tr>
                                    <td><strong>${dept.nom}</strong></td>
                                    <td>${dept.description}</td>
                                    <td>
                                        <div class="action-buttons">
                                            <a href="${pageContext.request.contextPath}/admin/departments?action=edit&id=${dept.id}"
                                               class="btn btn-sm btn-edit">✏️ Modifier</a>
                                            <button onclick="confirmDelete('${dept.id}', '${dept.nom}')"
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

    <div id="deleteModal" class="modal">
        <div class="modal-content">
            <h2 style="margin-bottom: 15px; color: #2d3748;">⚠️ Confirmer la suppression</h2>
            <p style="margin-bottom: 20px; color: #718096;">
                Êtes-vous sûr de vouloir supprimer le département <strong id="deptName"></strong> ?
                Cette action est irréversible.
            </p>
            <form method="post" action="${pageContext.request.contextPath}/admin/departments" id="deleteForm">
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
        document.getElementById('nom').addEventListener('input', function() {
            document.getElementById('nomCounter').textContent = this.value.length;
        });

        document.getElementById('description').addEventListener('input', function() {
            document.getElementById('descCounter').textContent = this.value.length;
        });

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

        function filterTable() {
            const input = document.getElementById('searchInput');
            const filter = input.value.toLowerCase();
            const table = document.getElementById('departmentsTable');
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

                tr[i].style.display = found ? '' : 'none';
            }
        }

        function sortTable(columnIndex) {
            const table = document.getElementById('departmentsTable');
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
            document.getElementById('deptName').textContent = name;
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
