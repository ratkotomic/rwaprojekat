package com.example.rwaprojekat.dao;

import com.example.rwaprojekat.model.User;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

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
        }
        catch(Exception ex)
        {
            return null;
        }
        finally{
            em.close();
        }
        return user;
    }
}
