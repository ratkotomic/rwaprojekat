package com.example.rwaprojekat.dao;

import com.example.rwaprojekat.model.Quiz;
import jakarta.transaction.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;
import java.util.List;

public class QuizDao {
    public QuizDao() {
    }

    @Transactional
    public Quiz createQuiz(Quiz quiz) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("rwaprojekat");
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.persist(quiz);
        em.getTransaction().commit();
        em.close();
        return quiz;
    }

    public void deleteQuiz(String id) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("rwaprojekat");
        EntityManager em = emf.createEntityManager();
        Query q = em.createQuery("DELETE FROM Quiz q WHERE q.id = :id");
        q.setParameter("id", id);
        em.getTransaction().begin();
        q.executeUpdate();
        em.getTransaction().commit();
        em.close();
    }

    public Quiz findQuizById(String quizId) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("rwaprojekat");
        EntityManager em = emf.createEntityManager();
        Query q = em.createQuery("SELECT q FROM Quiz q WHERE q.id = :id").setParameter("id", quizId);
        if (q.getResultList().size() == 0) return null;
        Quiz quiz = (Quiz) q.getSingleResult();
        em.close();
        return quiz;
    }

    public void updateQuiz(String quizTitle, String imageUrl, String quizId) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("rwaprojekat");
        EntityManager em = emf.createEntityManager();
        Query q = null;
        try {
            q = em.createQuery("UPDATE Quiz q SET q.title = :quizTitle, q.imageUrl = :imageUrl WHERE q.id = :quizId");
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
        q.setParameter("quizTitle", quizTitle);
        q.setParameter("imageUrl", imageUrl);
        q.setParameter("quizId", quizId);
        em.getTransaction().begin();
        q.executeUpdate();
        em.getTransaction().commit();
        em.close();
    }

    public List<Quiz> findAllQuizzes() {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("rwaprojekat");
        EntityManager em = emf.createEntityManager();
        Query q = em.createQuery("SELECT q FROM Quiz q");
        List<Quiz> quizList = q.getResultList();
        em.close();
        return quizList;
    }
}
