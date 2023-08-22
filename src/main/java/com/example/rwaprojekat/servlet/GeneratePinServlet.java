package com.example.rwaprojekat.servlet;

import com.example.rwaprojekat.dao.GameDao;
import com.example.rwaprojekat.dao.QuizDao;
import com.example.rwaprojekat.dao.UserDao;
import com.example.rwaprojekat.model.Game;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Random;

@WebServlet(name = "/GeneratePin", urlPatterns = "/admin/generatePin")
public class GeneratePinServlet extends HttpServlet {
    GameDao gameDao;
    QuizDao quizDao;
    UserDao userDao;

    public GeneratePinServlet() {
        gameDao = new GameDao();
        quizDao = new QuizDao();
        userDao = new UserDao();
    }

    private final ObjectMapper objectMapper = new ObjectMapper();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String quizId = req.getParameter("quizId");
        String userId = req.getParameter("userId");
        String pin = generatePin();

        Game game = new Game();
        game.setPin(pin);
        game.setQuiz(quizDao.findQuizById(quizId));
        game.setCreator(userDao.findByUserId(userId));
        game.setStatus("waiting");

        Game newGame = gameDao.createGame(game);
        resp.setContentType("application/json");
        String jsonResponse = objectMapper.writeValueAsString(newGame);
        resp.getWriter().write(jsonResponse);
    }

    public static String generatePin() {
        Random random = new Random();
        int pinNumber = random.nextInt(1000000);
        return String.format("%06d", pinNumber);
    }

}

