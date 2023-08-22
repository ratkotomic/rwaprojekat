package com.example.rwaprojekat.dao;

import com.example.rwaprojekat.model.Game;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

public class GameDao {
    public GameDao() {
    }

    public Game createGame(Game game) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("rwaprojekat");
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.persist(game);
        em.getTransaction().commit();
        em.close();
        return game;
    }

    public Game findGameByPin(String pin) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("rwaprojekat");
        EntityManager em = emf.createEntityManager();
        Query q = em.createQuery("SELECT g FROM Game g WHERE g.pin = :pin").setParameter("pin", pin);
        if (q.getResultList().size() == 0) return null;
        Game game = (Game) q.getSingleResult();
        em.close();
        return game;
    }

    public void updateStatus(String pin, String status) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("rwaprojekat");
        EntityManager em = emf.createEntityManager();
        Query q = null;
        try {
            q = em.createQuery("UPDATE Game g SET g.status = :status WHERE g.pin = :pin");
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        q.setParameter("pin", pin);
        q.setParameter("status", status);
        em.getTransaction().begin();
        q.executeUpdate();
        em.getTransaction().commit();
        em.close();
    }
}
