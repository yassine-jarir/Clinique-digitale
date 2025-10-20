-- ===================================
-- SQL QUERIES TO TEST AVAILABILITY
-- ===================================

-- 1. Check if the doctor exists and get their ID
SELECT id, nom, email, matricule
FROM doctors
WHERE email = 'berrada@gmail.com';

-- 2. Check availabilities for this doctor (replace the UUID with the one from query 1)
SELECT id, jour, heure_debut, heure_fin, statut, valide, doctor_id
FROM availabilities
WHERE doctor_id = '537ad4b1-5993-4a9a-8795-d19460e301f4e'
ORDER BY
    CASE jour
        WHEN 'Lundi' THEN 1
        WHEN 'Mardi' THEN 2
        WHEN 'Mercredi' THEN 3
        WHEN 'Jeudi' THEN 4
        WHEN 'Vendredi' THEN 5
        WHEN 'Samedi' THEN 6
        WHEN 'Dimanche' THEN 7
    END,
    heure_debut;

-- 3. Check pauses for this doctor
SELECT id, jour, heure_debut, heure_fin, doctor_id
FROM pauses
WHERE doctor_id = '537ad4b1-5993-4a9a-8795-d19460e301f4e';

-- 4. If no availability exists, INSERT sample data:
-- (Only run this if query #2 returns no results)

INSERT INTO availabilities (id, jour, heure_debut, heure_fin, statut, valide, doctor_id)
VALUES
    (gen_random_uuid(), 'Lundi', '09:00', '17:00', 'AVAILABLE', true, '537ad4b1-5993-4a9a-8795-d19460e301f4e'),
    (gen_random_uuid(), 'Mardi', '09:00', '17:00', 'AVAILABLE', true, '537ad4b1-5993-4a9a-8795-d19460e301f4e'),
    (gen_random_uuid(), 'Mercredi', '09:00', '17:00', 'AVAILABLE', true, '537ad4b1-5993-4a9a-8795-d19460e301f4e'),
    (gen_random_uuid(), 'Jeudi', '09:00', '17:00', 'AVAILABLE', true, '537ad4b1-5993-4a9a-8795-d19460e301f4e'),
    (gen_random_uuid(), 'Vendredi', '09:00', '12:00', 'AVAILABLE', true, '537ad4b1-5993-4a9a-8795-d19460e301f4e');

-- 5. Optional: Add a lunch break
INSERT INTO pauses (id, jour, heure_debut, heure_fin, doctor_id)
VALUES
    (gen_random_uuid(), 'Lundi', '12:00', '13:00', '537ad4b1-5993-4a9a-8795-d19460e301f4e'),
    (gen_random_uuid(), 'Mardi', '12:00', '13:00', '537ad4b1-5993-4a9a-8795-d19460e301f4e'),
    (gen_random_uuid(), 'Mercredi', '12:00', '13:00', '537ad4b1-5993-4a9a-8795-d19460e301f4e'),
    (gen_random_uuid(), 'Jeudi', '12:00', '13:00', '537ad4b1-5993-4a9a-8795-d19460e301f4e');

-- 6. Verify the data was inserted
SELECT jour, heure_debut, heure_fin, statut
FROM availabilities
WHERE doctor_id = '537ad4b1-5993-4a9a-8795-d19460e301f4e'
ORDER BY
    CASE jour
        WHEN 'Lundi' THEN 1
        WHEN 'Mardi' THEN 2
        WHEN 'Mercredi' THEN 3
        WHEN 'Jeudi' THEN 4
        WHEN 'Vendredi' THEN 5
        WHEN 'Samedi' THEN 6
        WHEN 'Dimanche' THEN 7
    END;

