package com.example.rwaprojekat.dao;

import com.example.rwaprojekat.model.Answer;
import jakarta.transaction.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

public class AnswerDao {
    public AnswerDao() {
    }
    @Transactional
    public void createAnswer(Answer answer) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("rwaprojekat");
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.persist(answer);
        em.getTransaction().commit();
        em.close();
    }

    public void removeAnswersByQuestionId(String questionId) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("rwaprojekat");
        EntityManager em = emf.createEntityManager();
        Query q = em.createQuery("DELETE FROM Answer a WHERE a.question.id = :questionId");
        q.setParameter("questionId", questionId);
        em.getTransaction().begin();
        q.executeUpdate();
        em.getTransaction().commit();
        em.close();
    }
}
