package com.example.rwaprojekat.servlet;

import com.example.rwaprojekat.dao.UserDao;
import com.example.rwaprojekat.model.User;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "/DeleteUser", urlPatterns = "/admin/deleteUser")
public class DeleteUserServlet extends HttpServlet {
    UserDao userDao;

    public DeleteUserServlet() {
        userDao = new UserDao();
    }

    JsonObject responseJson = new JsonObject();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");

        User user1 = userDao.findByUserId(req.getParameter("id"));

        if (user.getUsername().equals(user1.getUsername())) {
            responseJson.addProperty("error", "Ne mozete obrisati samog sebe.");
        } else {
            userDao.deleteUser(req.getParameter("id"));
            responseJson.addProperty("message", "Brisanje uspijesno.");
        }
        resp.setContentType("application/json");
        resp.getWriter().write(responseJson.toString());
    }
}
