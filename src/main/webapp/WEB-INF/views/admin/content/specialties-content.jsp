<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- Specialties Content Only (no layout) -->
<div class="page-header">
    <h1><i class="fas fa-stethoscope"></i> Gestion des Spécialités</h1>
    <button class="btn btn-primary" onclick="showAddSpecialtyForm()">
        <i class="fas fa-plus"></i> Ajouter une Spécialité
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

<!-- Specialties Table -->
<div class="chart-card">
    <div class="chart-header">
        <h3>Liste des Spécialités</h3>
        <span style="color: #a0aec0; font-size: 14px;">Total: ${specialties.size()} spécialité(s)</span>
    </div>

    <c:choose>
        <c:when test="${empty specialties}">
            <div style="text-align: center; padding: 60px 20px; color: #a0aec0;">
                <i class="fas fa-stethoscope" style="font-size: 64px; margin-bottom: 20px;"></i>
                <h3 style="font-size: 20px; margin-bottom: 10px;">Aucune spécialité trouvée</h3>
                <p>Commencez par créer une spécialité</p>
            </div>
        </c:when>
        <c:otherwise>
            <table class="appointments-table">
                <thead>
                    <tr>
                        <th>Nom</th>
                        <th>Description</th>
                        <th>Département</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${specialties}" var="spec">
                        <tr>
                            <td><strong>${spec.nom}</strong></td>
                            <td>${spec.description != null ? spec.description : 'N/A'}</td>
                            <td>
                                <span class="count-badge" style="background: rgba(102, 126, 234, 0.2); color: #667eea;">
                                    ${spec.departmentNom != null ? spec.departmentNom : 'Non assigné'}
                                </span>
                            </td>
                            <td>
                                <div style="display: flex; gap: 8px;">
                                    <button onclick="editSpecialty('${spec.id}', '${spec.nom}', '${spec.description}', '${spec.departmentId}')"
                                            class="btn btn-primary" style="padding: 8px 16px; font-size: 13px;"
                                            title="Modifier">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <form method="post" action="${pageContext.request.contextPath}/admin/specialties"
                                          style="display: inline;" onsubmit="return confirm('Êtes-vous sûr de vouloir supprimer cette spécialité?');">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="${spec.id}">
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

<!-- Add/Edit Specialty Modal -->
<div id="specialtyModal" style="display: none; position: fixed; top: 0; left: 0; right: 0; bottom: 0; background: rgba(0,0,0,0.5); z-index: 10000; align-items: center; justify-content: center;">
    <div style="background: white; padding: 30px; border-radius: 15px; max-width: 500px; width: 90%;">
        <h2 style="margin-bottom: 20px; color: #2d3748;" id="modalTitle">Ajouter une Spécialité</h2>
        <form id="specialtyForm" method="post" action="${pageContext.request.contextPath}/admin/specialties">
            <input type="hidden" name="id" id="specId">
            <div style="margin-bottom: 20px;">
                <label style="display: block; margin-bottom: 8px; color: #4a5568; font-weight: 600;">Nom de la Spécialité</label>
                <input type="text" name="nom" id="specNom" required
                       style="width: 100%; padding: 12px; border: 2px solid #e2e8f0; border-radius: 8px; font-size: 14px;">
            </div>
            <div style="margin-bottom: 20px;">
                <label style="display: block; margin-bottom: 8px; color: #4a5568; font-weight: 600;">Description</label>
                <textarea name="description" id="specDescription" rows="3"
                          style="width: 100%; padding: 12px; border: 2px solid #e2e8f0; border-radius: 8px; font-size: 14px;"></textarea>
            </div>
            <div style="margin-bottom: 20px;">
                <label style="display: block; margin-bottom: 8px; color: #4a5568; font-weight: 600;">Département</label>
                <select name="departmentId" id="specDepartmentId"
                        style="width: 100%; padding: 12px; border: 2px solid #e2e8f0; border-radius: 8px; font-size: 14px;">
                    <option value="">Sélectionner un département</option>
                    <c:forEach items="${departments}" var="dept">
                        <option value="${dept.id}">${dept.nom}</option>
                    </c:forEach>
                </select>
            </div>
            <div style="display: flex; gap: 10px; justify-content: flex-end;">
                <button type="button" onclick="closeSpecialtyModal()" class="btn" style="background: #e2e8f0; color: #4a5568;">
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
    function showAddSpecialtyForm() {
        document.getElementById('modalTitle').textContent = 'Ajouter une Spécialité';
        document.getElementById('specialtyForm').reset();
        document.getElementById('specId').value = '';
        document.getElementById('specialtyModal').style.display = 'flex';
    }

    function editSpecialty(id, nom, description, departmentId) {
        document.getElementById('modalTitle').textContent = 'Modifier la Spécialité';
        document.getElementById('specId').value = id;
        document.getElementById('specNom').value = nom;
        document.getElementById('specDescription').value = description || '';
        document.getElementById('specDepartmentId').value = departmentId || '';
        document.getElementById('specialtyModal').style.display = 'flex';
    }

    function closeSpecialtyModal() {
        document.getElementById('specialtyModal').style.display = 'none';
    }

    // Close modal when clicking outside
    document.getElementById('specialtyModal')?.addEventListener('click', function(e) {
        if (e.target === this) {
            closeSpecialtyModal();
        }
    });
</script>
