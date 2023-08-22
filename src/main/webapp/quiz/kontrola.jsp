<%@ page import="com.example.rwaprojekat.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Kontrola</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="../styles.css">
  <link rel="stylesheet" href="../reset.css">
  <link rel="stylesheet" href="../admin/home.css">
  <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
  <link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.cyan-deep_orange.min.css"/>
</head>
<body>

<%
  User user = (User) request.getSession().getAttribute("user");
  String userRole = user.getRole();
%>
<div class="mdl-layout mdl-js-layout">

  <header class="mdl-layout__header">
    <div class="mdl-layout-icon"></div>
    <div class="mdl-layout__header-row">
      <span class="mdl-layout__title tc-black fw-bold">Admin Panel</span>
      <div class="mdl-layout-spacer"></div>
      <nav class="mdl-navigation">
        <a class="mdl-navigation__link tc-black fw-bold" href="#quizzes">Kvizovi</a>

        <%
          if (userRole.equals("super-admin")) {
        %>

        <a class="mdl-navigation__link tc-black fw-bold" href="#users">Korisnici</a>

        <%
          }
        %>
        <a class=" tc-black fw-bold" href="/rwaprojekat/admin/logout">
          <button class="mdl-button mdl-js-button mdl-button--raised">Log out</button>
        </a>
      </nav>
    </div>
  </header>

  <div class="mdl-layout__drawer">
    <span class="mdl-layout__title  tc-black fw-bold">Admin Panel</span>
    <nav class="mdl-navigation">
      <a class="mdl-navigation__link  tc-black fw-bold" href="#quizzes">Kvizovi</a>
      <%
        if (userRole.equals("super-admin")) {
      %>
      <a class="mdl-navigation__link  tc-black fw-bold" href="#users">Korisnici</a>
      <%
        }
      %>
      <a class=" tc-black fw-bold" href="/rwaprojekat/admin/logout">
        <button class="mdl-button mdl-js-button mdl-button--raised" style="margin-left: 40px; margin-top: 5px">
          Log out
        </button>
      </a>
    </nav>
  </div>
</div>

</body>
</html>
