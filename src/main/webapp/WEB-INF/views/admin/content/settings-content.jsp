<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- Settings Content Only (no layout) -->
<div class="page-header">
    <h1><i class="fas fa-cog"></i> Paramètres</h1>
</div>

<div class="tabs-container">
    <h3 style="margin-bottom: 20px; color: #2d3748;">Paramètres du Système</h3>

    <div style="margin-bottom: 25px;">
        <label style="display: block; margin-bottom: 8px; color: #4a5568; font-weight: 600;">Nom de la Clinique</label>
        <input type="text" value="Clinique Digitale"
               style="width: 100%; padding: 12px; border: 2px solid #e2e8f0; border-radius: 8px; font-size: 14px;">
    </div>

    <div style="margin-bottom: 25px;">
        <label style="display: block; margin-bottom: 8px; color: #4a5568; font-weight: 600;">Email de Contact</label>
        <input type="email" value="contact@clinique.com"
               style="width: 100%; padding: 12px; border: 2px solid #e2e8f0; border-radius: 8px; font-size: 14px;">
    </div>

    <div style="margin-bottom: 25px;">
        <label style="display: block; margin-bottom: 8px; color: #4a5568; font-weight: 600;">Téléphone</label>
        <input type="tel" value="+212 5XX XXX XXX"
               style="width: 100%; padding: 12px; border: 2px solid #e2e8f0; border-radius: 8px; font-size: 14px;">
    </div>

    <button class="btn btn-primary">
        <i class="fas fa-save"></i> Enregistrer les Modifications
    </button>
</div>

<div style="text-align: center; padding: 40px 20px; color: #a0aec0; margin-top: 30px;">
    <i class="fas fa-cog" style="font-size: 64px; margin-bottom: 20px;"></i>
    <h3 style="font-size: 20px; margin-bottom: 10px;">Paramètres avancés en développement</h3>
    <p>Les configurations avancées seront bientôt disponibles</p>
</div>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- Doctors Content Only (no layout) -->
<div class="page-header">
    <h1><i class="fas fa-user-md"></i> Gestion des Docteurs</h1>
    <button class="btn btn-primary">
        <i class="fas fa-plus"></i> Ajouter un Docteur
    </button>
</div>

<div class="chart-card">
    <div class="chart-header">
        <h3>Liste des Docteurs</h3>
    </div>
    <div style="text-align: center; padding: 60px 20px; color: #a0aec0;">
        <i class="fas fa-user-md" style="font-size: 64px; margin-bottom: 20px;"></i>
        <h3 style="font-size: 20px; margin-bottom: 10px;">Fonctionnalité en développement</h3>
        <p>La gestion des docteurs sera bientôt disponible</p>
    </div>
</div>

