package com.example.demo2.repository;

import com.example.demo2.entity.Appointment;
import com.example.demo2.enums.AppointmentStatus;
import com.example.demo2.util.JPAUtil;
import jakarta.persistence.EntityManager;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

public class AppointmentRepository {

    public void save(Appointment appointment) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(appointment);
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

    public void update(Appointment appointment) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(appointment);
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

    public Optional<Appointment> findById(UUID id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            Appointment appointment = em.find(Appointment.class, id);
            return Optional.ofNullable(appointment);
        } finally {
            em.close();
        }
    }

    public List<Appointment> findByPatientId(UUID patientId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT a FROM Appointment a WHERE a.patient.id = :patientId ORDER BY a.dateRdv DESC, a.heure DESC", Appointment.class)
                    .setParameter("patientId", patientId)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public boolean hasConflict(UUID doctorId, LocalDate date, LocalTime heure) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            Long count = em.createQuery("SELECT COUNT(a) FROM Appointment a WHERE a.doctor.id = :doctorId AND a.dateRdv = :date AND a.heure = :heure AND a.statut != :canceledStatus", Long.class)
                    .setParameter("doctorId", doctorId)
                    .setParameter("date", date)
                    .setParameter("heure", heure)
                    .setParameter("canceledStatus", AppointmentStatus.CANCELED)
                    .getSingleResult();
            return count > 0;
        } finally {
            em.close();
        }
    }

    public List<Appointment> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT a FROM Appointment a ORDER BY a.dateRdv DESC, a.heure DESC", Appointment.class)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public void delete(UUID id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Appointment appointment = em.find(Appointment.class, id);
            if (appointment != null) {
                em.remove(appointment);
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

    // New: find appointments for a doctor on a specific date (excluding canceled)
    public List<Appointment> findByDoctorIdAndDate(UUID doctorId, LocalDate date) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT a FROM Appointment a WHERE a.doctor.id = :doctorId AND a.dateRdv = :date AND a.statut != :canceledStatus ORDER BY a.heure", Appointment.class)
                    .setParameter("doctorId", doctorId)
                    .setParameter("date", date)
                    .setParameter("canceledStatus", AppointmentStatus.CANCELED)
                    .getResultList();
        } finally {
            em.close();
        }
    }
}
