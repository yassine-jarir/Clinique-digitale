package com.example.demo2.repository;

import com.example.demo2.entity.Specialty;
import com.example.demo2.util.JPAUtil;
import jakarta.persistence.EntityManager;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public class SpecialtyRepository {

    public void save(Specialty specialty) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(specialty);
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

    public void update(Specialty specialty) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(specialty);
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

    public Optional<Specialty> findById(UUID id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            Specialty specialty = em.createQuery(
                "SELECT s FROM Specialty s LEFT JOIN FETCH s.department WHERE s.id = :id",
                Specialty.class)
                .setParameter("id", id)
                .getSingleResult();
            return Optional.ofNullable(specialty);
        } catch (Exception e) {
            return Optional.empty();
        } finally {
            em.close();
        }
    }

    public List<Specialty> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT s FROM Specialty s LEFT JOIN FETCH s.department", Specialty.class)
                .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Specialty> findByDepartmentId(UUID departmentId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT s FROM Specialty s LEFT JOIN FETCH s.department WHERE s.department.id = :departmentId", Specialty.class)
                    .setParameter("departmentId", departmentId)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public void delete(UUID id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Specialty specialty = em.find(Specialty.class, id);
            if (specialty != null) {
                em.remove(specialty);
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
}
