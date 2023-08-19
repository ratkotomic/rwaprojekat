package com.example.rwaprojekat.servlet;

import com.example.rwaprojekat.dao.UserDao;
import com.example.rwaprojekat.model.User;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "/GetUser", urlPatterns = "/admin/getUser")
public class GetUserServlet extends HttpServlet {
    UserDao userDao;

    public GetUserServlet() {
        userDao = new UserDao();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        String userId = req.getParameter("id");
        User user = userDao.findByUserId(userId);

        ObjectMapper objectMapper = new ObjectMapper();
        String quizJson = objectMapper.writeValueAsString(user);

        resp.getWriter().write(quizJson);
    }
}
