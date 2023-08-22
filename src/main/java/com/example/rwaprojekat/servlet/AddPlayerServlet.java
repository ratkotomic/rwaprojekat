package com.example.rwaprojekat.servlet;

import com.example.rwaprojekat.dao.GameDao;
import com.example.rwaprojekat.dao.PlayerDao;
import com.example.rwaprojekat.model.Player;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "/AddPlayer", urlPatterns = "/addPlayer")
public class AddPlayerServlet extends HttpServlet {
    PlayerDao playerDao;
    GameDao gameDao;

    public AddPlayerServlet() {
        playerDao = new PlayerDao();
        gameDao = new GameDao();
    }

    private final ObjectMapper objectMapper = new ObjectMapper();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pin = req.getParameter("pin");
        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");

        Player player = new Player();
        player.setFirstName(firstName);
        player.setLastName(lastName);
        player.setGame(gameDao.findGameByPin(pin));
        player.setPoints(0);

        playerDao.createPlayer(player);
        resp.setContentType("application/json");
        String jsonResponse = objectMapper.writeValueAsString(player);
        resp.getWriter().write(jsonResponse);
    }
}
