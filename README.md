# 🏥 Clinique Digitale - Application Web Java EE

Application web de gestion de clinique développée avec Java EE, JPA/Hibernate, PostgreSQL.

## 🚀 Fonctionnalités Implémentées

### ✅ Authentification
- **Inscription Patient** - Création de compte avec validation
- **Connexion** - Authentification sécurisée avec BCrypt
- **Déconnexion** - Gestion de session
- **Test de connexion DB** - Vérification de la connectivité PostgreSQL

### 📋 Architecture

```
src/main/java/com/example/demo2/
├── entity/          # Entités JPA (User, Patient, Doctor, etc.)
├── dto/             # Data Transfer Objects
├── mapper/          # Conversion Entity ↔ DTO
├── repository/      # Couche d'accès aux données (DAO)
├── service/         # Logique métier
├── servlet/         # Contrôleurs web (Servlets)
├── enums/           # Énumérations (UserRole, AppointmentStatus, etc.)
└── util/            # Utilitaires (JPAUtil, PasswordUtil)
```

## 🛠️ Technologies Utilisées

- **Java 17** (LTS)
- **Jakarta EE 10** (Servlets, JSP, JSTL)
- **JPA 3.1** avec **Hibernate 6.4**
- **PostgreSQL 42.7**
- **Maven** pour la gestion de projet
- **BCrypt** pour le hachage des mots de passe
- **HikariCP** pour le pool de connexions

## 📦 Prérequis

- JDK 17 ou supérieur
- Maven 3.6+
- PostgreSQL 12+ (running on Docker port 5432)
- Serveur d'application: Tomcat 10+ / GlassFish 7+ / WildFly 27+

## 🔧 Configuration de la Base de Données

### 1. Créer la base de données PostgreSQL

```bash
# Se connecter au conteneur Docker PostgreSQL
docker exec -it <container_name> psql -U postgres

# Créer la base de données
CREATE DATABASE clinique_digitale;
```

### 2. Exécuter le script de création des tables

Exécutez le script SQL fourni dans le brief pour créer toutes les tables.

### 3. Insérer les données de test

```bash
psql -U postgres -d clinique_digitale -f src/main/resources/test-data.sql
```

## 🚀 Démarrage de l'Application

### 1. Compiler le projet

```bash
cd /home/yassine/IdeaProjects/demo2
mvn clean package
```

### 2. Déployer sur Tomcat

Le fichier WAR sera généré dans: `target/demo2-1.0-SNAPSHOT.war`

**Option A: Déploiement via Tomcat Manager**
- Copier le WAR vers `$TOMCAT_HOME/webapps/`
- Tomcat déploiera automatiquement

**Option B: Déploiement via IDE**
- Configurer Tomcat dans IntelliJ IDEA
- Run → Edit Configurations → Add Tomcat Server
- Deploy artifact: `demo2:war exploded`

### 3. Accéder à l'application

```
http://localhost:8080/demo2/
```

## 🧪 Test de l'Application

### Test de connexion à la base de données
```
http://localhost:8080/demo2/test-db
```

### Comptes de test

**Patient:**
- Email: `patient@test.com`
- Password: `password123`

**Doctor:**
- Email: `doctor@test.com`
- Password: `password123`

**Admin:**
- Email: `admin@test.com`
- Password: `password123`

**Staff:**
- Email: `staff@test.com`
- Password: `password123`

## 📱 Pages Disponibles

| URL | Description |
|-----|-------------|
| `/` | Page d'accueil |
| `/login` | Page de connexion |
| `/register` | Inscription patient |
| `/test-db` | Test connexion DB |
| `/patient/dashboard` | Dashboard patient |
| `/logout` | Déconnexion |

## 🔐 Sécurité

- **Hachage des mots de passe**: BCrypt avec 12 rounds
- **Validation des entrées**: Server-side et client-side
- **Gestion de session**: HttpSession avec timeout de 1 heure
- **Protection CSRF**: À implémenter (prochaine étape)

## 📝 Configuration JPA

Le fichier `persistence.xml` est configuré pour:
- **Base de données**: `clinique_digitale`
- **Host**: `localhost:5432`
- **User**: `postgres`
- **Password**: `1234`

Pour modifier la configuration, éditez: `src/main/resources/META-INF/persistence.xml`

## 🐛 Dépannage

### Erreur de connexion à la base de données

1. Vérifiez que PostgreSQL est en cours d'exécution:
   ```bash
   docker ps
   ```

2. Vérifiez les identifiants dans `persistence.xml`

3. Testez la connexion manuellement:
   ```bash
   psql -h localhost -p 5432 -U postgres -d clinique_digitale
   ```

### Erreur de compilation Maven

```bash
mvn clean install -U
```

### Problème de déploiement Tomcat

- Vérifiez les logs: `$TOMCAT_HOME/logs/catalina.out`
- Nettoyez le répertoire work: `$TOMCAT_HOME/work/`

## 📈 Prochaines Étapes

- [ ] Dashboard complet pour chaque rôle
- [ ] Gestion des rendez-vous
- [ ] Système de disponibilités des docteurs
- [ ] Notes médicales
- [ ] Recherche et filtrage
- [ ] Tests unitaires (JUnit 5 + Mockito)
- [ ] API REST
- [ ] Interface moderne (React/Vue.js)

## 👨‍💻 Développeur

Yassine - Projet Clinique Digitale 2025

## 📄 Licence

Projet pédagogique - Tous droits réservés
-- Insert test users for authentication testing
-- Password for all test users: "password123"
-- BCrypt hash of "password123": $2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5/0pEKFLPAlaG

-- Test Patient
INSERT INTO public.users (id, nom, email, password, role, actif) 
VALUES (
    gen_random_uuid(),
    'Ahmed Benali',
    'patient@test.com',
    '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5/0pEKFLPAlaG',
    'PATIENT',
    true
);

INSERT INTO public.patients (id, cin, naissance, sexe, adresse, telephone, sang)
SELECT id, 'AB123456', '1990-01-15', 'MALE', '123 Rue Hassan II, Casablanca', '0612345678', 'A_POSITIVE'
FROM public.users WHERE email = 'patient@test.com';

-- Test Doctor
INSERT INTO public.users (id, nom, email, password, role, actif) 
VALUES (
    gen_random_uuid(),
    'Dr. Sara Alami',
    'doctor@test.com',
    '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5/0pEKFLPAlaG',
    'DOCTOR',
    true
);

INSERT INTO public.doctors (id, matricule, titre)
SELECT id, 'DOC001', 'Dr.'
FROM public.users WHERE email = 'doctor@test.com';

-- Test Admin
INSERT INTO public.users (id, nom, email, password, role, actif) 
VALUES (
    gen_random_uuid(),
    'Admin User',
    'admin@test.com',
    '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5/0pEKFLPAlaG',
    'ADMIN',
    true
);

-- Test Staff
INSERT INTO public.users (id, nom, email, password, role, actif) 
VALUES (
    gen_random_uuid(),
    'Staff Member',
    'staff@test.com',
    '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5/0pEKFLPAlaG',
    'STAFF',
    true
);

-- Add some departments
INSERT INTO public.departments (id, nom, description)
VALUES 
    (gen_random_uuid(), 'Cardiologie', 'Département de cardiologie'),
    (gen_random_uuid(), 'Pédiatrie', 'Département de pédiatrie'),
    (gen_random_uuid(), 'Dermatologie', 'Département de dermatologie');

-- Add specialties
INSERT INTO public.specialties (id, nom, description, department_id)
SELECT gen_random_uuid(), 'Cardiologie Générale', 'Spécialité en cardiologie générale', id
FROM public.departments WHERE nom = 'Cardiologie';

INSERT INTO public.specialties (id, nom, description, department_id)
SELECT gen_random_uuid(), 'Pédiatrie Générale', 'Spécialité en pédiatrie générale', id
FROM public.departments WHERE nom = 'Pédiatrie';

