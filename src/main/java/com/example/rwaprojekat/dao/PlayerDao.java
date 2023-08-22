package com.example.rwaprojekat.dao;

import com.example.rwaprojekat.model.Player;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;
import java.util.List;

public class PlayerDao {
    public PlayerDao() {
    }

    public Player createPlayer(Player player) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("rwaprojekat");
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.persist(player);
        em.getTransaction().commit();
        em.close();
        return player;
    }

    public Player findById(String playerId) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("rwaprojekat");
        EntityManager em = emf.createEntityManager();
        Query q = em.createQuery("SELECT p FROM Player p WHERE p.id = :id").setParameter("id", playerId);
        if (q.getResultList().size() == 0) return null;
        Player player = (Player) q.getSingleResult();
        em.close();
        return player;
    }

    public void updatePlayerPoints(String id, Integer points) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("rwaprojekat");
        EntityManager em = emf.createEntityManager();
        Query q = null;
        try {
            q = em.createQuery("UPDATE Player p SET p.points = :points WHERE p.id = :id");
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        q.setParameter("points", points);
        q.setParameter("id", id);
        em.getTransaction().begin();
        q.executeUpdate();
        em.getTransaction().commit();
        em.close();
    }


    public List<Player> getPlayersByQuizPin(String pin) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("rwaprojekat");
        EntityManager em = emf.createEntityManager();
        try {
            Query q = em.createQuery("SELECT p FROM Player p WHERE p.game.pin = :pin").setParameter("pin", pin);
            List<Player> players = q.getResultList();
            return players;
        } finally {
            em.close();
        }
    }
}
