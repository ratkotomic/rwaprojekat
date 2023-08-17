package com.example.rwaprojekat.servlet;

import com.example.rwaprojekat.dao.UserDao;
import com.example.rwaprojekat.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "/UpdateUser", urlPatterns = "/updateUser")
public class UpdateUserServlet extends HttpServlet {
    UserDao userDao;

    public UpdateUserServlet( ) {
        userDao = new UserDao();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId = req.getParameter("id");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String role = req.getParameter("role");

        if (username.isEmpty() || password.isEmpty() || role.isEmpty()) {
//            ("Fields can not be empty", req, response);
        } else {
            User user = userDao.findByUserId(userId);
            if (!username.equals(user.getUsername())) {
                User temp = userDao.findByUsername(username);
                if (temp != null) {
//                    ("User with " + temp.getUserName() + " already exists", req, response);
                } else {
                    userDao.updateUser(userId,username,password,role);
//                    resp.sendRedirect("");
                }
            } else {
                userDao.updateUser(userId,username,password,role);
//                resp.sendRedirect("");
            }
        }
    }
}
