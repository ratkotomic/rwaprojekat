package com.example.rwaprojekat.servlet;

import com.example.rwaprojekat.dao.AnswerDao;
import com.example.rwaprojekat.dao.QuestionDao;
import com.example.rwaprojekat.dto.AnswerRequest;
import com.example.rwaprojekat.dto.QuestionRequest;
import com.example.rwaprojekat.model.Answer;
import com.example.rwaprojekat.model.Question;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.persistence.EntityNotFoundException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "/UpdateQuestion", urlPatterns = "/updateQuestion")
public class UpdateQuestionServlet extends HttpServlet {
    QuestionDao questionDao;
    AnswerDao answerDao;

    public UpdateQuestionServlet() {
        questionDao = new QuestionDao();
        answerDao = new AnswerDao();
    }
    private final ObjectMapper objectMapper = new ObjectMapper();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String questionId = req.getParameter("id");
        String requestData = req.getReader().lines().collect(Collectors.joining());
        QuestionRequest questionRequest = objectMapper.readValue(requestData, QuestionRequest.class);

        Question question = questionDao.findQuestionById(questionId);

        if (question != null) {
            answerDao.removeAnswersByQuestionId(questionId);
            List<AnswerRequest>answerRequests = questionRequest.getAnswerRequests();
            answerRequests.forEach(answerRequest -> {
                Answer answer = new Answer();
                answer.setAnswerText(answerRequest.getText());
                answer.setCorrect(answerRequest.isCorrect());
                answer.setQuestion(question);
                answerDao.createAnswer(answer);
            });
            questionDao.updateQuestion(questionRequest.getText(),questionRequest.getPoints(),questionRequest.getTimeToAnswer(),questionId);
        } else {
            throw new EntityNotFoundException("Quiz with id " + questionId + " is not found.");
        }
    }
}
