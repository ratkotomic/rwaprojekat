package com.example.rwaprojekat.servlet;

import com.example.rwaprojekat.dao.PlayerDao;
import com.example.rwaprojekat.model.Player;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "/UpdatePlayer", urlPatterns = "/updatePlayer")
public class UpdatePlayerServlet extends HttpServlet {
    PlayerDao playerDao;

    public UpdatePlayerServlet() {
        playerDao = new PlayerDao();
    }

    private final ObjectMapper objectMapper = new ObjectMapper();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int points = Integer.parseInt(req.getParameter("points"));
        String playerId = req.getParameter("playerId");

        Player player = playerDao.findById(playerId);
        player.setPoints(player.getPoints() + points);

        playerDao.updatePlayerPoints(player.getId(), player.getPoints());
        resp.setContentType("application/json");
        String jsonResponse = objectMapper.writeValueAsString(player);
        resp.getWriter().write(jsonResponse);
    }
}
