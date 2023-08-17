package com.example.rwaprojekat.servlet;

import com.example.rwaprojekat.dao.QuestionDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "/DeleteQuestion", urlPatterns = "/deleteQuestion")
public class DeleteQuestionServlet extends HttpServlet {
    QuestionDao questionDao;

    public DeleteQuestionServlet() {
        questionDao = new QuestionDao();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        questionDao.deleteQuestion(req.getParameter("id"));
    }
}
