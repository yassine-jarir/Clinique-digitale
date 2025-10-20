package com.example.demo2.repository;

import com.example.demo2.entity.Doctor;
import com.example.demo2.entity.Patient;
import com.example.demo2.util.JPAUtil;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.Query;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public class PatientRepository {

    public List<Doctor> findAllDoctores(){
        EntityManager em = JPAUtil.getEntityManager();
        try{
            Query query = em.createQuery("SELECT d FROM Doctor d LEFT JOIN FETCH d.specialite WHERE d.actif = true", Doctor.class);
            return query.getResultList();
        } catch (NoResultException e) {
            return List.of();
        } finally {
            em.close();
        }

    }

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


    public List<Patient> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery("SELECT p FROM Patient p", Patient.class).getResultList();
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

    public List<Doctor> findDoctoresBySpecialty(UUID specialtyId){
        EntityManager em = JPAUtil.getEntityManager();
        try{
            Query query = em.createQuery("SELECT d FROM Doctor d LEFT JOIN FETCH d.specialite WHERE d.actif = true AND d.specialite.id = :specialtyId", Doctor.class);
            query.setParameter("specialtyId", specialtyId);
            return query.getResultList();
        } catch (NoResultException e) {
            return List.of();
        } finally {
            em.close();
        }
    }
}
