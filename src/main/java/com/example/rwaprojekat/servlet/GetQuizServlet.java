package com.example.rwaprojekat.servlet;

import com.example.rwaprojekat.dao.QuizDao;
import com.example.rwaprojekat.model.Question;
import com.example.rwaprojekat.model.Quiz;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Comparator;

@WebServlet(name = "/GetQuiz", urlPatterns = "/admin/getQuiz")
public class GetQuizServlet extends HttpServlet {
    QuizDao quizDao;

    public GetQuizServlet() {
        quizDao = new QuizDao();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        String quizId = req.getParameter("id");
        Quiz quiz = quizDao.findQuizById(quizId);
        quiz.getQuestions().sort(Comparator.comparingInt(Question::getQuestionNumber));

        ObjectMapper objectMapper = new ObjectMapper();
        String quizJson = objectMapper.writeValueAsString(quiz);

        resp.getWriter().write(quizJson);
    }
}
