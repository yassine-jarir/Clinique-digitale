-- Script to create a test admin user for testing department and specialty management
-- Password: admin123 (hashed with BCrypt)

INSERT INTO public.users (id, nom, email, role, actif)
VALUES
    ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Admin User', 'admin@clinique.com', 'ADMIN', true)
ON CONFLICT (email) DO NOTHING;

