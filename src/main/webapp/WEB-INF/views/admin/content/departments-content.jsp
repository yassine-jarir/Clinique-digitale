<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- Departments Content Only (no layout) -->
<div class="page-header">
    <h1><i class="fas fa-building"></i> Gestion des Départements</h1>
    <button class="btn btn-primary" onclick="showAddDepartmentForm()">
        <i class="fas fa-plus"></i> Ajouter un Département
    </button>
</div>
<!-- Success/Error Messages -->
<c:if test="${not empty sessionScope.success}">
    <div class="alert alert-success">
        <i class="fas fa-check-circle"></i>
        ${sessionScope.success}
    </div>
    <c:remove var="success" scope="session"/>
</c:if>

<c:if test="${not empty error}">
    <div class="alert alert-error">
        <i class="fas fa-exclamation-circle"></i>
        ${error}
    </div>
</c:if>

<!-- Departments Table -->
<div class="chart-card">
    <div class="chart-header">
        <h3>Liste des Départements</h3>
        <span style="color: #a0aec0; font-size: 14px;">Total: ${departments.size()} département(s)</span>
    </div>

    <c:choose>
        <c:when test="${empty departments}">
            <div style="text-align: center; padding: 60px 20px; color: #a0aec0;">
                <i class="fas fa-building" style="font-size: 64px; margin-bottom: 20px;"></i>
                <h3 style="font-size: 20px; margin-bottom: 10px;">Aucun département trouvé</h3>
                <p>Commencez par créer un département</p>
            </div>
        </c:when>
        <c:otherwise>
            <table class="appointments-table">
                <thead>
                    <tr>
                        <th>Nom</th>
                        <th>Description</th>
                        <th>Nombre de Spécialités</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${departments}" var="dept">
                        <tr>
                            <td><strong>${dept.nom}</strong></td>
                            <td>${dept.description != null ? dept.description : 'N/A'}</td>
                            <td>
                                <span class="count-badge">${dept.specialtyCount} spécialité(s)</span>
                            </td>
                            <td>
                                <div style="display: flex; gap: 8px;">
                                    <button onclick="editDepartment('${dept.id}', '${dept.nom}', '${dept.description}')"
                                            class="btn btn-primary" style="padding: 8px 16px; font-size: 13px;"
                                            title="Modifier">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <form method="post" action="${pageContext.request.contextPath}/admin/departments"
                                          style="display: inline;" onsubmit="return confirm('Êtes-vous sûr de vouloir supprimer ce département?');">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="${dept.id}">
                                        <button type="submit" class="btn btn-danger" style="padding: 8px 16px; font-size: 13px;"
                                                title="Supprimer">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>

<!-- Add/Edit Department Modal -->
<div id="departmentModal" style="display: none; position: fixed; top: 0; left: 0; right: 0; bottom: 0; background: rgba(0,0,0,0.5); z-index: 10000; align-items: center; justify-content: center;">
    <div style="background: white; padding: 30px; border-radius: 15px; max-width: 500px; width: 90%;">
        <h2 style="margin-bottom: 20px; color: #2d3748;" id="modalTitle">Ajouter un Département</h2>
        <form id="departmentForm" method="post" action="${pageContext.request.contextPath}/admin/departments">
            <input type="hidden" name="id" id="deptId">
            <div style="margin-bottom: 20px;">
                <label style="display: block; margin-bottom: 8px; color: #4a5568; font-weight: 600;">Nom du Département</label>
                <input type="text" name="nom" id="deptNom" required
                       style="width: 100%; padding: 12px; border: 2px solid #e2e8f0; border-radius: 8px; font-size: 14px;">
            </div>
            <div style="margin-bottom: 20px;">
                <label style="display: block; margin-bottom: 8px; color: #4a5568; font-weight: 600;">Description</label>
                <textarea name="description" id="deptDescription" rows="4"
                          style="width: 100%; padding: 12px; border: 2px solid #e2e8f0; border-radius: 8px; font-size: 14px;"></textarea>
            </div>
            <div style="display: flex; gap: 10px; justify-content: flex-end;">
                <button type="button" onclick="closeModal()" class="btn" style="background: #e2e8f0; color: #4a5568;">
                    Annuler
                </button>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i> Enregistrer
                </button>
            </div>
        </form>
    </div>
</div>

<script>
    function showAddDepartmentForm() {
        document.getElementById('modalTitle').textContent = 'Ajouter un Département';
        document.getElementById('departmentForm').reset();
        document.getElementById('deptId').value = '';
        document.getElementById('departmentModal').style.display = 'flex';
    }

    function editDepartment(id, nom, description) {
        document.getElementById('modalTitle').textContent = 'Modifier le Département';
        document.getElementById('deptId').value = id;
        document.getElementById('deptNom').value = nom;
        document.getElementById('deptDescription').value = description || '';
        document.getElementById('departmentModal').style.display = 'flex';
    }

    function closeModal() {
        document.getElementById('departmentModal').style.display = 'none';
    }

    // Close modal when clicking outside
    document.getElementById('departmentModal')?.addEventListener('click', function(e) {
        if (e.target === this) {
            closeModal();
        }
    });
</script>
