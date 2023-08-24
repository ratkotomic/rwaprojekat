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

@WebServlet(name = "/Register", urlPatterns = "/register")
public class RegisterServlet extends HttpServlet {

    RequestDispatcher dispatcher = null;
    UserDao userDao;

    public RegisterServlet() {
        userDao = new UserDao();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User)req.getSession().getAttribute("user");
        if(user != null){
            resp.sendRedirect("admin/home");
            return;
        }
        dispatcher = req.getRequestDispatcher("/Authorization/register.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String userName = req.getParameter("username");
        String password = req.getParameter("password");

        if (userName.isEmpty() || password.isEmpty()) {
            req.setAttribute("errorMessage", "Jedno od polja je prazno!");
            dispatcher = req.getRequestDispatcher("/Authorization/register.jsp");
            dispatcher.forward(req, resp);
        }


    }
}
