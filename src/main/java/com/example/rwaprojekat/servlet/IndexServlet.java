package com.example.rwaprojekat.servlet;

import com.example.rwaprojekat.dao.UserDao;
import com.example.rwaprojekat.model.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "/Index", urlPatterns = "/index")
public class IndexServlet extends HttpServlet {

    RequestDispatcher dispatcher = null;

    public IndexServlet() {
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        dispatcher = req.getRequestDispatcher("/index.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pin = req.getParameter("pin");

        if (pin.isEmpty()) {
            req.setAttribute("errorMessage", "Pin je prazan prazno!");
            dispatcher = req.getRequestDispatcher("/Authorization/login.jsp");
            dispatcher.forward(req, resp);
        }
    }
}
