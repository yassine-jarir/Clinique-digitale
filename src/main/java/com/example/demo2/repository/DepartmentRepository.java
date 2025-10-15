package com.example.demo2.repository;

import com.example.demo2.entity.Department;
import com.example.demo2.util.JPAUtil;
import jakarta.persistence.EntityManager;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public class DepartmentRepository {

    public void save(Department department) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(department);
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

    public void update(Department department) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(department);
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

    public Optional<Department> findById(UUID id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            Department department = em.find(Department.class, id);
            return Optional.ofNullable(department);
        } finally {
            em.close();
        }
    }

    public List<Department> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT d FROM Department d", Department.class).getResultList();
        } finally {
            em.close();
        }
    }

    public void delete(UUID id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Department department = em.find(Department.class, id);
            if (department != null) {
                em.remove(department);
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

    public long countSpecialtiesByDepartmentId(UUID departmentId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT COUNT(s) FROM Specialty s WHERE s.department.id = :departmentId", Long.class)
                .setParameter("departmentId", departmentId)
                .getSingleResult();
        } finally {
            em.close();
        }
    }
}
