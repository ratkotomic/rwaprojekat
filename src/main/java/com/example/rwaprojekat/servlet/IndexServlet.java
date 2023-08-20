package com.example.rwaprojekat.servlet;

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

        if (pin == null || pin.isEmpty()) {
            req.setAttribute("errorMessage", "Polje za pin je prazno!");
            dispatcher = req.getRequestDispatcher("/index.jsp");
            dispatcher.forward(req, resp);
        } else if (pin.equals("123")) {
            resp.sendRedirect("o_vama.jsp");
        } else {
            req.setAttribute("errorMessage", "Pogrešan PIN!");
            dispatcher = req.getRequestDispatcher("/index.jsp");
            dispatcher.forward(req, resp);
        }
    }
}
