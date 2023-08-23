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
        value = "/quizServer")
public class QuizServer {
    private final static Map<String, ArrayList<Session>> sessions = new HashMap<>();
    private int currentQuestion = 0;
    @OnOpen
    public void onOpen(Session session) {

        URI url = session.getRequestURI();
        List<NameValuePair> params = URLEncodedUtils.parse(url, Charset.defaultCharset());

        // the first param is always pin
        String pin = params.get(0).getValue();
        GameDao gameDao = new GameDao();
        Game game = gameDao.findGameByPin(pin);


        // first we need to check if this game even exists

        if(game == null)
        {
            try{
                session.getBasicRemote().sendText("no-game");
            }
            catch(Exception ex)
            {
                ex.printStackTrace();
            }
            return;
        }

        if(!game.getStatus().equals("waiting"))
        {
            try{
                session.getBasicRemote().sendText("no-join");
            }
            catch(Exception ex)
            {
                ex.printStackTrace();
            }
            return;
        }

        if(params.size() > 1)
        {
            String name = params.get(1).getValue();
            String lastname = params.get(2).getValue();

            PlayerDao playerDao = new PlayerDao();
            Player player = new Player();
            player.setFirstName(name);
            player.setLastName(lastname);
            player.setGame(game);
            player.setPoints(0);

            Player result = playerDao.createPlayer(player);
                Map<String, Object> userProperties = session.getUserProperties();
                userProperties.put("player",  result);

        }

        if(!sessions.containsKey(pin))
        {
            sessions.put(pin, new ArrayList<>());
        }
        ArrayList<Session> list = sessions.get(pin);


        list.add(session);
        try{
            session.getBasicRemote().sendText(game.getQuiz().getId());
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }

        for(int i = 0; i < list.size(); ++i)
        {
            try{
                list.get(i).getBasicRemote().sendText("users: " + (list.size()-1));
            }
            catch(Exception ex)
            {
                ex.printStackTrace();
            }
        }
    }



    @OnMessage
    public void sendMessageToAll(String message, Session session) {

        URI url = session.getRequestURI();
        List<NameValuePair> params = URLEncodedUtils.parse(url, Charset.defaultCharset());

        String pin = params.get(0).getValue();
        GameDao gameDao = new GameDao();
        Game game = gameDao.findGameByPin(pin);

        PlayerDao playerDao = new PlayerDao();

        if(game == null)
        {
            try{
                session.getBasicRemote().sendText("no-game");
            }
            catch(Exception ex)
            {
                ex.printStackTrace();
            }
            return;
        }

        if(game.getStatus().equals("finished"))
        {
            try{
                session.getBasicRemote().sendText("game-finished");
            }
            catch(Exception ex)
            {
                ex.printStackTrace();
            }
            return;
        }

        if(message.contains("user-was-correct"))
        {
            Map<String, Object> userProperties = session.getUserProperties();
            Player player = (Player)userProperties.get("player");
            Question question = game.getQuiz().getQuestions().get(currentQuestion);
            player.setPoints(player.getPoints() + question.getPoints());
            playerDao.updatePlayerPoints(player.getId(), player.getPoints());
            userProperties.put("player", player);

        }

        if(message.contains("quiz-end"))
        {
            gameDao.updateStatus(pin, "finished");
        }

        if(message.contains("quiz-start"))
        {
            gameDao.updateStatus(pin, "playing");
        }

        if(message.contains("next-question")){
            currentQuestion++;
        }

        ArrayList<Session> list = sessions.get(pin);
        for(int i = 0; i < list.size(); ++i)
        {
            try{
                list.get(i).getBasicRemote().sendText(message);
            }
            catch(Exception ex)
            {
                ex.printStackTrace();
            }
        }



    }


    /* todo */
    /* have to figure out when this gets called and how to update users on client */
    @OnClose
    public void onClose(Session session) throws IOException {
        String pin = session.getQueryString();
        pin = pin.replace("pin=", "");

        GameDao gameDao = new GameDao();
        Game game = gameDao.findGameByPin(pin);

        if(!sessions.containsKey(pin))
        {
            return;
        }
        ArrayList<Session> list = sessions.get(pin);

        list.remove(session);

        for(int i = 0; i < list.size(); ++i)
        {
            try{
                list.get(i).getBasicRemote().sendText("users: " + (list.size()-1));
            }
            catch(Exception ex)
            {
                ex.printStackTrace();
            }
        }
    }
}
