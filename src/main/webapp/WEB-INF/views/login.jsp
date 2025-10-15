<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion - Clinique Digitale</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .login-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
            max-width: 900px;
            width: 100%;
            display: flex;
        }
        .login-left {
            flex: 1;
            padding: 60px 50px;
            background: #f8f9fa;
            display: none;
        }
        @media (min-width: 768px) {
            .login-left {
                display: flex;
                flex-direction: column;
                justify-content: center;
            }
        }
        .login-left h1 {
            color: #667eea;
            font-size: 32px;
            margin-bottom: 20px;
            font-weight: 700;
        }
        .login-left p {
            color: #6c757d;
            line-height: 1.6;
            margin-bottom: 30px;
        }
        .feature-list {
            list-style: none;
        }
        .feature-list li {
            color: #495057;
            margin-bottom: 15px;
            padding-left: 30px;
            position: relative;
        }
        .feature-list li:before {
            content: "✓";
            position: absolute;
            left: 0;
            color: #667eea;
            font-weight: bold;
            font-size: 18px;
        }
        .login-right {
            flex: 1;
            padding: 60px 50px;
        }
        .login-header {
            text-align: center;
            margin-bottom: 40px;
        }
        .login-header h2 {
            color: #212529;
            font-size: 28px;
            margin-bottom: 10px;
            font-weight: 600;
        }
        .login-header p {
            color: #6c757d;
            font-size: 14px;
        }
        .form-group {
            margin-bottom: 25px;
        }
        .form-group label {
            display: block;
            color: #495057;
            font-weight: 500;
            margin-bottom: 8px;
            font-size: 14px;
        }
        .form-group input {
            width: 100%;
            padding: 14px 18px;
            border: 2px solid #e9ecef;
            border-radius: 10px;
            font-size: 15px;
            transition: all 0.3s;
            outline: none;
        }
        .form-group input:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        .form-options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            font-size: 14px;
        }
        .remember-me {
            display: flex;
            align-items: center;
            color: #495057;
        }
        .remember-me input {
            margin-right: 8px;
            width: auto;
        }
        .forgot-password {
            color: #667eea;
            text-decoration: none;
            transition: color 0.3s;
        }
        .forgot-password:hover {
            color: #764ba2;
        }
        .btn-login {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }
        .btn-login:active {
            transform: translateY(0);
        }
        .divider {
            text-align: center;
            margin: 30px 0;
            position: relative;
        }
        .divider:before {
            content: "";
            position: absolute;
            top: 50%;
            left: 0;
            right: 0;
            height: 1px;
            background: #e9ecef;
        }
        .divider span {
            background: white;
            padding: 0 15px;
            color: #6c757d;
            font-size: 14px;
            position: relative;
            z-index: 1;
        }
        .register-link {
            text-align: center;
            margin-top: 25px;
            color: #6c757d;
            font-size: 14px;
        }
        .register-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
        }
        .register-link a:hover {
            color: #764ba2;
        }
        .alert {
            padding: 12px 18px;
            border-radius: 10px;
            margin-bottom: 20px;
            font-size: 14px;
        }
        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-left">
            <h1>Clinique Digitale</h1>
            <p>Plateforme moderne de gestion médicale pour simplifier vos rendez-vous et améliorer la qualité des soins.</p>
            <ul class="feature-list">
                <li>Planification intelligente des rendez-vous</li>
                <li>Suivi médical complet et sécurisé</li>
                <li>Gestion des disponibilités en temps réel</li>
                <li>Interface intuitive et responsive</li>
            </ul>
        </div>
        <div class="login-right">
            <div class="login-header">
                <h2>Bienvenue</h2>
                <p>Connectez-vous à votre espace personnel</p>
            </div>
            <% if(request.getAttribute("error") != null) { %>
                <div class="alert alert-error">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            <form method="post" action="${pageContext.request.contextPath}/login">
                <div class="form-group">
                    <label for="email">Adresse email</label>
                    <input type="email" id="email" name="email" required placeholder="exemple@email.com">
                </div>
                <div class="form-group">
                    <label for="password">Mot de passe</label>
                    <input type="password" id="password" name="password" required placeholder="••••••••">
                </div>
                <div class="form-options">
                    <label class="remember-me">
                        <input type="checkbox" name="remember">
                        Se souvenir de moi
                    </label>
                    <a href="#" class="forgot-password">Mot de passe oublié ?</a>
                </div>
                <button type="submit" class="btn-login">Se connecter</button>
            </form>
            <div class="divider">
                <span>ou</span>
            </div>
            <div class="register-link">
                Pas encore de compte ? <a href="${pageContext.request.contextPath}/register">S'inscrire</a>
            </div>
        </div>
    </div>
</body>
</html>
