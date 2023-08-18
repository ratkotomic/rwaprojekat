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

@WebServlet(name = "/Login", urlPatterns = "/login")
public class LoginServlet extends HttpServlet {

    RequestDispatcher dispatcher = null;
    UserDao userDao;

    public LoginServlet() {
        userDao = new UserDao();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        dispatcher = req.getRequestDispatcher("/Authorization/login.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userName = req.getParameter("username");
        String password = req.getParameter("password");

        if (userName.isEmpty() || password.isEmpty()) {
            req.setAttribute("errorMessage", "Jedno od polja je prazno!");
            dispatcher = req.getRequestDispatcher("/Authorization/login.jsp");
            dispatcher.forward(req, resp);
        } else {
            User user = userDao.getUser(userName, password);

            if (user == null) {
                req.setAttribute("errorMessage", "Login nije uspio!");
                dispatcher = req.getRequestDispatcher("/Authorization/login.jsp");
                dispatcher.forward(req, resp);
            } else {
                if (user.getRole().equals("admin")) {
                    req.getSession().setAttribute("user", user);
                    //prebaciti ga na admin stranu
                    resp.sendRedirect("admin/home");
                } else if(user.getRole().equals("super-admin")){
                    req.getSession().setAttribute("user", user);
//                  //prebaciti ga na super admin stranu
                    resp.sendRedirect("admin/home");
                }
                else {
                    req.getSession().setAttribute("user", user);
                    //prebaciti ga na user stranu
                    System.out.println("user");
                }
            }
        }
    }
}
