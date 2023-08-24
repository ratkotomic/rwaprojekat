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
    <title>Igranje Kviza - QuizTopia</title>
    <link rel="stylesheet" href="../styles.css">
    <link rel="stylesheet" href="../reset.css">
    <link rel="stylesheet" href="index.css">
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
                <a class="mdl-navigation__link tc-black fw-bold home-link" href="../">Home</a>
                <a class="mdl-navigation__link tc-black fw-bold" href="../login">Admin Pristup</a>
            </nav>
        </div>
    </header>

    <div class="mdl-layout__drawer">
        <span class="mdl-layout__title  tc-black fw-bold">QuizTopia</span>
        <nav class="mdl-navigation">
            <a id="home-link" class="mdl-navigation__link  tc-black fw-bold">Home</a>
            <a class="mdl-navigation__link  tc-black fw-bold" href="login">Admin Pristup</a>
        </nav>
    </div>

    <main class="mdl-layout__content">

        <div class="container h-100 flex-column flex-center info-input">
            <div class="wrapper py-1 w-80 px-2 flex flex-column flex-center gap-2">
                <h1 class="fs-heading"> O vama </h1>
                <p> Ispod možete unijeti svoje ime i prezime. Ovo koristimo da vas možemo prikazati u ranking listi
                    naspram drugih takmičara.</p>

                <div class="w-100 mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                    <label class="mdl-textfield__label" for="name"> Ime</label>
                    <input class="mdl-textfield__input" type="text" id="name" name="name">
                </div>
                <div class="w-100 mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                    <label class="mdl-textfield__label" for="lastname">Prezime</label>
                    <input class="mdl-textfield__input" type="text" id="lastname" name="lastname">
                </div>
                <input id="info-submit-button" type="button" value="Pocetak"
                       class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored tc-primary-button enter" disabled>

                <p>${errorMessage}</p>
            </div>
        </div>

        <div class="container h-100 flex-column flex-center quiz-begins-soon ">
            <div class="wrapper py-1 w-80 px-2 flex flex-column flex-center gap-2">

                <h2 class="title">Kviz uskoro počinje</h2>
                <p class="message">Još malo i kviz počinje. Kada organizator bude zadovoljan sa brojem učesnika kviz će biti pokrenut.
                    Budi spreman! Svako pitanja ima sa sobom asociran vremenski limit !</p>
                <div class="w-100">
                    <p class="your-name"></p>
                    <p class="name-of-quiz"></p>
                    <p class="organiser-of-quiz"></p>
                    <p class="current-participants"></p>
                </div>

                <p class="quiz-starting-message tc-primary-button fw-bold"></p>
                <a class="tc-link" href="../">Izlaz</a>
            </div>

        </div>

        <div class="container h-100 flex-column flex-center question-container">

            <div class="wrapper py-1 w-80 px-2 flex flex-column flex-center gap-2">
                <div id="p1" class="mdl-progress mdl-js-progress">
                </div>
                <p class="current-participants w-100 m-0"></p>
                <h3 class="text"></h3>
                <div class="options flex flex-row flex-center gap-3 flex-wrap p-2 m-2">
                </div>

                <div class="action flex flex-row flex-center flex-wrap gap-3">
                    <button class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored check-button tc-primary-button" disabled>
                        Projveri
                    </button>
                    <button class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored  continue-button tc-primary-button" disabled>
                        Nastavi
                    </button>
                </div>
            </div>
        </div>

        <div class="container h-100 flex-column flex-center in-between-questions">
            <div class="wrapper py-1 w-80 px-2 flex flex-column flex-center gap-2">
                <h2> Čekanje na slijedeće pitanje </h2>
                <h3>Trenutni ranking</h3>
                <table class="mdl-data-table mdl-js-data-table">
                    <thead>
                    <tr>
                        <th>Rank</th>
                        <th class="mdl-data-table__cell--non-numeric">Ime</th>
                        <th class="mdl-data-table__cell--non-numeric">Prezime</th>
                        <th>Poeni</th>
                    </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>


            </div>
        </div>



        <div class="container h-100 flex-column flex-center end">
            <div class="wrapper py-1 w-80 px-2 flex flex-column flex-center gap-2">
                <h2> Kviz je završen! </h2>
                <h3>Konačni ranking</h3>
                <table class="mdl-data-table mdl-js-data-table">
                    <thead>
                    <tr>
                        <th>Rank</th>
                        <th class="mdl-data-table__cell--non-numeric">Ime</th>
                        <th class="mdl-data-table__cell--non-numeric">Prezime</th>
                        <th>Poeni</th>
                    </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>

                <a href="../">Nastavi</a>
            </div>
        </div>


    </main>
</div>


</body>
</html>

<script>
    const pin = window.localStorage.getItem("pin");

    const infoInput = document.querySelector(".info-input");
    infoInput.style.display = "flex";
    const infoInputElements = {
        submit: document.getElementById("info-submit-button"),
        name: document.getElementById("name"),
        lastname: document.getElementById("lastname")
    };

    const userInfo = {
        name: "",
        lastname: ""
    }

    infoInputElements.name.addEventListener("input", infoInputChanged);
    infoInputElements.lastname.addEventListener("input", infoInputChanged);
    function infoInputChanged()
    {
        infoInputElements.submit.disabled = infoInputElements.name.value === ""
            || infoInputElements.lastname.value === "";
    }

    infoInputElements.submit.addEventListener("click", () =>
    {
        if(tryToGetInfo())
        {
            infoInput.style.display = "none";
            createQuizClient();
        }
    });

    function tryToGetInfo()
    {
        userInfo.name = infoInputElements.name.value;
        userInfo.lastname = infoInputElements.lastname.value;
        return !(userInfo.name === "" || userInfo.lastname === "");

    }

    const quizBeginsSoon = document.querySelector(".quiz-begins-soon");
    quizBeginsSoonElements = {
        username : quizBeginsSoon.querySelector(".your-name"),
        quizName : quizBeginsSoon.querySelector(".name-of-quiz"),
        organiser: quizBeginsSoon.querySelector(".organiser-of-quiz"),
        currentParticipants: quizBeginsSoon.querySelector(".current-participants"),
        quizStartingMessage : quizBeginsSoon.querySelector(".quiz-starting-message")
    }


    const questionContainer = document.querySelector(".question-container");
    const questionContainerElements = {
        text: questionContainer.querySelector(".text"),
        options: questionContainer.querySelector(".options"),
        currentParticipants: questionContainer.querySelector(".current-participants"),
        checkButton: questionContainer.querySelector(".check-button"),
        continueButton: questionContainer.querySelector(".continue-button"),
        limit: questionContainer.querySelector(".mdl-progress")
    }

    questionContainerElements.checkButton.addEventListener("click", () => checkUserAnswer());


    const inBetweenQuestions = document.querySelector(".in-between-questions");
    questionContainerElements.continueButton.addEventListener("click", () => showInbetweenQuestions());


    const end = document.querySelector(".end");

    const sessionInfo = {
        users: 0,
        client: null,
        quizObject: null,
        currentQuestion: 0,
        quizId: null,
        userId: 0
    }




    function createQuizClient() {

        let wsUrl = window.location.href;
        wsUrl = wsUrl.replace("/index.jsp", "");
        wsUrl = wsUrl.replace("https", "ws");
        wsUrl = wsUrl.replace("http", "ws");
        wsUrl = wsUrl.replace("quiz/", "quizServer");
        wsUrl += "?pin=" + pin + "&name=" + userInfo.name + "&lastname=" + userInfo.lastname;

        sessionInfo.client = new WebSocket(wsUrl);


        sessionInfo.client.onopen = function (event) {
        };

        sessionInfo.client.onmessage = function (event) {

            let message = event.data;

            if(message.includes("users"))
            {
                message = message.replace("users: ", "");
                sessionInfo.users = Number(message);
                updateUserCount();
                return;

            }

            switch(message) {

                case "no-game":
                    alert("Igra sa datim pin-om nije pronađena!");
                    url = window.location.href;
                    url = url.replace("quiz/" , "");
                    window.location.href = url;
                    break;

                case "no-join":
                    alert("Igra sa datim trenutno ne prima igrače!");
                    url = window.location.href;
                    url = url.replace("quiz/" , "");
                    window.location.href = url;
                    break;

                case "quiz-start":
                    quizBeginsSoonElements.quizStartingMessage.innerText = "Admin je pokreno kviz! Prvo pitanje će se pojaviti za 5 sekundi!";
                    setTimeout(startQuiz, 5000);
                    break;

                case "quiz-end":
                    showEndScreen();
                    break;

                case "next-question":
                    showNextQuestion();
                    break;

                case "user-was-correct":
                    if(inBetweenQuestions.style.display === "flex")
                        showInbetweenQuestions();
                    break;

                default:
                    fetchQuiz(message);
                    break;

            }
        };
    }



    function startQuiz()
    {
        questionContainer.style.display ="flex";
        quizBeginsSoon.style.display ="none";

        const question = sessionInfo.quizObject.questions[0];
        updateQuestionContainer(question);
    }

    function showNextQuestion(){
        inBetweenQuestions.style.display = "none";
        questionContainer.style.display ="flex";
        sessionInfo.currentQuestion++;

        if(sessionInfo.currentQuestion == sessionInfo.quizObject.questions.length)
        {
            showEndScreen();
        }

        const question = sessionInfo.quizObject.questions[sessionInfo.currentQuestion];
        updateQuestionContainer(question);
        updateCheckButton();
        questionContainerElements.continueButton.disabled = true;
    }


    let questionTimeoutId;
    function updateQuestionContainer(question)
    {
        questionContainerElements.text.innerText = question.questionText;
        questionContainerElements.limit.MaterialProgress = 0;

        let eachSecondProgress = 100 / question.timeToAnswer;
        for(let i = 0; i < question.timeToAnswer; ++i)
        {
            setTimeout(() => questionContainerElements.limit.firstElementChild.style.width = eachSecondProgress * i + "%",
            i * 1000);
        }

        questionTimeoutId = setTimeout(() => {
            alert("Vrijeme je isteklo!");
            showInbetweenQuestions();
        }, question.timeToAnswer * 1000);

        let button;
        const options =  questionContainerElements.options;
        options.innerHTML = "";
        for(let i = 0; i < question.answers.length; ++i)
        {
            button = document.createElement("BUTTON");
            button.classList.add("mdl-button", "mdl-js-button", "mdl-button--raised", "tc-primary-button");
            button.addEventListener("click", (event) => selectAnswer(event));
            button.innerText = question.answers[i].answerText;
            options.appendChild(button);
        }
    }

    function selectAnswer(event){
        const button = event.currentTarget;
        const options = button.parentElement;

        if(button.classList.contains("mdl-button--accent"))
        {
            button.classList.remove("mdl-button--accent", "tc-primary-button");
        }
        else{

            let sibling;
            for(let i = 0; i < options.children.length; ++i)
            {
                sibling = options.children[i];
                if(sibling === button)
                    continue;

                if(sibling.classList.contains("mdl-button--accent"))
                    sibling.classList.remove("mdl-button--accent", "tc-primary-button");
            }
            button.classList.add("mdl-button--accent", "tc-primary-button");
        }

        updateCheckButton();
    }

    function updateCheckButton()
    {
        const options = questionContainerElements.options.children;
        for(let i = 0; i < options.length; ++i)
        {
            if(options[i].classList.contains("mdl-button--accent"))
            {
                questionContainerElements.checkButton.disabled = false;
                return;
            }

        }

        questionContainerElements.checkButton.disabled = true;
    }

    function fetchQuiz(message)
    {
        let url = window.location.href;
        url = url.replace("quiz/", "admin/getQuiz");
        const params = new URLSearchParams({id: message});

        fetch(url + "?" + params)
            .then((response) => {
                return response.json();
            })
            .then((data) => {
                sessionInfo.quizObject = data;
                updateQuizBeginsSoon();
                quizBeginsSoon.style.display = "flex";
            })
            .catch(() => {
                throw new Error("Get quiz failed!");
            })
    }


    function updateUserCount()
    {
        quizBeginsSoonElements.currentParticipants.innerText = "Trenutni broj učesnika: " + sessionInfo.users;
        questionContainerElements.currentParticipants.innerText = "Trenutni broj učesnika: " + sessionInfo.users;
    }


    function randomString() {
        return Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15);
    }


    function updateQuizBeginsSoon()
    {
        if(sessionInfo.quizObject == null)
            return;

        updateUserCount();
        quizBeginsSoonElements.username.innerText = "Ime: " + userInfo.name + " " + userInfo.lastname;
        quizBeginsSoonElements.quizName.innerText = "Kviz: " + sessionInfo.quizObject.title;
        quizBeginsSoonElements.organiser.innerText = "Organizator: " + sessionInfo.quizObject.owner.username;
    }


    /* todo */
    /* dva ista odgovora ne mogu biti unutar pitanja */

    /* todo */
    /* treba napravit da quiz ima vise tacnih odgovora */

    function checkUserAnswer()
    {
        clearTimeout(questionTimeoutId);
        const button = getSelectedAnswer();
        const answerIndex = Array.from(button.parentElement.children).indexOf(button);

        const question = sessionInfo.quizObject.questions[sessionInfo.currentQuestion];
        const answer = question.answers[answerIndex];
        if(answer.correct)
        {
            userWasCorrect(button);
        }
        else
        {
            let correctAnswerIndex = 0;
            for(let i = 0; i < question.answers.length; ++i)
            {
                if(question.answers[i].correct){
                    correctAnswerIndex = i;
                    break;
                }
            }
            const correctButton = button.parentElement.children[correctAnswerIndex];
            userWasWrong(button, correctButton);
        }

        questionContainerElements.checkButton.disabled = true;
        questionContainerElements.continueButton.disabled = false;

    }

    function userWasCorrect(button){
        button.style.backgroundColor = "green";
        button.style.color = "black";

        sessionInfo.client.send("user-was-correct");
    }

    function userWasWrong(button, correctButton)
    {
        button.style.backgroundColor = "red";
        button.style.color = "black";

        correctButton.style.backgroundColor = "green";
        correctButton.style.color = "black";
    }


    function getSelectedAnswer(){
        const options = questionContainerElements.options;
        for(let i = 0; i < options.children.length; ++i)
        {
            if(options.children[i].classList.contains("mdl-button--accent"))
                return options.children[i];
        }
    }


    function showInbetweenQuestions(){

        let url = window.location.href;
        url = url.replace("quiz/", "getPlayers");
        const params = new URLSearchParams({pin: pin});

        fetch(url + "?" + params)
            .then((response) => {
                return response.json();
            })
            .then((data) => {
                let players = data;


                const table = inBetweenQuestions.querySelector("table");
                while (table.rows.length > 1) {
                    table.deleteRow(table.rows.length - 1);
                }

                let player;
                for (let i = 0; (i < players.length) && (i < 10); ++i) {
                    player = players[i];
                    let row = table.insertRow(-1);

                    let c1 = row.insertCell(0);
                    let c2 = row.insertCell(1);
                    let c3 = row.insertCell(2);
                    let c4 = row.insertCell(3);

                    c1.innerText = i + 1;
                    c2.innerText = player.firstName;
                    c3.innerText = player.lastName;
                    c4.innerText = player.points;

                    }

                questionContainer.style.display = "none";
                inBetweenQuestions.style.display = "flex";
            })
            .catch(() => {
                throw new Error("get players failed!");
            })

    }


    function showEndScreen()
    {
        questionContainer.style.display = "none";
        inBetweenQuestions.style.display = "none";
        end.style.display = "flex";

        let url = window.location.href;
        url = url.replace("quiz/", "getPlayers");
        const params = new URLSearchParams({pin: pin});

        fetch(url + "?" + params)
            .then((response) => {
                return response.json();
            })
            .then((data) => {
                let players = data;


                const table = end.querySelector("table");
                while (table.rows.length > 1) {
                    table.deleteRow(table.rows.length - 1);
                }

                let player;
                for (let i = 0; (i < players.length) && (i < 10); ++i) {
                    player = players[i];
                    let row = table.insertRow(-1);

                    let c1 = row.insertCell(0);
                    let c2 = row.insertCell(1);
                    let c3 = row.insertCell(2);
                    let c4 = row.insertCell(3);

                    c1.innerText = i + 1;
                    c2.innerText = player.firstName;
                    c3.innerText = player.lastName;
                    c4.innerText = player.points;

                }
            })
            .catch(() => {
                throw new Error("get players failed!");
            })

    }


    document.querySelector('#p1').addEventListener('mdl-componentupgraded', function() {
        this.MaterialProgress.setProgress(44);
    });

</script>


<script defer src="https://code.getmdl.io/1.3.0/material.min.js"></script>

</html>