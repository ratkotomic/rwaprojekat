package com.example.rwaprojekat.servlet;

import com.example.rwaprojekat.dao.UserDao;
import com.example.rwaprojekat.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "/AddUser", urlPatterns = "/addUser")
public class AddUserServlet extends HttpServlet {
    UserDao userDao;

    public AddUserServlet( ) {
        userDao = new UserDao();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userName = req.getParameter("username");
        String password = req.getParameter("password");
        String role = req.getParameter("role");

        if (userName.isEmpty() || password.isEmpty() || role.isEmpty()) {

        } else {
            User existingUser = userDao.findByUsername(userName);
            if (existingUser != null) {
//                ("User with username already exists", request, response);
            } else {
                userDao.createUser(new User(userName, password, role));
//                response.sendRedirect("");
            }
        }
    }
}
