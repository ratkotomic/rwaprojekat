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
    <style>
        body {

        }

        #question-container {
            display: none;
            margin: 0px auto;
            width: 50%;

        }
    </style>
</head>
<body>
<div id="question-container">
    <p id="status"></p>
    <div id="text"></div>
    <button id="next">Next</button>
</div>
</body>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        var username = prompt("Unesite vaše ime: ");
        createQuizClient({
            username: username,
            container: document.getElementById("question-container")
        });
    });


    function randomString() {
        return Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15);
    }


    function showContainer(container) {
        container.style.display = "block";
    }

    function createQuizClient(params) {
        'use strict';

        const username = params.username;
        const container = params.container;

        const wsUrl = "ws://localhost:8080/rwaprojekat_war_exploded/quiz";
        const userId = "user-" + randomString();
        const elements = {
            text: container.querySelector("#text"),
            next: container.querySelector("#next"),
            status: container.querySelector("#status")
        };

        showContainer(container);

        const client = new WebSocket(wsUrl);

        client.onopen = function (event) {
            elements.status.innerText = "Povezani ste " + " [" + username + "]";
        };

        client.onhandlenextquestion = function (event) {
            const question = JSON.parse(event.data);
            console.log("Message received", message);
            if (message.userId != userId) {
                text.innerText = question.text;
            }
        };

        next.addEventListener("click", (event) =>
        {
            client.send(JSON.stringify("hello"));
        })


    }
</script>


</html>