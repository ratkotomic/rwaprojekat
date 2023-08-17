package com.example.rwaprojekat.servlet;

import com.example.rwaprojekat.dao.UserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "/DeleteUser", urlPatterns = "/admin/deleteUser")
public class DeleteUserServlet extends HttpServlet {
    UserDao userDao;

    public DeleteUserServlet( ) {
        userDao = new UserDao();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        userDao.deleteUser(req.getParameter("username"));
    }
}
