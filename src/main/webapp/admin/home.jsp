<%@ page import="com.example.rwaprojekat.model.User" %>
<%@ page import="com.example.rwaprojekat.model.Quiz" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 8/17/2023
  Time: 9:45 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../styles.css">
    <link rel="stylesheet" href="../reset.css">
    <link rel="stylesheet" href="../Admin/home.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.cyan-deep_orange.min.css" />
</head>
<body>

<%
    User user = (User)request.getSession().getAttribute("user");
    String userRole = user.getRole();
%>

<div class="mdl-layout mdl-js-layout">

    <header class="mdl-layout__header">
        <div class="mdl-layout-icon"></div>
        <div class="mdl-layout__header-row">
            <span class="mdl-layout__title tc-black fw-bold">Admin Panel</span>
            <div class="mdl-layout-spacer"></div>
            <nav class="mdl-navigation">
                <a class="mdl-navigation__link tc-black fw-bold" href="admin/home">Kvizovi</a>

                <%
                    if(userRole.equals("super admin"))
                    {
                        %>

                            <a class="mdl-navigation__link tc-black fw-bold" href="admin/users">Korisnici</a>

                        <%
                    }
                %>

                <a class="mdl-navigation__link tc-black fw-bold" href="admin">Log out</a>
            </nav>
        </div>
    </header>

    <div class="mdl-layout__drawer">
        <span class="mdl-layout__title  tc-black fw-bold">Admin Panel</span>
        <nav class="mdl-navigation">
            <a class="mdl-navigation__link  tc-black fw-bold" href="admin/home">Kvizovi</a>
            <%
                if(userRole.equals("super admin"))
                {
            %>
               <a class="mdl-navigation__link  tc-black fw-bold" href="admin/users">Korisnici</a>
            <%
                }
            %>
            <a class="mdl-navigation__link  tc-black fw-bold" href="admin">Log out</a>
        </nav>
    </div>

    <main class="mdl-layout__content p-3">

        <h1 class="mb-3">Kvizovi</h1>
        <div class="quizzes-container flex flex-row flex-wrap gap-2">
            <%

                List<Quiz> quizList = (List<Quiz>)request.getAttribute("quizList");

                for (Quiz quiz : quizList)
                {
            %>
            <div class="quiz-container flex flex-column flex-center gap-1 p-2">
                <h2><%= quiz.getTitle() %></h2>
                <img src="<%= quiz.getImageUrl() %>">
                <button class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored tc-primary-button w-100">
                Edit
                </button>
                <button class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored tc-primary-button w-100">
                    Započni
                </button>

            </div>

            <%
                }

            %>
        </div>
    </main>
</div>

</body>


<script defer src="https://code.getmdl.io/1.3.0/material.min.js"></script>

</html>
