package com.example.rwaprojekat.servlet;

import com.example.rwaprojekat.dao.QuizDao;
import com.example.rwaprojekat.model.Message;
import com.example.rwaprojekat.model.Question;
import com.example.rwaprojekat.model.Quiz;
import jakarta.websocket.*;
import jakarta.websocket.server.ServerEndpoint;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


@ServerEndpoint(
        value = "/quiz")
public class QuizServer {
    private final static ArrayList<Session> sessions = new ArrayList<>();
    private Quiz quiz;
    @OnOpen
    public void onOpen(Session session) {
        sessions.add(session);
        try{
            session.getBasicRemote().sendText("402881838a143fbf018a145a4113003e");
        } catch (Exception ex) {
            throw new RuntimeException(ex);
        }

        handleTextMessage("users" + sessions.size());
    }



    @OnMessage
    public String handleTextMessage(String message) {

        sessions.forEach(s -> {
            try {
                s.getBasicRemote().sendText(message);
            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        });
        return message;
    }

    public Quiz sendQuizToClient(Quiz quiz, Session session)
    {
        try {
            session.getBasicRemote().sendObject(quiz);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return quiz;
    }

    @OnClose
    public void onClose(Session session) throws IOException {
        sessions.remove(session);
        System.out.println("Session removed: " + session.getId());
    }
}
