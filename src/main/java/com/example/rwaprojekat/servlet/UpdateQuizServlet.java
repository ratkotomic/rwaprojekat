package com.example.rwaprojekat.servlet;

import com.example.rwaprojekat.dao.QuizDao;
import com.example.rwaprojekat.dto.QuizRequest;
import com.example.rwaprojekat.model.Quiz;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.persistence.EntityNotFoundException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.stream.Collectors;

@WebServlet(name = "/UpdateQuiz", urlPatterns = "/admin/updateQuiz")
public class UpdateQuizServlet extends HttpServlet {
    QuizDao quizDao;

    public UpdateQuizServlet() {
        quizDao = new QuizDao();
    }

    private final ObjectMapper objectMapper = new ObjectMapper();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String quizId = req.getParameter("id");
        String requestData = req.getReader().lines().collect(Collectors.joining());
        QuizRequest quizRequest = objectMapper.readValue(requestData, QuizRequest.class);
        Quiz quiz = quizDao.findQuizById(quizRequest.getId());
        if (quiz != null) {
            quizDao.updateQuiz(quizRequest.getTitle(), quizRequest.getImageUrl(), quizRequest.getId());
        } else {
            throw new EntityNotFoundException("Quiz with id " + quizId + " is not found.");
        }
    }
}
