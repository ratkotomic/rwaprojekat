package com.example.rwaprojekat.dao;

import com.example.rwaprojekat.model.Game;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

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
}
