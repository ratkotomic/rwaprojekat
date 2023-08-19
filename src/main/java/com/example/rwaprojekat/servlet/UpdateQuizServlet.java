package com.example.rwaprojekat.servlet;

import com.example.rwaprojekat.dao.AnswerDao;
import com.example.rwaprojekat.dao.QuestionDao;
import com.example.rwaprojekat.dao.QuizDao;
import com.example.rwaprojekat.dto.AnswerRequest;
import com.example.rwaprojekat.dto.QuestionRequest;
import com.example.rwaprojekat.dto.QuizRequest;
import com.example.rwaprojekat.model.Answer;
import com.example.rwaprojekat.model.Question;
import com.example.rwaprojekat.model.Quiz;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.persistence.EntityNotFoundException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "/UpdateQuiz", urlPatterns = "/admin/updateQuiz")
public class UpdateQuizServlet extends HttpServlet {
    QuizDao quizDao;
    QuestionDao questionDao;
    AnswerDao answerDao;

    public UpdateQuizServlet() {
        quizDao = new QuizDao();
        questionDao = new QuestionDao();
        answerDao = new AnswerDao();
    }

    private final ObjectMapper objectMapper = new ObjectMapper();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String quizId = req.getParameter("id");
        String requestData = req.getReader().lines().collect(Collectors.joining());
        QuizRequest quizRequest = objectMapper.readValue(requestData, QuizRequest.class);
        Quiz quiz = quizDao.findQuizById(quizRequest.getId());
        if (quiz != null) {
            List<Question> oldQuestions = quiz.getQuestions();
            List<Question> newQuestions = mapToQuestions(quizRequest.getQuestions());
            List<Question> questionsToRemove = oldQuestions.stream()
                    .filter(oldQuestion -> !newQuestions.contains(oldQuestion))
                    .collect(Collectors.toList());
            questionsToRemove.forEach(question -> questionDao.deleteQuestion(question.getId()));

            List<Question> newQuestionsToAdd = newQuestions.stream()
                    .filter(newQuestion -> !oldQuestions.contains(newQuestion))
                    .collect(Collectors.toList());

            newQuestionsToAdd.forEach(question -> {
                Question questionForAdd = new Question();
                questionForAdd.setQuiz(quiz);
                questionForAdd.setQuestionText(question.getQuestionText());
                questionForAdd.setTimeToAnswer(question.getTimeToAnswer());
                questionForAdd.setPoints(question.getPoints());
                questionDao.createQuestion(questionForAdd);

                question.getAnswers().forEach(answerRequest -> {
                    Answer answer = new Answer();
                    answer.setAnswerText(answerRequest.getAnswerText());
                    answer.setCorrect(answerRequest.isCorrect());
                    answer.setQuestion(questionForAdd);
                    answerDao.createAnswer(answer);
                });
            });

            List<Question> commonQuestions = new ArrayList<>(oldQuestions);
            commonQuestions.retainAll(newQuestions);

            commonQuestions.forEach(editQuestion -> {
                answerDao.removeAnswersByQuestionId(editQuestion.getId());
                editQuestion.getAnswers().forEach(answer -> {
                    Answer answer1 = new Answer();
                    answer1.setAnswerText(answer.getAnswerText());
                    answer1.setCorrect(answer.isCorrect());
                    answer1.setQuestion(editQuestion);
                    answerDao.createAnswer(answer1);
                });
                questionDao.updateQuestion(editQuestion.getQuestionText(), editQuestion.getPoints(), editQuestion.getTimeToAnswer(), editQuestion.getId());

            });
            quizDao.updateQuiz(quizRequest.getTitle(), quizRequest.getImageUrl(), quizRequest.getId());
        } else {
            throw new EntityNotFoundException("Quiz with id " + quizId + " is not found.");
        }
    }

    public static Question mapToQuestion(QuestionRequest questionRequest) {
        Question question = new Question();
        question.setQuestionText(questionRequest.getText());
        question.setTimeToAnswer(questionRequest.getTimeToAnswer());
        question.setPoints(questionRequest.getPoints());

        List<Answer> answers = new ArrayList<>();
        if (questionRequest.getAnswerRequests() != null) {
            for (AnswerRequest answerRequest : questionRequest.getAnswerRequests()) {
                Answer answer = new Answer();
                answer.setAnswerText(answerRequest.getText());
                answer.setCorrect(answerRequest.isCorrect());
                answer.setQuestion(question);

                answers.add(answer);
            }
        }
        question.setAnswers(answers);

        return question;
    }

    public static List<Question> mapToQuestions(List<QuestionRequest> questionRequests) {
        List<Question> questions = new ArrayList<>();
        for (QuestionRequest questionRequest : questionRequests) {
            Question question = mapToQuestion(questionRequest);
            questions.add(question);
        }
        return questions;
    }
}
