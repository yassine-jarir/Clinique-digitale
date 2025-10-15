<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription - Clinique Digitale</title>
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

        .register-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            overflow: hidden;
            max-width: 500px;
            width: 100%;
            padding: 50px 40px;
        }

        .register-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .register-header h2 {
            color: #333;
            font-size: 2rem;
            margin-bottom: 10px;
        }

        .register-header p {
            color: #666;
            font-size: 0.95rem;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
            font-size: 0.95rem;
        }

        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s;
        }

        .form-group input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .alert {
            padding: 12px 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 0.9rem;
        }

        .alert-error {
            background-color: #fee;
            border: 1px solid #fcc;
            color: #c33;
        }

        .btn-register {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
            margin-top: 10px;
        }

        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
        }

        .btn-register:active {
            transform: translateY(0);
        }

        .login-link {
            text-align: center;
            margin-top: 25px;
            color: #666;
            font-size: 0.95rem;
        }

        .login-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        .password-hint {
            font-size: 0.85rem;
            color: #999;
            margin-top: 5px;
        }

        @media (max-width: 768px) {
            .register-container {
                padding: 40px 30px;
            }
        }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="register-header">
            <h2>🏥 Créer un compte</h2>
            <p>Inscrivez-vous pour prendre rendez-vous</p>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-error">
                ${error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/register" method="post">
            <div class="form-group">
                <label for="nom">Nom complet *</label>
                <input type="text"
                       id="nom"
                       name="nom"
                       placeholder="Ex: Ahmed Benali"
                       value="${nom}"
                       required
                       autofocus>
            </div>

            <div class="form-group">
                <label for="cin">CIN *</label>
                <input type="text"
                       id="cin"
                       name="cin"
                       placeholder="Ex: AB123456"
                       value="${cin}"
                       required>
            </div>

            <div class="form-group">
                <label for="email">Email *</label>
                <input type="email"
                       id="email"
                       name="email"
                       placeholder="votre@email.com"
                       value="${email}"
                       required>
            </div>

            <div class="form-group">
                <label for="password">Mot de passe *</label>
                <input type="password"
                       id="password"
                       name="password"
                       placeholder="••••••••"
                       required
                       minlength="6">
                <div class="password-hint">Minimum 6 caractères</div>
            </div>

            <div class="form-group">
                <label for="confirmPassword">Confirmer le mot de passe *</label>
                <input type="password"
                       id="confirmPassword"
                       name="confirmPassword"
                       placeholder="••••••••"
                       required
                       minlength="6">
            </div>

            <button type="submit" class="btn-register">S'inscrire</button>
        </form>

        <div class="login-link">
            Vous avez déjà un compte ? <a href="${pageContext.request.contextPath}/login">Se connecter</a>
        </div>
    </div>

    <script>
        document.querySelector('form').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;

            if (password !== confirmPassword) {
                e.preventDefault();
                alert('Les mots de passe ne correspondent pas!');
            }
        });
    </script>
</body>
</html>

