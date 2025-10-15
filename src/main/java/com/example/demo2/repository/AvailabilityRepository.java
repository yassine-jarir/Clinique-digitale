package com.example.demo2.repository;

import com.example.demo2.entity.Availability;
import com.example.demo2.enums.AvailabilityStatus;
import com.example.demo2.util.JPAUtil;
import jakarta.persistence.EntityManager;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public class AvailabilityRepository {

    public void save(Availability availability) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(availability);
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

    public void update(Availability availability) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(availability);
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

    public Optional<Availability> findById(UUID id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            Availability availability = em.find(Availability.class, id);
            return Optional.ofNullable(availability);
        } finally {
            em.close();
        }
    }

    public List<Availability> findByDoctorId(UUID doctorId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT a FROM Availability a WHERE a.doctor.id = :doctorId", Availability.class)
                    .setParameter("doctorId", doctorId)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Availability> findByDoctorIdAndDay(UUID doctorId, String jour) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT a FROM Availability a WHERE a.doctor.id = :doctorId AND a.jour = :jour AND a.valide = true", Availability.class)
                    .setParameter("doctorId", doctorId)
                    .setParameter("jour", jour)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Availability> findAvailableSlots(UUID doctorId, String jour) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT a FROM Availability a WHERE a.doctor.id = :doctorId AND a.jour = :jour AND a.statut = :statut AND a.valide = true", Availability.class)
                    .setParameter("doctorId", doctorId)
                    .setParameter("jour", jour)
                    .setParameter("statut", AvailabilityStatus.AVAILABLE)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public void delete(UUID id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Availability availability = em.find(Availability.class, id);
            if (availability != null) {
                em.remove(availability);
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

    public boolean hasOverlap(UUID doctorId, String jour, java.time.LocalTime heureDebut, java.time.LocalTime heureFin, UUID excludeId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String jpql = "SELECT COUNT(a) FROM Availability a WHERE a.doctor.id = :doctorId AND a.jour = :jour AND a.valide = true AND " +
                    "((a.heureDebut < :heureFin AND a.heureFin > :heureDebut)" +
                    (excludeId != null ? " AND a.id <> :excludeId" : ")");
            var query = em.createQuery(jpql, Long.class)
                    .setParameter("doctorId", doctorId)
                    .setParameter("jour", jour)
                    .setParameter("heureDebut", heureDebut)
                    .setParameter("heureFin", heureFin);
            if (excludeId != null) {
                query.setParameter("excludeId", excludeId);
            }
            Long count = query.getSingleResult();
            return count > 0;
        } finally {
            em.close();
        }
    }
}
