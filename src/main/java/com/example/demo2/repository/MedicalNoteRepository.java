package com.example.demo2.repository;

import com.example.demo2.entity.MedicalNote;
import com.example.demo2.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public class MedicalNoteRepository {

    public void save(MedicalNote medicalNote) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(medicalNote);
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

    public void update(MedicalNote medicalNote) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(medicalNote);
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

    public Optional<MedicalNote> findById(UUID id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            MedicalNote medicalNote = em.find(MedicalNote.class, id);
            return Optional.ofNullable(medicalNote);
        } finally {
            em.close();
        }
    }

    public Optional<MedicalNote> findByAppointmentId(UUID appointmentId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            MedicalNote note = em.createQuery("SELECT m FROM MedicalNote m WHERE m.appointment.id = :appointmentId", MedicalNote.class)
                    .setParameter("appointmentId", appointmentId)
                    .getSingleResult();
            return Optional.of(note);
        } catch (NoResultException e) {
            return Optional.empty();
        } finally {
            em.close();
        }
    }

    public List<MedicalNote> findByPatientId(UUID patientId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT m FROM MedicalNote m WHERE m.appointment.patient.id = :patientId", MedicalNote.class)
                    .setParameter("patientId", patientId)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public void delete(UUID id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            MedicalNote medicalNote = em.find(MedicalNote.class, id);
            if (medicalNote != null) {
                em.remove(medicalNote);
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
