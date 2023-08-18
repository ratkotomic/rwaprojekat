package com.example.rwaprojekat.servlet;

import com.example.rwaprojekat.dao.QuizDao;
import com.example.rwaprojekat.model.Quiz;
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

    public AdminHomeServlet() {
        quizDao = new QuizDao();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        List<Quiz> quizList = quizDao.findAllQuizzes();
        req.setAttribute("quizList", quizList);

        dispatcher = req.getRequestDispatcher("/admin/home.jsp");
        dispatcher.forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


    }
}
