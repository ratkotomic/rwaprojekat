package com.example.rwaprojekat.servlet;

import com.example.rwaprojekat.dao.UserDao;
import com.example.rwaprojekat.model.User;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.swing.*;
import java.io.IOException;

@WebServlet(name = "/UpdateUser", urlPatterns = "/admin/updateUser")
public class UpdateUserServlet extends HttpServlet {
    UserDao userDao;

    public UpdateUserServlet( ) {
        userDao = new UserDao();
    }
    private final ObjectMapper objectMapper = new ObjectMapper();



    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId = req.getParameter("id");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String role = req.getParameter("role");

        if (username.isEmpty() || password.isEmpty() || role.isEmpty()) {
        } else {
            User user = userDao.findByUserId(userId);
            if (!username.equals(user.getUsername())) {
                User temp = userDao.findByUsername(username);
                if (temp != null) {
                    JOptionPane.showMessageDialog(null, "Vec postoji user sa username " + temp.getUsername());
                    resp.sendRedirect("/rwaprojekat/admin/home");
                } else {
                    userDao.updateUser(userId,username,password,role);
                }
            } else {
                userDao.updateUser(userId,username,password,role);
            }
        }
    }
}
