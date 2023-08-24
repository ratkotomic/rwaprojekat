package com.example.rwaprojekat.servlet;

import com.example.rwaprojekat.dao.GameDao;
import com.example.rwaprojekat.dao.PlayerDao;
import com.example.rwaprojekat.model.Game;
import com.example.rwaprojekat.model.Player;
import com.example.rwaprojekat.model.Question;
import jakarta.websocket.OnClose;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;
import org.apache.http.NameValuePair;
import org.apache.http.client.utils.URLEncodedUtils;

import java.io.IOException;
import java.net.URI;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@ServerEndpoint(
        value = "/chatServer")
public class ChatServer {
    private final static ArrayList<Session> sessions = new ArrayList<>();

    @OnOpen
    public void onOpen(Session session) {
        sessions.add(session);
    }



    @OnMessage
    public void sendMessageToAll(String message, Session session) {
        for(int i = 0; i < sessions.size(); ++i) {
            try {
                sessions.get(i).getBasicRemote().sendText(message);
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }
    }

    @OnClose
    public void onClose(Session session) {
        sessions.remove(session);

    }
}
