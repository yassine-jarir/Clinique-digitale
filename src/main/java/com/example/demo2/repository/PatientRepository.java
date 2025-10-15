package com.example.demo2.repository;

import com.example.demo2.entity.Patient;
import com.example.demo2.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public class PatientRepository {

    public void save(Patient patient) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(patient);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }

    public void update(Patient patient) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(patient);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }

    public Optional<Patient> findById(UUID id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            Patient patient = em.find(Patient.class, id);
            return Optional.ofNullable(patient);
        } finally {
            em.close();
        }
    }

    public Optional<Patient> findByCin(String cin) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            Patient patient = em.createQuery("SELECT p FROM Patient p WHERE p.cin = :cin", Patient.class)
                    .setParameter("cin", cin)
                    .getSingleResult();
            return Optional.of(patient);
        } catch (NoResultException e) {
            return Optional.empty();
        } finally {
            em.close();
        }
    }

    public List<Patient> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT p FROM Patient p", Patient.class).getResultList();
        } finally {
            em.close();
        }
    }

    public List<Patient> findActivePatients() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT p FROM Patient p WHERE p.actif = true", Patient.class)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public void delete(UUID id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Patient patient = em.find(Patient.class, id);
            if (patient != null) {
                em.remove(patient);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }

    public boolean existsByCin(String cin) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            Long count = em.createQuery("SELECT COUNT(p) FROM Patient p WHERE p.cin = :cin", Long.class)
                    .setParameter("cin", cin)
                    .getSingleResult();
            return count > 0;
        } finally {
            em.close();
        }
    }
}

