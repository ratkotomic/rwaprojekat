<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 8/21/2023
  Time: 12:53 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="../styles.css">
    <link rel="stylesheet" href="../reset.css">
    <link rel="stylesheet" href="quiz.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.cyan-deep_orange.min.css"/>
</head>
<body>

<div class="mdl-layout mdl-js-layout">

    <header class="mdl-layout__header">
        <div class="mdl-layout-icon"></div>
        <div class="mdl-layout__header-row">
            <span class="mdl-layout__title tc-black fw-bold">QuizTopia</span>
            <div class="mdl-layout-spacer"></div>
            <nav class="mdl-navigation">
                <a class="mdl-navigation__link tc-black fw-bold" href="index">Home</a>
                <a class="mdl-navigation__link tc-black fw-bold" href="login">Admin Pristup</a>
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


        <div class="quiz-begins-soon flex-column flex-center p-2 gap-2 w-80">
            <h2 class="title">Kviz uskoro počinje</h2>
            <p class="message">Još malo i kviz počinje. Kada organizator bude zadovoljan sa brojem učesnika kviz će biti pokrenut.
                Budi spreman! Svako pitanja ima sa sobom asociran vremenski limit !</p>
            <p class="name-of-quiz"></p>
            <p class="organizator-of-quiz"></p>
            <p class="current-participants"></p>
            <button>Izlaz</button>
        </div>

        <div class="question-container flex-column flex-center gap-3 p-3">
            <h2 class="title"></h2>
            <p class="text"></p>
            <div class="options">

            </div>
        </div>

        <button id="start-quiz-button">Start quiz</button>
        <button id="next-question-button" style="display: none;">Next question</button>
    </main>
</div>


</body>
</html>

<script>

    const quizBeginsSoon = document.querySelector(".quiz-begins-soon");
    const questionContainer = document.querySelector(".question-container");

    document.addEventListener("DOMContentLoaded", function () {
        username = prompt("Unesite vaše ime:");
        createQuizClient();
    });

    let currentUserCount;

    const startQuizButton = document.getElementById("start-quiz-button");
    const nextQuestionButton = document.getElementById("next-question-button");
    nextQuestionButton.addEventListener("click", () =>
    {
        sendMessage("next-question");
    })
    startQuizButton.addEventListener("click", () => {
        sendMessage("start-quiz");
        startQuizButton.style.display="none";
        nextQuestionButton.style.display="block";


    });

    let username;
    let userId;
    let client;
    let quizId;
    let currentQuestion = 0;

    let quizObject;


    function createQuizClient() {

        let wsUrl = window.location.href;
        wsUrl = wsUrl.replace("/quiz.jsp", "");
        wsUrl = wsUrl.replace("https", "ws");
        wsUrl = wsUrl.replace("http", "ws");
        userId = "user-" + randomString();


        client = new WebSocket(wsUrl);
        quizBeginsSoon.style.display = "flex";

        client.onopen = function (event) {
        };

        client.onmessage = function (event) {

            let message = event.data;

            if(message.includes("users"))
            {
                message = message.replace("users", "");
                currentUserCount = Number(message);
                updateQuizBeginsSoon();
                return;

            }

            if(message == "next-question")
            {
                currentQuestion++;
                const question = quizObject.questions[currentQuestion];
                questionContainer.querySelector(".title").innerText = "Pitanje " + currentQuestion;
                questionContainer.querySelector(".text").innerText = question.questionText;

                let button;
                const options = questionContainer.querySelector(".options");
                options.innerHTML = "";
                for(let i = 0; i < question.answers.length; ++i)
                {
                    button = document.createElement("BUTTON");
                    button.innerText = question.answers[i].answerText;
                    options.appendChild(button);

                }
                return;
            }

            if(message === "start-quiz")
            {
                questionContainer.style.display ="flex";
                quizBeginsSoon.style.display ="none";

                const question = quizObject.questions[currentQuestion];
                questionContainer.querySelector(".title").innerText = "Pitanje " + currentQuestion;
                questionContainer.querySelector(".text").innerText = question.questionText;

                let button;
                const options = questionContainer.querySelector(".options");
                for(let i = 0; i < question.answers.length; ++i)
                {
                    button = document.createElement("BUTTON");
                    button.innerText = question.answers[i].answerText;
                    options.appendChild(button);

                }
                return;
            }

            if(message == "hide-question")
            {

            }

            /* the message contains the id of the quiz */

            let url = window.location.href;
            url = url.replace("quiz/quiz.jsp", "admin/getQuiz");
            const params = new URLSearchParams({id: message});

            fetch(url + "?" + params)
                .then((response) => {
                    return response.json();
                })
                .then((data) => {
                    quizObject = data;
                    updateQuizBeginsSoon();
                })
                .catch(() => {
                    throw new Error("Get quiz failed!");
                })
        };

    }

    function sendMessage(text) {
        client.send(text);
    }


    function randomString() {
        return Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15);
    }


    function updateQuizBeginsSoon()
    {
        if(quizObject == null)
            return;

        quizBeginsSoon.querySelector(".current-participants").innerText = "Trenutni broj učesnika:" + currentUserCount;
        quizBeginsSoon.querySelector(".name-of-quiz").innerText = "Ime kviza: " + quizObject.title;
        quizBeginsSoon.querySelector(".organizator-of-quiz").innerText = "Organizator kviza: " + quizObject.owner.username;
    }

</script>


<script defer src="https://code.getmdl.io/1.3.0/material.min.js"></script>

</html>