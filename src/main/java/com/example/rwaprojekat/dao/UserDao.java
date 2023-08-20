package com.example.rwaprojekat.dao;

import com.example.rwaprojekat.model.User;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;
import java.util.List;

public class UserDao {

    public UserDao() {
    }

    public User getUser(String username, String password) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("rwaprojekat");
        EntityManager em = emf.createEntityManager();
        Query q = em.createQuery("SELECT u FROM User u where u.username=:username and u.password=:password");
        q.setParameter("username", username);
        q.setParameter("password", password);
        User user;
        try {
            user = (User) q.setMaxResults(1).getSingleResult();
        } catch (Exception ex) {
            return null;
        } finally {
            em.close();
        }
        return user;
    }

    public User findByUserId(String userId) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("rwaprojekat");
        EntityManager em = emf.createEntityManager();
        Query q = em.createQuery("SELECT u FROM User u WHERE u.id = :userId").setParameter("userId", userId);
        if (q.getResultList().size() == 0) return null;
        User user = (User) q.setMaxResults(1).getSingleResult();
        em.close();
        return user;
    }

    public User findByUsername(String username) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("rwaprojekat");
        EntityManager em = emf.createEntityManager();
        Query q = em.createQuery("SELECT u FROM User u WHERE u.username = :username").setParameter("username", username);
        if (q.getResultList().isEmpty()) return null;
        User user = (User) q.setMaxResults(1).getSingleResult();
        em.close();
        return user;
    }

    public User createUser(User user) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("rwaprojekat");
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.persist(user);
        em.getTransaction().commit();
        em.close();
        return user;
    }

    public void deleteUser(String id) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("rwaprojekat");
        EntityManager em = emf.createEntityManager();
        Query q = em.createQuery("DELETE FROM User u WHERE u.id = :id");
        q.setParameter("id", id);
        em.getTransaction().begin();
        q.executeUpdate();
        em.getTransaction().commit();
        em.close();
    }

    public void updateUser(String id, String username, String password, String role) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("rwaprojekat");
        EntityManager em = emf.createEntityManager();
        Query q = null;
        try {
            q = em.createQuery("UPDATE User u SET u.username = :username, u.password = :password, u.role = :role WHERE u.id = :id");
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        q.setParameter("username", username);
        q.setParameter("password", password);
        q.setParameter("role", role);
        q.setParameter("id", id);
        em.getTransaction().begin();
        q.executeUpdate();
        em.getTransaction().commit();
        em.close();
    }

    public List<User> findAllUsers() {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("rwaprojekat");
        EntityManager em = emf.createEntityManager();
        Query q = em.createQuery("SELECT u FROM User u");
        List<User> users = q.getResultList();
        em.close();
        return users;
    }
}
