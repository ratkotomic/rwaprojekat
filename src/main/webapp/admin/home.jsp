<%@ page import="com.example.rwaprojekat.model.User" %>
<%@ page import="com.example.rwaprojekat.model.Quiz" %>
<%@ page import="java.util.List" %>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %><%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 8/17/2023
  Time: 9:45 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin Panel - QuizTopia</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../styles.css">
    <link rel="stylesheet" href="../reset.css">
    <link rel="stylesheet" href="home.css">
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
                <!-- todo
                why does this not work?
                <a  class="mdl-navigation__link tc-black fw-bold" href="../">Nazad</a>
                -->
                <a class="mdl-navigation__link tc-black fw-bold" href="#quizzes">Kvizovi</a>

                <%
                    if (userRole.equals("super-admin")) {
                %>

                <a class="mdl-navigation__link tc-black fw-bold" href="#users">Korisnici</a>

                <%
                    }
                %>

                <a class=" tc-black fw-bold" href="logout">
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
            <a class=" tc-black fw-bold" href="logout">
                <button class="mdl-button mdl-js-button mdl-button--raised" style="margin-left: 40px; margin-top: 5px">
                    Log out
                </button>
            </a>
        </nav>
    </div>

    <main id="quizzes" class="tab-content mdl-layout__content p-3">

        <h1 class="mb-1">Kvizovi</h1>

        <button type="button" id="new-quiz-button" owner-id="<%= user.getId() %>"
                class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored tc-primary-button mb-2">
            Novi kviz
        </button>


        <!-- ALL QUIZZES -->


        <!-- very careful changing this quiz-container and all it's children
        there is a part of code that creates this entire container using this html as a template
        so if you change this change the javascript as well -->

        <div class="quizzes-container flex flex-row flex-wrap gap-2">
            <%

                List<Quiz> quizList = (List<Quiz>) request.getAttribute("quizList");

                for (Quiz quiz : quizList) {
            %>

            <div class="quiz-container flex flex-column gap-1 p-2 mt-2" data-id="<%= quiz.getId()%>"
                 creator="<%= quiz.getOwner().getId()%>">
                <h2 class="title"><%= quiz.getTitle() %>
                </h2>
                <img class="image-url" src="<%= quiz.getImageUrl() %>">

                <button type="button"
                        class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored tc-primary-button w-100 edit-quiz-button">
                    Edit
                </button>

                <button type="button"
                        class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored tc-primary-button w-100 start-quiz-button">
                    Započni
                </button>

            </div>

            <%
                }
            %>
        </div>
    </main>
    <main id="users" class="tab-content mdl-layout__content p-3">
        <!-- NEW USER -->
        <h1 class="mb-1">Useri</h1>
        <button type="button" id="new-user-button"
                class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored tc-primary-button mb-2">
            Novi korisnik
        </button>

        <div class="users-container flex flex-row flex-wrap gap-2 mt-2">
            <%

                List<User> userList = (List<User>) request.getAttribute("userList");

                for (User user1 : userList) {
            %>
            <div class="user-container flex flex-column flex-center gap-1 p-2" id="<%= user1.getId()%>"
                 username="<%= user1.getUsername()%>">
                <h5 class="username">Username: <%= user1.getUsername() %>
                </h5>
                <h5 class="password">Password: <%= user1.getPassword() %>
                </h5>
                <h5 class="role">Role: <%= user1.getRole() %>
                </h5>
                <button type="button"
                        class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored tc-primary-button w-100 edit-user-button">
                    Edit
                </button>
            </div>
            <%
                }
            %>
        </div>
    </main>
</div>

<!-- USER DIALOG-->
<dialog id="new-user-dialog" class="mdl-dialog">
    <h3 class="mdl-dialog__title text-center">Novi korisnik</h3>

    <div class="mdl-dialog__content flex flex-column flex-center gap-3">

        <div class="w-100 mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
            <label class="mdl-textfield__label">Korisnicko ime</label>
            <input class="mdl-textfield__input username" type="text">
        </div>

        <div class="w-100 mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
            <label class="mdl-textfield__label">Sifra</label>
            <input class="mdl-textfield__input password" type="text" pattern=".{8,}">
            <span class="mdl-textfield__error"> Šifra mora biti minimalno 8 karaktera! </span>
        </div>

        <div class="w-100 mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
            <label class="mdl-textfield__label">Uloga</label>
            <select class="mdl-textfield__input role" id="role-select">
                <option value="admin">Admin</option>
                <option value="super-admin">Super Admin</option>
            </select>
        </div>

        <div class="mdl-dialog__actions flex flex-row flex-space-between p-0 mt-2">
            <button type="button"
                    class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored tc-primary-button action-button-one mr-1"></button>
            <button type="button"
                    class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored tc-primary-button action-button-two "></button>
        </div>
        <p id="error-message" style="color: red;"></p>

    </div>

    <button type="button" class="mdl-button close close-dialog-button p-0">X</button>

</dialog>


<!-- QUIZ DIALOG
Used when adding a new quiz or when editing an existing quiz -->

<dialog id="quiz-dialog" class="mdl-dialog">

    <h3 class="mdl-dialog__title text-center"></h3>

    <div class="mdl-dialog__content flex flex-column gap-1">

        <div class="w-100 mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
            <label class="mdl-textfield__label">Naziv</label>
            <input class="mdl-textfield__input title" pattern=".{4,}">
            <span class="mdl-textfield__error"> Naziv kviza minimalno 4 karaktera! </span>
        </div>

        <div class="w-100 mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
            <label class="mdl-textfield__label">Url Slike</label>
            <input class="mdl-textfield__input image-url">
            <span class="mdl-textfield__error"> Url nije validan! </span>
        </div>

        <div>
            <p class="mb-0"> Pitanja </p>
            <table class="mdl-data-table mdl-js-data-table mdl-shadow--2dp w-100">
                <thead>
                <tr>
                    <th class="mdl-data-table__cell--non-numeric">Tekst</th>
                    <th>Vrijeme</th>
                    <th>Poeni</th>
                    <th>Edit</th>
                    <th style="display: none"></th>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
            <span class="mdl-textfield__error" style="visibility: hidden;"> Kviz nema dovoljno pitanja! </span>
        </div>
        <button id="new-question-button" type="button" class="mdl-button mdl-js-button mt-1">
            Novo pitanje
        </button>

        <p class="m-0">Kviz mora imati validan naziv, sliku i minimalno 10 pitanja.</p>
        <div class="mdl-dialog__actions flex flex-row flex-space-between p-0 ">
            <button type="button"
                    class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored tc-primary-button action-button-one"></button>
            <button type="button"
                    class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored tc-primary-button action-button-two "></button>
        </div>

    </div>

    <button type="button" class="mdl-button close close-dialog-button p-0">X</button>
</dialog>


<!-- QUESTION DIALOG
It's when adding a new question or editing an existing question -->

<dialog class="mdl-dialog" id="question-dialog">
    <h3 class="mdl-dialog__title text-center title"></h3>

    <div class="mdl-dialog__content flex flex-column gap-1">

        <div class="w-100 mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
            <label class="mdl-textfield__label">Tekst</label>
            <input type="text" class="mdl-textfield__input text" pattern=".{10,}">
            <span class="mdl-textfield__error"> Tekst pitanja minimalno 10 karaktera! </span>
        </div>

        <div class="w-100 mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
            <label class="mdl-textfield__label">Vrijeme za odgovor</label>
            <input type="text" class="mdl-textfield__input time-to-answer" pattern="[0-9]+">
            <span class="mdl-textfield__error"></span>
        </div>

        <div class="w-100 mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
            <label class="mdl-textfield__label">Poeni</label>
            <input type="text" class="mdl-textfield__input points" pattern="[0-9]+">
            <span class="mdl-textfield__error"> Broj poena koje pitanje nosi mora biti broj! </span>
        </div>

        <div>
            <p> Odgovori </p>
            <table class="mdl-data-table mdl-js-data-table mdl-shadow--2dp w-100">
                <thead>
                <tr>
                    <th class="mdl-data-table__cell--non-numeric">Tekst</th>
                    <th class="mdl-data-table__cell--non-numeric">Tačnost</th>
                    <th>Edit</th>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
            <span class="mdl-textfield__error" style="visibility: hidden;"> </span>
        </div>

        <button id="new-answer-button" type="button" class="mdl-button mdl-js-button m-0 mt-1">
            Novi odgovor
        </button>

        <p class="m-0">Pitanje mora imati validan naziv, vrijeme, poene i minimalno 2 odgovora.</p>
        <div class="mdl-dialog__actions flex flex-row flex-space-between p-0 mt-2 ">
            <button type="button"
                    class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored tc-primary-button action-button-one mb-2">
            </button>

            <button type="button"
                    class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored tc-primary-button action-button-two">
            </button>
        </div>

    </div>
    <button type="button" class="mdl-button close close-dialog-button p-0">X</button>
</dialog>


<!-- answer dialog -->

<dialog class="mdl-dialog" id="answer-dialog">
    <h3 class="mdl-dialog__title text-center title"></h3>

    <div class="mdl-dialog__content flex flex-column gap-1">

        <div class="w-100 mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
            <label class="mdl-textfield__label">Tekst</label>
            <input type="text" class="mdl-textfield__input text" pattern=".{10,}">
            <span class="mdl-textfield__error"> Tekst odgovora minimalno 10 karaktera! </span>
        </div>

        <div class="flex">
            <label class=" mr-1">Da li je odogovor tačan?</label>
            <input type="checkbox" class="is-correct">
        </div>

        <div class="mdl-dialog__actions flex flex-row flex-space-between p-0 mt-2">
            <button type="button"
                    class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored tc-primary-button action-button-one mb-2">
            </button>

            <button type="button"
                    class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored tc-primary-button action-button-two">
            </button>
        </div>
    </div>
    <button type="button" class="mdl-button close close-dialog-button p-0">X</button>
</dialog>


</body>

<script defer src="https://code.getmdl.io/1.3.0/material.min.js"></script>
<script type="module" src="./generatePin.js"></script>
<script type="module" src="./quizValidation.js"></script>
<script type="module" src="./questionValidation.js"></script>
<script type="module" src="./answerValidation.js"></script>
<script type="module" src="./home.js"></script>
<script type="module" src="./dragAndDrop.js"></script>
<script type="module" src="./userValidation.js"></script>

</html>
