package com.example.rwaprojekat.servlet;

import com.example.rwaprojekat.dao.UserDao;
import com.example.rwaprojekat.model.User;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "/UpdateUser", urlPatterns = "/admin/updateUser")
public class UpdateUserServlet extends HttpServlet {
    UserDao userDao;

    public UpdateUserServlet() {
        userDao = new UserDao();
    }

    private final ObjectMapper objectMapper = new ObjectMapper();


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId = req.getParameter("id");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String role = req.getParameter("role");

        JsonObject responseJson = new JsonObject();

        if (username.isEmpty() || password.isEmpty() || role.isEmpty()) {
        } else {
            User user = userDao.findByUserId(userId);
            if (!username.equals(user.getUsername())) {
                User temp = userDao.findByUsername(username);
                if (temp != null) {
                    responseJson.addProperty("error", "Korisnik sa usernameom" + username + " već postoji.");
                } else {
                    userDao.updateUser(userId, username, password, role);
                    responseJson.addProperty("message", "Uspješno ažurirano.");

                }
            } else {
                userDao.updateUser(userId, username, password, role);
                responseJson.addProperty("message", "Uspješno ažurirano.");
            }
        }
        resp.setContentType("application/json");
        resp.getWriter().write(responseJson.toString());
    }
}
