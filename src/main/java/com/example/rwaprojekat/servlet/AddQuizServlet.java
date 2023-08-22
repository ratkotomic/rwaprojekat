package com.example.rwaprojekat.servlet;

import com.example.rwaprojekat.dao.AnswerDao;
import com.example.rwaprojekat.dao.QuestionDao;
import com.example.rwaprojekat.dao.QuizDao;
import com.example.rwaprojekat.dao.UserDao;
import com.example.rwaprojekat.dto.AnswerRequest;
import com.example.rwaprojekat.dto.QuestionRequest;
import com.example.rwaprojekat.dto.QuizRequest;
import com.example.rwaprojekat.model.Answer;
import com.example.rwaprojekat.model.Question;
import com.example.rwaprojekat.model.Quiz;
import com.example.rwaprojekat.model.User;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "/AddQuiz", urlPatterns = "/admin/addQuiz")
public class AddQuizServlet extends HttpServlet {
    UserDao userDao;
    QuizDao quizDao;
    QuestionDao questionDao;
    AnswerDao answerDao;

    public AddQuizServlet() {
        userDao = new UserDao();
        quizDao = new QuizDao();
        questionDao = new QuestionDao();
        answerDao = new AnswerDao();
    }

    private final ObjectMapper objectMapper = new ObjectMapper();


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String requestData = req.getReader().lines().collect(Collectors.joining());

        QuizRequest quizRequest = objectMapper.readValue(requestData, QuizRequest.class);

        User user = (User) req.getSession().getAttribute("user");

        Quiz quiz = new Quiz();
        quiz.setTitle(quizRequest.getTitle());
        quiz.setImageUrl(quizRequest.getImageUrl());
        quiz.setOwner(user);
        Quiz createdQuiz = quizDao.createQuiz(quiz);

        List<QuestionRequest> questionRequests = quizRequest.getQuestions();
        questionRequests.forEach(questionRequest -> {
            List<AnswerRequest> answerRequests = questionRequest.getAnswerRequests();
            Question question = new Question();
            question.setQuestionText(questionRequest.getText());
            question.setPoints(questionRequest.getPoints());
            question.setTimeToAnswer(questionRequest.getTimeToAnswer());
            question.setQuestionNumber(questionRequest.getQuestionNumber());
            question.setQuiz(quiz);
            questionDao.createQuestion(question);

            answerRequests.forEach(answerRequest -> {
                Answer answer = new Answer();
                answer.setAnswerText(answerRequest.getText());
                answer.setCorrect(answerRequest.isCorrect());
                answer.setQuestion(question);
                answerDao.createAnswer(answer);
            });
        });
        resp.setContentType("application/json");
        String jsonResponse = objectMapper.writeValueAsString(createdQuiz);
        resp.getWriter().write(jsonResponse);
    }
}
