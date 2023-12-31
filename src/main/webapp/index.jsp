<%@ page import="com.example.rwaprojekat.model.User" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Home - QuizTopia</title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="reset.css">
    <link rel="stylesheet" href="index.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.cyan-deep_orange.min.css"/>
</head>
<body>

<%
    User user = (User) request.getSession().getAttribute("user");
    String userRole;
    if(user == null)
        userRole = null;
    else
        userRole = user.getRole();

%>

<div class="mdl-layout mdl-js-layout">

    <header class="mdl-layout__header">
        <div class="mdl-layout-icon"></div>
        <div class="mdl-layout__header-row">
            <span class="mdl-layout__title tc-black fw-bold">QuizTopia</span>
            <div class="mdl-layout-spacer"></div>
            <nav class="mdl-navigation">
                <a class="mdl-navigation__link tc-black fw-bold" href="index">Home</a>
                <%
                    if(userRole != null)
                    {
                %>
                <a class="mdl-navigation__link tc-black fw-bold" href="admin/home">Admin Pristup</a>
                <%
                    }
                    else
                    {
                %>
                <a class="mdl-navigation__link tc-black fw-bold" href="login">Admin Pristup</a>
                <%
                    }
                %>
            </nav>
        </div>
    </header>

    <div class="mdl-layout__drawer">
        <span class="mdl-layout__title  tc-black fw-bold">QuizTopia</span>
        <nav class="mdl-navigation">
            <a class="mdl-navigation__link  tc-black fw-bold" href="index">Home</a>
            <a class="mdl-navigation__link  tc-black fw-bold" href="login">Admin Pristup</a>
        </nav>
    </div>

    <main class="mdl-layout__content">


        <div class="container h-100 flex flex-row">

            <div class="wrapper py-3 w-60 px-3 flex flex-column flex-center gap-4">

                <h1 class="fs-heading"> Dobrodošli u Kviz aplikaciju</h1>

                    <div class="w-100 mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                        <label class="mdl-textfield__label" for="pin">Unesite pin za početak kviza.</label>
                        <input class="mdl-textfield__input" type="text" pattern="[0-9]+" id="pin"
                               name="pin" title="Unos mora biti broj!">
                        <span class="mdl-textfield__error">Unos nije broj!</span>
                    </div>

                    <input type="submit" id="submit" value="Potvrdi pin"
                           class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored  tc-primary-button" disabled>
                <p>${errorMessage}</p>

            </div>
            <div class="flex flex-column flex-center gap-1 chat-container p-1">
                <h5>Chat</h5>
            </div>
        </div>
    </main>
</div>

<script>

    const submit = document.getElementById("submit");
    const pinInput = document.getElementById("pin");

    submit.addEventListener("click", showQuiz);
    pinInput.addEventListener("input", inputModified);

    function inputModified() {
        submit.disabled = !isPinValid();
    }



    function showQuiz(){

        if(!isPinValid())
            return;

        window.localStorage.setItem("pin", pinInput.value);
        window.location.href = "quiz";

    }

    function isPinValid ()
    {
        const a = pinInput.value !== "";
        const b = pinInput.checkValidity();
        return pinInput.value !== "" && pinInput.checkValidity();
    }

    const chatContainer = document.querySelector(".chat-container");

    let wsUrl = window.location.href;
    wsUrl = wsUrl.replace("index", "");
    wsUrl += "chatServer"
    wsUrl = wsUrl.replace("http", "ws");
    wsUrl = wsUrl.replace("https", "ws");

    let client = new WebSocket(wsUrl);

    client.onopen = function(event){
        let message = document.createElement("p");
        message.innerText = "Povezani ste!";
        chatContainer.appendChild(message);
    }
    client.onmessage = function (event) {
        let message = document.createElement("p");
        message.innerText = event.data;
        chatContainer.appendChild(message);
    }





</script>

<script defer src="https://code.getmdl.io/1.3.0/material.min.js"></script>

</body>
</html>