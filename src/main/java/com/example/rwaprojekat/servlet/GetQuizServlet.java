package com.example.rwaprojekat.servlet;

import com.example.rwaprojekat.dao.QuizDao;
import com.example.rwaprojekat.model.Quiz;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "/GetQuiz", urlPatterns = "/getQuiz")
public class GetQuizServlet extends HttpServlet {
    QuizDao quizDao;

    public GetQuizServlet() {
        quizDao = new QuizDao();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        String quizId = req.getParameter("id");
        Quiz quiz = quizDao.findQuizById(quizId);
        PrintWriter out = resp.getWriter();
        out.print("<tr>"
                + "<td>"
                + "<div align='center' class='text'>" + quiz.getTitle() + "</div>"
                + "</td>");
        out.close();
    }
}
