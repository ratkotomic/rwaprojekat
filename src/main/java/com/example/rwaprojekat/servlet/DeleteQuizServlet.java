package com.example.rwaprojekat.servlet;

import com.example.rwaprojekat.dao.QuizDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "/DeleteQuiz", urlPatterns = "/deleteQuiz")
public class DeleteQuizServlet extends HttpServlet {
    QuizDao quizDao;

    public DeleteQuizServlet( ) {
        quizDao = new QuizDao();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        quizDao.deleteQuiz(req.getParameter("id"));
    }
}
