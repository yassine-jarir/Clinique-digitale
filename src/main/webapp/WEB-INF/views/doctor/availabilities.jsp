<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Gérer mes disponibilités</title>
</head>
<body>
<h2>Mes disponibilités</h2>
<c:if test="${not empty error}">
    <div style="color:red;">${error}</div>
</c:if>
<table border="1">
    <tr>
        <th>Jour</th>
        <th>Heure début</th>
        <th>Heure fin</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="a" items="${availabilities}">
        <tr>
            <td>${a.jour}</td>
            <td>${a.heureDebut}</td>
            <td>${a.heureFin}</td>
            <td>
                <form method="post" style="display:inline;">
                    <input type="hidden" name="id" value="${a.id}"/>
                    <input type="hidden" name="action" value="delete"/>
                    <button type="submit">Supprimer</button>
                </form>
                <!-- Edit button can be implemented with JS or a modal if needed -->
            </td>
        </tr>
    </c:forEach>
</table>
<h3>Ajouter une disponibilité</h3>
<form method="post">
    <label>Jour:
        <select name="jour" required>
            <option value="">--Choisir--</option>
            <option value="Lundi">Lundi</option>
            <option value="Mardi">Mardi</option>
            <option value="Mercredi">Mercredi</option>
            <option value="Jeudi">Jeudi</option>
            <option value="Vendredi">Vendredi</option>
            <option value="Samedi">Samedi</option>
            <option value="Dimanche">Dimanche</option>
        </select>
    </label>
    <label>Heure début: <input type="time" name="heureDebut" required></label>
    <label>Heure fin: <input type="time" name="heureFin" required></label>
    <button type="submit">Ajouter</button>
</form>
</body>
</html>

