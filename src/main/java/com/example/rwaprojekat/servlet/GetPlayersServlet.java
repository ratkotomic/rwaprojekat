package com.example.rwaprojekat.servlet;

import com.example.rwaprojekat.dao.PlayerDao;
import com.example.rwaprojekat.model.Player;
import com.example.rwaprojekat.model.Question;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Comparator;
import java.util.List;

@WebServlet(name = "/GetPlayers", urlPatterns = "/getPlayers")
public class GetPlayersServlet extends HttpServlet {
    PlayerDao playerDao;

    public GetPlayersServlet() {
        playerDao = new PlayerDao();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        String pin = req.getParameter("pin");
        List<Player> players = playerDao.getPlayersByQuizPin(pin);
        players.sort(Comparator.comparingInt(Player::getPoints));

        ObjectMapper objectMapper = new ObjectMapper();
        String playersJson = objectMapper.writeValueAsString(players);

        resp.getWriter().write(playersJson);
    }
}
