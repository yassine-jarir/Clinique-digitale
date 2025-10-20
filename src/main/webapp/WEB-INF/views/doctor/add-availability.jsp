<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ajouter une disponibilité</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f7fa;
            padding: 20px;
        }
        .container {
            max-width: 600px;
            margin: 40px auto;
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #1e3c72;
            margin-bottom: 30px;
            text-align: center;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            font-weight: 600;
            margin-bottom: 8px;
            color: #555;
        }
        input[type="date"],
        input[type="time"] {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1em;
        }
        input:focus {
            outline: none;
            border-color: #1e3c72;
        }
        .btn-primary {
            width: 100%;
            padding: 15px;
            background: #1e3c72;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1.1em;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s;
        }
        .btn-primary:hover {
            background: #2a5298;
        }
        .alert {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .alert.error {
            background: #fee;
            color: #c33;
            border-left: 4px solid #c33;
        }
        .back-link {
            display: inline-block;
            color: #1e3c72;
            text-decoration: none;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="${pageContext.request.contextPath}/doctor/availabilities" class="back-link">← Retour</a>
        <h1>➕ Ajouter une disponibilité</h1>

        <c:if test="${not empty error}">
            <div class="alert error">${error}</div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/doctor/availabilities">
            <div class="form-group">
                <label for="date">Date *</label>
                <input type="date" id="date" name="date" required>
            </div>

            <div class="form-group">
                <label for="heureDebut">Heure de début *</label>
                <input type="time" id="heureDebut" name="heureDebut" required>
            </div>

            <div class="form-group">
                <label for="heureFin">Heure de fin *</label>
                <input type="time" id="heureFin" name="heureFin" required>
            </div>

            <button type="submit" class="btn-primary">Enregistrer</button>
        </form>
    </div>

    <script>
        // Set minimum date to today
        document.getElementById('date').min = new Date().toISOString().split('T')[0];
    </script>
</body>
</html>

