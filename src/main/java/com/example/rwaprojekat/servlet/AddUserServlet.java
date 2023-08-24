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

@WebServlet(name = "/AddUser", urlPatterns = "/admin/addUser")
public class AddUserServlet extends HttpServlet {
    UserDao userDao;

    public AddUserServlet() {
        userDao = new UserDao();
    }

    private final ObjectMapper objectMapper = new ObjectMapper();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userName = req.getParameter("username");
        String password = req.getParameter("password");
        String role = req.getParameter("role");

        if (userName.isEmpty() || password.isEmpty() || role.isEmpty()) {
        } else {
            User existingUser = userDao.findByUsername(userName);
            if (existingUser != null) {
                JsonObject errorJson = new JsonObject();
                errorJson.addProperty("error", "Korisnik sa usernameom " + existingUser.getUsername() + " već postoji.");
                resp.setContentType("application/json");
                resp.getWriter().write(errorJson.toString());
            } else {
                User user = userDao.createUser(new User(userName, password, role));
                resp.setContentType("application/json");
                String jsonResponse = objectMapper.writeValueAsString(user);
                resp.getWriter().write(jsonResponse);
            }
        }
    }
}
