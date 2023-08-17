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
import java.util.List;

@WebServlet(name = "/GetQuizzes", urlPatterns = "/getQuizzes")
public class GetAllQuizzesServlet extends HttpServlet {
    QuizDao quizDao;

    public GetAllQuizzesServlet() {
        quizDao = new QuizDao();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        List<Quiz> quizzes = quizDao.findAllQuizzes();
        PrintWriter out = resp.getWriter();
        for (Quiz quiz : quizzes) {
            out.print("<tr>"
                    + "<td>"
                    + "<div align='center' class='text'>" + quiz.getTitle() + "</div>"
                    + "</td>");

        }
        out.close();
    }
}
