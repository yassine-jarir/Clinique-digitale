package com.example.demo2.repository;

import com.example.demo2.entity.Doctor;
import com.example.demo2.util.JPAUtil;
import jakarta.persistence.EntityManager;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public class DoctorRepository {

    public void save(Doctor doctor) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(doctor);
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

    public void update(Doctor doctor) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(doctor);
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

    public Optional<Doctor> findById(UUID id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            Doctor doctor = em.createQuery(
                "SELECT d FROM Doctor d LEFT JOIN FETCH d.specialite WHERE d.id = :id",
                Doctor.class)
                .setParameter("id", id)
                .getSingleResult();
            return Optional.ofNullable(doctor);
        } catch (Exception e) {
            return Optional.empty();
        } finally {
            em.close();
        }
    }


    public List<Doctor> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT d FROM Doctor d LEFT JOIN FETCH d.specialite", Doctor.class)
                .getResultList();
        } finally {
            em.close();
        }
    }


    public List<Doctor> findActiveDoctors() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT d FROM Doctor d LEFT JOIN FETCH d.specialite WHERE d.actif = true", Doctor.class)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public void delete(UUID id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Doctor doctor = em.find(Doctor.class, id);
            if (doctor != null) {
                em.remove(doctor);
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

    public boolean existsByMatricule(String matricule) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            Long count = em.createQuery("SELECT COUNT(d) FROM Doctor d WHERE d.matricule = :matricule", Long.class)
                    .setParameter("matricule", matricule)
                    .getSingleResult();
            return count > 0;
        } finally {
            em.close();
        }
    }

    public long countBySpecialtyId(UUID specialtyId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            Long count = em.createQuery("SELECT COUNT(d) FROM Doctor d WHERE d.specialite.id = :specialtyId AND d.actif = true", Long.class)
                    .setParameter("specialtyId", specialtyId)
                    .getSingleResult();
            return count != null ? count : 0L;
        } finally {
            em.close();
        }
    }
}
