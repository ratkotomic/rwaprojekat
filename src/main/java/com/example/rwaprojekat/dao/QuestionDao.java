package com.example.rwaprojekat.dao;

import com.example.rwaprojekat.model.Question;
import jakarta.transaction.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

public class QuestionDao {
    public QuestionDao() {
    }

    @Transactional
    public void createQuestion(Question question) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("rwaprojekat");
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.persist(question);
        em.getTransaction().commit();
        em.close();
    }

    public Question findQuestionById(String questionId) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("rwaprojekat");
        EntityManager em = emf.createEntityManager();
        Query q = em.createQuery("SELECT q FROM Question q WHERE q.id = :id").setParameter("id", questionId);
        if (q.getResultList().size() == 0) return null;
        Question question = (Question) q.getSingleResult();
        em.close();
        return question;
    }

    public void updateQuestion(String text, int points, int timeToAnswer, int questionNumber, String questionId) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("rwaprojekat");
        EntityManager em = emf.createEntityManager();
        Query q = em.createQuery("UPDATE Question q SET q.questionText = :questionText, q.points = :points, q.timeToAnswer = :timeToAnswer, q.questionNumber = :questionNumber WHERE q.id = :questionId");
        q.setParameter("questionText", text);
        q.setParameter("timeToAnswer", timeToAnswer);
        q.setParameter("points", points);
        q.setParameter("questionNumber", questionNumber);
        q.setParameter("questionId", questionId);
        em.getTransaction().begin();
        q.executeUpdate();
        em.getTransaction().commit();
        em.close();
    }

    public void deleteQuestion(String id) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("rwaprojekat");
        EntityManager em = emf.createEntityManager();
        Query q = em.createQuery("DELETE FROM Question q WHERE q.id = :id");
        q.setParameter("id", id);
        em.getTransaction().begin();
        q.executeUpdate();
        em.getTransaction().commit();
        em.close();
    }
}
