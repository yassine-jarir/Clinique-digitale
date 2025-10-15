<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Clinique Digitale - Accueil</title>
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
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .welcome-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            padding: 60px;
            text-align: center;
            max-width: 600px;
        }

        h1 {
            color: #333;
            font-size: 2.5rem;
            margin-bottom: 20px;
        }

        p {
            color: #666;
            font-size: 1.2rem;
            margin-bottom: 40px;
        }

        .btn-group {
            display: flex;
            gap: 20px;
            justify-content: center;
        }

        .btn {
            padding: 15px 40px;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 600;
            font-size: 1rem;
            transition: transform 0.2s, box-shadow 0.2s;
            display: inline-block;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-secondary {
            background: white;
            color: #667eea;
            border: 2px solid #667eea;
        }

        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>
<body>
    <div class="welcome-container">
        <h1>🏥 Clinique Digitale</h1>
        <p>Système de gestion de clinique moderne et sécurisé</p>
        <div class="btn-group">
            <a href="<%= request.getContextPath() %>/login" class="btn btn-primary">Se connecter</a>
            <a href="<%= request.getContextPath() %>/test-db" class="btn btn-secondary">Tester la DB</a>
        </div>
    </div>
</body>
</html>

