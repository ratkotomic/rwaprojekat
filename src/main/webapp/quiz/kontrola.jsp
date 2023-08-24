<%@ page import="com.example.rwaprojekat.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Kviz Kontrola - QuizTopia</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../styles.css">
    <link rel="stylesheet" href="../reset.css">
    <link rel="stylesheet" href="kontrola.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.cyan-deep_orange.min.css"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.2/xlsx.full.min.js"></script>

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
            <span class="mdl-layout__title tc-black fw-bold">QuizTopia</span>
            <div class="mdl-layout-spacer"></div>
            <nav class="mdl-navigation">
                <a class="mdl-navigation__link tc-black fw-bold" href="">Admin Panel</a>
            </nav>
        </div>
    </header>

    <div class="mdl-layout__drawer">
        <span class="mdl-layout__title  tc-black fw-bold">QuizTopia</span>
        <nav class="mdl-navigation">
            <a class="mdl-navigation__link  tc-black fw-bold" href="">Admin Panel</a>
        </nav>
    </div>

    <main class="mdl-layout__content">
        <div class="container h-100 flex-column flex-center controls">
            <div class="wrapper py-1 w-80 px-2 flex flex-column flex-center gap-2">
                <h2> Kontrola kviza </h2>
                <p> Ispod imate kontrole kviza. Kada započnete kviz prvo pitanje se prikazuje učesnicima. Nakon isteka
                    vremena
                    datog pitanja možete prikazati slijedeće pitanje.</p>

                <p class="current-participants"></p>
                <p class="pin"></p>
                <p class="status">Status: Čekanje na igrače</p>
                <p class="timeToAnswer">Preostalo vrijeme za odgovor: </p>

                <div class="action flex flex-row flex-center flex-wrap gap-3">
                    <button id="start-quiz-button"
                            class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored tc-primary-button">
                        Započni kviz
                    </button>
                    <button id="next-question-button"
                            class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored  tc-primary-button" disabled>
                        Prikaži slijedeće pitanje
                    </button>
                </div>

                <p>${errorMessage}</p>
            </div>
        </div>


        <div class="container h-100 flex-column flex-center quiz-end">
            <div class="wrapper py-1 w-80 px-2 flex flex-column flex-center gap-2">
                <h2> Kviz je završen </h2>
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
                <div class="action flex flex-row flex-center flex-wrap gap-3">
                    <button class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored tc-primary-button" id="preuzmiListu">
                        Preuzmi listu
                    </button>
                    <button class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored  tc-primary-button" id="nazadButton">
                        Nazad
                    </button>
                  </div>
            </div>


        </div>


    </main>
</div>


</body>


<script>

    const game = JSON.parse(window.localStorage.getItem("game"));
    const container = document.querySelector(".controls");
    container.style.display = "flex";
    const elements = {
        currentParticipants: container.querySelector(".current-participants"),
        pin: container.querySelector(".pin"),
        status: container.querySelector(".status")
    }

    elements.pin.innerText = "Pin igre: " + game.pin


    const sessionInfo = {
        client: null,
        users: 0,
        currentQuestion: 0
    };


    createQuizClient();

    function createQuizClient() {

        let wsUrl = window.location.href;
        wsUrl = wsUrl.replace("quiz/kontrola.jsp", "quizServer");
        wsUrl = wsUrl.replace("http", "ws");
        wsUrl = wsUrl.replace("https", "ws");
        wsUrl += "?pin=" + game.pin;

        sessionInfo.client = new WebSocket(wsUrl);

        sessionInfo.client.onmessage = function (event) {
            let message = event.data;

            if (message.includes("users")) {
                message = message.replace("users: ", "");
                sessionInfo.users = Number(message);
                updateUserCount();
                return;

            }
        }

    }


    function updateUserCount() {
        elements.currentParticipants.innerText = "Trenutni broj učesnika: " + sessionInfo.users;
    }


    const startQuizButton = document.getElementById("start-quiz-button");
    startQuizButton.addEventListener("click", () => {

        if (sessionInfo.client == null)
            return;

        sessionInfo.client.send("quiz-start");
        startQuizButton.disabled = true;
        elements.status.innerText = "Status: Pitanje u toku";

        /* we add 5 seconds for the time users get shown the message that the quiz has started */
        setTimeout(() => {
            elements.status.innerText = "Status: Igrači čekaju na slijedeće pitanje";
            nextQuestionButton.disabled = false;
        }, (game.quiz.questions[0].timeToAnswer + 5) * 1000);
    });

    /* todo */
    /* we should not just show the next quesiton */
    /* should give the user a grace period of 5 seconds like a message like when starting the quiz */

    const nextQuestionButton = document.getElementById("next-question-button");
    nextQuestionButton.addEventListener("click", () => {
        nextQuestionButton.disabled = true;
        sessionInfo.currentQuestion++;

        if (sessionInfo.currentQuestion == game.quiz.questions.length) {
            endQuiz();
            return;
        }

        elements.status.innerText = "Status: Pitanje u toku";
        setTimeout(() => {
            elements.status.innerText = "Status: Igrači čekaju na slijedeće pitanje";
            nextQuestionButton.disabled = false;
        }, (game.quiz.questions[sessionInfo.currentQuestion].timeToAnswer + 5) * 1000);

        nextQuestionButton.disabled = true;
        sessionInfo.client.send("next-question");
    });


    function randomString() {
        return Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15);
    }


    function endQuiz() {
        sessionInfo.client.send("quiz-end");
        container.style.display = "none";
        document.querySelector(".quiz-end").style.display = "flex";

        let url = window.location.href;
        url = url.replace("quiz/kontrola.jsp", "getPlayers");
        const params = new URLSearchParams({pin: game.pin});

        fetch(url + "?" + params)
            .then((response) => {
                return response.json();
            })
            .then((data) => {
                let players = data;


                const table = document.querySelector("table");
                while (table.rows.length > 1) {
                    table.deleteRow(table.rows.length - 1);
                }

                let player;
                for (let i = 0; i < players.length; ++i) {
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


    document.getElementById("nazadButton").addEventListener("click", function () {
      let url = window.location.href;
      url = url.replace("quiz/kontrola.jsp", "admin/home")

      window.location.href = url;
    });

    const params = new URLSearchParams({pin: game.pin});

    let url = window.location.href;
    url = url.replace("quiz/kontrola.jsp", "getPlayers");
    document.getElementById("preuzmiListu").addEventListener("click", function () {
        fetch(url + "?" + params)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                generirajIXLSDatoteku(data);
                console.log(data);
            })
            .catch(error => {
                console.error('There was a problem with the fetch operation:', error);
            });
    });

    function generirajIXLSDatoteku(podaci) {
        var ws = XLSX.utils.json_to_sheet(podaci);

        var wb = XLSX.utils.book_new();
        XLSX.utils.book_append_sheet(wb, ws, "Rezultati");

        console.log("wb:", wb);
        var excelData = XLSX.write(wb, {bookType: 'xlsx', type: 'binary'});

        console.log("excelData:", excelData);
        const blob = new Blob([s2ab(excelData)], {
            type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        });
        const url = URL.createObjectURL(blob);

        const a = document.createElement("a");
        a.href = url;
        a.download = "rezultati_kviza.xlsx";
        a.click();

        URL.revokeObjectURL(url);

        function s2ab(s) {
            const buf = new ArrayBuffer(s.length);
            const view = new Uint8Array(buf);
            for (let i = 0; i < s.length; i++) {
                view[i] = s.charCodeAt(i) & 0xFF;
            }
            return buf;
        }
    }

</script>

</html>
