package com.example.rwaprojekat.servlet;

import com.example.rwaprojekat.dao.GameDao;
import com.example.rwaprojekat.model.Game;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "/updateGameStatus", urlPatterns = "/updateGameStatus")
public class UpdateGameStatusServlet extends HttpServlet {
    GameDao gameDao;

    public UpdateGameStatusServlet() {
        gameDao = new GameDao();
    }

    private final ObjectMapper objectMapper = new ObjectMapper();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String status = req.getParameter("status");
        String pin = req.getParameter("pin");
        Game game = gameDao.findGameByPin(pin);
        game.setStatus(status);
        gameDao.updateStatus(pin, status);
        resp.setContentType("application/json");
        String jsonResponse = objectMapper.writeValueAsString(game);
        resp.getWriter().write(jsonResponse);
    }
}
