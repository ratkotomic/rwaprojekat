package com.example.rwaprojekat.servlet;

import com.example.rwaprojekat.dao.QuizDao;
import com.example.rwaprojekat.decoders.*;
import com.example.rwaprojekat.model.Question;
import com.example.rwaprojekat.model.Quiz;
import jakarta.websocket.EncodeException;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;

import java.io.IOException;
import java.util.List;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;


@ServerEndpoint(
        value = "/quiz",
        decoders = QuestionDecoder.class,
        encoders = QuestionEncoder.class )
public class QuizServer {
    private final static Set<Session> sessions =  new CopyOnWriteArraySet<Session>();
    private Quiz quiz;
    private int currQuestion = 0;
    @OnOpen
    public void onOpen(
            Session session) throws IOException {
        sessions.add(session);
        QuizDao quizDao = new QuizDao();
        quiz = quizDao.findQuizById("402881838a143fbf018a145a4113003e");
    }

    @OnMessage
    public Question handleNextQuestion(String message)
    {
        List<Question> questions = quiz.getQuestions();
        Question question = questions.get(currQuestion);
        sessions.forEach(s -> {
            try {
                s.getBasicRemote().sendObject(question);
            } catch (IOException | EncodeException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        });
        currQuestion++;
        return question;

    }
}
