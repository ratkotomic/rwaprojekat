package com.example.rwaprojekat.servlet;

import com.example.rwaprojekat.dao.QuizDao;
import com.example.rwaprojekat.dao.UserDao;
import com.example.rwaprojekat.model.Quiz;
import com.example.rwaprojekat.model.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "/AdminHome", urlPatterns = "/admin/home")
public class AdminHomeServlet extends HttpServlet {

    RequestDispatcher dispatcher = null;
    QuizDao quizDao;
    UserDao userDao;

    public AdminHomeServlet() {
        quizDao = new QuizDao();
        userDao = new UserDao();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        List<Quiz> quizList = quizDao.findAllQuizzes();
        List<User> userList = userDao.findAllUsers();
        req.setAttribute("quizList", quizList);
        req.setAttribute("userList", userList);

        dispatcher = req.getRequestDispatcher("/admin/home.jsp");
        dispatcher.forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


    }
}
