package com.example.demo2.repository;

import com.example.demo2.entity.Pause;
import com.example.demo2.util.JPAUtil;
import jakarta.persistence.EntityManager;

import java.util.List;
import java.util.UUID;

public class PauseRepository {

    public List<Pause> findByDoctorIdAndDay(UUID doctorId, String jour) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT p FROM Pause p WHERE p.doctor.id = :doctorId AND p.jour = :jour", Pause.class)
                    .setParameter("doctorId", doctorId)
                    .setParameter("jour", jour)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public void save(Pause pause, java.util.UUID doctorId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            var doctor = em.find(com.example.demo2.entity.Doctor.class, doctorId);
            if (doctor == null) throw new RuntimeException("Doctor not found");
            pause.setDoctor(doctor);
            em.persist(pause);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }
}

