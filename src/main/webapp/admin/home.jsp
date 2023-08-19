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
    <title>Admin</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../styles.css">
    <link rel="stylesheet" href="../reset.css">
    <link rel="stylesheet" href="../admin/home.css">
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
                <a class="mdl-navigation__link tc-black fw-bold" href="home">Kvizovi</a>

                <%
                    if(userRole.equals("super-admin"))
                    {
                        %>

                            <a class="mdl-navigation__link tc-black fw-bold" href="admin/users">Korisnici</a>

                        <%
                    }
                %>

                <a class="mdl-navigation__link tc-black fw-bold" href="/rwaprojekat/admin/logout">Log out</a>
            </nav>
        </div>
    </header>

    <div class="mdl-layout__drawer">
        <span class="mdl-layout__title  tc-black fw-bold">Admin Panel</span>
        <nav class="mdl-navigation">
            <a class="mdl-navigation__link  tc-black fw-bold" href="home">Kvizovi</a>
            <%
                if(userRole.equals("super-admin"))
                {
            %>
               <a class="mdl-navigation__link  tc-black fw-bold" href="admin/users">Korisnici</a>
            <%
                }
            %>
            <a class="mdl-navigation__link  tc-black fw-bold" href="/rwaprojekat/admin/logout">Log out</a>
        </nav>
    </div>

    <main class="mdl-layout__content p-3">

        <h1 class="mb-3">Kvizovi</h1>

        <button type="button"  id="new-quiz-button" class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored tc-primary-button mb-2">
            Novi kviz
        </button>


        <!-- ALL QUIZZES -->


        <div class="quizzes-container flex flex-row flex-wrap gap-2">
            <%

                List<Quiz> quizList = (List<Quiz>)request.getAttribute("quizList");

                for (Quiz quiz : quizList)
                {
            %>
                <div class="quiz-container flex flex-column flex-center gap-1 p-2" data-id="<%= quiz.getId()%>">
                    <h2 class="title"><%= quiz.getTitle() %></h2>
                    <img class="image-url" src="<%= quiz.getImageUrl() %>">

                    <button type="button"  class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored tc-primary-button w-100 edit-quiz-button">
                        Edit
                    </button>

                    <button type="button" class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored tc-primary-button w-100 start-quiz-button">
                        Započni
                    </button>

                </div>

            <%
                }
            %>
        </div>
    </main>
</div>


<!-- QUIZ DIALOG
Used when adding a new quiz or when editing an existing quiz -->

<dialog id="quiz-dialog" class="mdl-dialog">

    <h3 class="mdl-dialog__title text-center"></h3>

    <div class="mdl-dialog__content">
        <form class="flex flex-column gap-2">

            <div class="w-100 mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                <label class="mdl-textfield__label">Naziv</label>
                <input class="mdl-textfield__input title" type="text">
            </div>

            <div class="w-100 mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                <label class="mdl-textfield__label">Url Slike</label>
                <input class="mdl-textfield__input image-url" type="text">
            </div>
        </form>


        <p> Pitanja </p>
        <table class="mdl-data-table mdl-js-data-table mdl-shadow--2dp">
            <thead>
            <tr>
                <th class="mdl-data-table__cell--non-numeric">Tekst</th>
                <th>Vrijeme</th>
                <th>Poeni</th>
                <th>Edit</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>

        <button id="new-question-button" type="button" class="mdl-button mdl-js-button m-0 mt-1">
            Novo pitanje
        </button>


        <div class="mdl-dialog__actions flex flex-row flex-space-between p-1 mt-2">
            <button type="button" class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored tc-primary-button action-button-one "></button>
            <button type="button" class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored tc-primary-button action-button-two "></button>
        </div>

    </div>

    <button type="button" class="mdl-button close close-dialog-button p-0">X</button>
</dialog>



<!-- QUESTION DIALOG
It's when adding a new question or editing an existing question -->

<dialog class="mdl-dialog" id="question-dialog">
    <h3 class="mdl-dialog__title text-center title"></h3>

    <div class="mdl-dialog__content flex flex-column flex-center">
        <form class="flex flex-column gap-2">

            <div class="w-100 mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                <label class="mdl-textfield__label">Tekst</label>
                <input class="mdl-textfield__input text" type="text">
            </div>

            <div class="w-100 mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                <label class="mdl-textfield__label">Vrijeme za odgovor</label>
                <input class="mdl-textfield__input time-to-answer" type="number">
            </div>

            <div class="w-100 mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                <label class="mdl-textfield__label">Poeni</label>
                <input class="mdl-textfield__input points" type="number">
            </div>
        </form>

        <button type="button" class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored tc-primary-button action-button-one mb-2">

        </button>

        <button type="button" class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored tc-primary-button action-button-two">

        </button>
    </div>
    <button type="button" class="mdl-button close close-dialog-button p-0">X</button>
</dialog>


</body>


<script>


    const questionDialog = document.getElementById("question-dialog");
    const quizDialog = document.getElementById("quiz-dialog");


    /* QUIZ DIALOG */


    /*
        This part is for when the quiz dialog is used when the edit button,
        of an already existing quiz, is clicked
        we make a fetch call to get the quiz and then we fill out the dialog
     */

    const editQuizButtons = document.querySelectorAll(".edit-quiz-button");
    editQuizButtons.forEach((button) => button.addEventListener("click", (event) => showEditQuizDialog((button))));


    document.getElementById("new-question-button").addEventListener("click", (event) => showNewQuestionDialog(event.currentTarget));

     function showEditQuizDialog(button) {

        const quizContainer = button.parentElement;
        const quizId = quizContainer.getAttribute("data-id");

        let url = window.location.href;
        url = url.replace("home", "getQuiz");
        const params = new URLSearchParams({id: quizId});

        fetch(url + "?" + params)
            .then((response) =>
            {
                return response.json();
            })
            .then((data) => {
                let quizObject = data;

                quizDialog.querySelector("h3").innerText = "Editovanje";
                const titleInput = quizDialog.querySelector(".title");
                titleInput.value = quizObject.title;
                titleInput.parentElement.classList.add("is-dirty");
                titleInput.parentElement.classList.add("is-upgraded");

                const imageUrlInput = quizDialog.querySelector(".image-url");
                imageUrlInput.value = quizObject.imageUrl;
                imageUrlInput.parentElement.classList.add("is-dirty");
                imageUrlInput.parentElement.classList.add("is-upgraded");

                const tableOfQuestions = quizDialog.querySelector("table");
                while(tableOfQuestions.rows.length > 1)
                {
                    tableOfQuestions.deleteRow(tableOfQuestions.rows.length-1);
                }

                let question;
                for(let i = 0; i < quizObject.questions.length; ++i) {
                    question = quizObject.questions[i];
                    let row = tableOfQuestions.insertRow(-1);
                    row.setAttribute("question-id", question.id);
                    let c1 = row.insertCell(0);
                    let c2 = row.insertCell(1);
                    let c3 = row.insertCell(2);
                    let c4 = row.insertCell(3);

                    c1.innerText = question.questionText;
                    c2.innerText = question.timeToAnswer;
                    c3.innerText = question.points;

                    let editButton = document.createElement("button");
                    editButton.classList.add("mdl-button");
                    editButton.classList.add("mdl-js-button");
                    editButton.innerText = "Edit";
                    editButton.addEventListener("click", (event) => showEditQuestionDialog(event.currentTarget, row));
                    c4.appendChild(editButton);
                }


                const oldActionButtonOne = quizDialog.querySelector(".action-button-one");
                const oldActionButtonTwo = quizDialog.querySelector(".action-button-two");

                let newActionButtonOne = oldActionButtonOne.cloneNode(true);
                oldActionButtonOne.parentNode.replaceChild(newActionButtonOne, oldActionButtonOne);
                newActionButtonOne.innerText = "Sačuvaj";
                newActionButtonOne.addEventListener("click", (event) => saveQuizChanges(event.currentTarget, quizContainer));

                oldActionButtonTwo.style.display = "block";
                let newActionButtonTwo = oldActionButtonTwo.cloneNode(true);
                oldActionButtonTwo.parentNode.replaceChild(newActionButtonTwo, oldActionButtonTwo);
                newActionButtonTwo.innerText = "Izbriši";
                newActionButtonTwo.addEventListener("click", (event) => deleteQuiz(event.currentTarget, quizContainer));



                quizDialog.showModal();
            })
            .catch(() => {
                throw new Error("Get quiz failed!");
            })

    }



    /* while editing a quiz the user might decide to edit a question */

    function showEditQuestionDialog(button, row)
    {
        questionDialog.querySelector(".title").innerText = "Pitanje edit";
        const textInput = questionDialog.querySelector(".text");
        textInput.value = row.cells[0].innerText;
        textInput.parentElement.classList.add("is-dirty")
        textInput.parentElement.classList.add("is-upgraded");

        const timeToAnswerInput = questionDialog.querySelector(".time-to-answer");
        timeToAnswerInput.value = row.cells[1].innerText;
        timeToAnswerInput.parentElement.classList.add("is-dirty");
        timeToAnswerInput.parentElement.classList.add("is-upgraded");

        const pointsInput = questionDialog.querySelector(".points");
        pointsInput.value = row.cells[2].innerText;
        pointsInput.parentElement.classList.add("is-dirty");
        pointsInput.parentElement.classList.add("is-upgraded");



        /*
            we have to do this to remove all event listeners ,
            they might be added when were adding a question
         */

        let oldActionButtonOne = questionDialog.querySelector(".action-button-one");
        let newActionButtonOne = oldActionButtonOne.cloneNode(true);
        oldActionButtonOne.parentNode.replaceChild(newActionButtonOne, oldActionButtonOne);
        newActionButtonOne.innerText = "Sačuvaj";
        newActionButtonOne.addEventListener("click", (event) => editQuestionInTable(event.currentTarget, row));
        newActionButtonOne.style.display="block";


        let oldActionButtonTwo = questionDialog.querySelector(".action-button-two");
        oldActionButtonTwo.style.display= "block";
        let newActionButtonTwo = oldActionButtonTwo.cloneNode(true);
        oldActionButtonTwo.parentNode.replaceChild(newActionButtonTwo, oldActionButtonTwo);
        newActionButtonTwo.innerText = "Izbriši";
        newActionButtonTwo.addEventListener("click", (event) => {
            quizDialog.querySelector("table").deleteRow(row.rowIndex);
            questionDialog.close();
        });

        questionDialog.showModal();
    }


    function showNewQuestionDialog()
    {
        questionDialog.querySelector(".title").innerText = "Novo pitanje";
        questionDialog.querySelector(".text").value = "";
        questionDialog.querySelector(".points").value = ""
        questionDialog.querySelector(".time-to-answer").value = "";


        /*
            we have to do this to remove all event listeners ,
            they might be added when were adding a question
         */

        let oldActionButtonOne = questionDialog.querySelector(".action-button-one");
        let newActionButtonOne = oldActionButtonOne.cloneNode(true);
        oldActionButtonOne.parentNode.replaceChild(newActionButtonOne, oldActionButtonOne);
        newActionButtonOne.innerText = "Dodaj";
        newActionButtonOne.addEventListener("click", (event) => addQuestionToTable(event.currentTarget));
        newActionButtonOne.style.display = "block";


        let oldActionButtonTwo = questionDialog.querySelector(".action-button-two");
        let newActionButtonTwo = oldActionButtonTwo.cloneNode(true);
        oldActionButtonTwo.parentNode.replaceChild(newActionButtonTwo, oldActionButtonTwo);
        newActionButtonTwo.innerText = "";
        newActionButtonTwo.style.display = "none";

        questionDialog.showModal();
    }


    function saveQuizChanges(button, quizContainer)
    {
        button.disabled = true;

        const title = quizDialog.querySelector(".title").value;
        const imageUrl = quizDialog.querySelector(".image-url").value;
        const questions = [];
        let row;
        const table = quizDialog.querySelector("table");
        for(let i = 1; i < table.rows.length; ++i)
        {
            row = table.rows[i];
            questions.push({text: row.cells[0].innerText, timeToAnswer: row.cells[1].innerText, points: row.cells[2].innerText});
        }

        let quizRequest = {
            id: quizContainer.getAttribute("data-id"),
            title: title,
            imageUrl: imageUrl,
            questions : questions
        };

        let quizRequestString = JSON.stringify(quizRequest);

        let url = window.location.href;
        url = url.replace("home", "updateQuiz");

        fetch(url, {
            method: 'post',
            body: quizRequestString

        })
            .then(() =>
            {
                quizDialog.close();
                quizContainer.querySelector(".title").innerText = title;
                quizContainer.querySelector(".image-url").setAttribute("src", imageUrl);

            })
            .catch((error) => {
                console.log(error)
            })


        button.disabled = false;
    }


    function editQuestionInTable(button, row)
    {
        const questionDialog = button.parentElement.parentElement;
        row.cells[0].innerText = questionDialog.querySelector(".text").value;
        row.cells[1].innerText = questionDialog.querySelector(".time-to-answer").value;
        row.cells[2].innerText = questionDialog.querySelector(".points").value;

        questionDialog.close();
    }

    function addQuestionToTable(button) {

        button.disabled = true;

        const table = quizDialog.querySelector("table");

        let row = table.insertRow(-1);
        let c1 = row.insertCell(0);
        let c2 = row.insertCell(1);
        let c3 = row.insertCell(2);
        let c4 = row.insertCell(3);

        c1.innerText = questionDialog.querySelector(".text").value;
        c2.innerText = questionDialog.querySelector(".time-to-answer").value;
        c3.innerText = questionDialog.querySelector(".points").value;

        let editButton = document.createElement("button");
        editButton.classList.add("mdl-button");
        editButton.classList.add("mdl-js-button");
        editButton.innerText = "Edit";
        editButton.addEventListener("click", (event) => showEditQuestionDialog(event.currentTarget, row));
        c4.appendChild(editButton);

        questionDialog.close();
        button.disabled = false;
    }



    function deleteQuiz(button, quizContainer)
    {
        const userChoice = confirm("Da li sigurno želite izbrisati ovaj kviz?");
        if (!userChoice) {
            return;
        }


        let params = new URLSearchParams({
            id: quizContainer.getAttribute("data-id")
        });

        let url = window.location.href;
        url = url.replace("home", "deleteQuiz");

        fetch(url, {
            method: 'post',
            body: params
        })
            .then(() => {
                quizDialog.close();
                quizContainer.remove();

            })
            .catch((error) => {
                console.log(error)
            })

    }



        /* NEW QUIZ */

        const newQuizButton = document.getElementById("new-quiz-button");
        newQuizButton.addEventListener("click", (event) => showNewQuizDialog(event.currentTarget));


        function showNewQuizDialog(button) {

            quizDialog.querySelector("h3").innerText = "Novi kviz";
            quizDialog.querySelector(".title").value = "";
            quizDialog.querySelector(".image-url").value = "";

            const tableOfQuestions = quizDialog.querySelector("table");
            while(tableOfQuestions.rows.length > 1)
            {
                tableOfQuestions.deleteRow(tableOfQuestions.rows.length-1);
            }

            const oldActionButtonOne = quizDialog.querySelector(".action-button-one");
            const oldActionButtonTwo = quizDialog.querySelector(".action-button-two");

            let newActionButtonOne = oldActionButtonOne.cloneNode(true);
            oldActionButtonOne.parentNode.replaceChild(newActionButtonOne, oldActionButtonOne);
            newActionButtonOne.innerText = "Dodaj";
            newActionButtonOne.addEventListener("click", (event) => addNewQuiz(event.currentTarget));

            let newActionButtonTwo = oldActionButtonTwo.cloneNode(true);
            oldActionButtonTwo.parentNode.replaceChild(newActionButtonTwo, oldActionButtonTwo);
            newActionButtonTwo.innerText = "";
            newActionButtonTwo.style.display = "none";

            quizDialog.showModal();


        }


    function addNewQuiz(button)
    {
        button.disabled = true;

        const title = quizDialog.querySelector(".title").value;
        const imageUrl = quizDialog.querySelector(".image-url").value;
        const quizzesContainer = document.querySelector(".quizzes-container");

        const questions = [];
        let row;
        const table = quizDialog.querySelector("table");
        for(let i = 1; i < table.rows.length; ++i){
            row = table.rows[i];
            questions.push({text: row.cells[0].innerText, timeToAnswer: row.cells[1].innerText,
                points: row.cells[2].innerText, answerRequests: []});
        }

        let quizRequest = {
            title: title,
            imageUrl: imageUrl,
            creator: "1",
            questions: questions
        };

        let quizRequestString = JSON.stringify(quizRequest);

        let url = window.location.href;
        url = url.replace("home", "addQuiz");

        fetch(url, {
            method: 'post',
            body: quizRequestString

        })
            .then((response) => {
                return response.json();
            })
        .then((data) =>
        {
            const quizContainer = document.querySelector(".quiz-container");
            const newQuizContainer = quizContainer.cloneNode(true);
            newQuizContainer.setAttribute("data-id", data.id);

            newQuizContainer.querySelector(".title").innerText = title;
            newQuizContainer.querySelector(".image-url").setAttribute("src", imageUrl);

            newQuizContainer.querySelector(".edit-quiz-button").addEventListener("click", (event) => showEditQuizDialog(event.currentTarget));

            quizzesContainer.appendChild(newQuizContainer);


            quizDialog.close();
            button.disabled = false;

        })
        .catch((error) => {
            console.log(error)
        })


        }

    /* CLOSING DIALOG */

    const closeDialogButtons = document.querySelectorAll(".close-dialog-button");
    for(let i = 0; i < closeDialogButtons.length; ++i)
    {
        closeDialogButtons[i].addEventListener("click", (event) => closeDialog(event.currentTarget));
    }

    function closeDialog(button)
    {
        let dialog = button.parentElement;
        dialog.close();
    }


</script>

<script defer src="https://code.getmdl.io/1.3.0/material.min.js"></script>

</html>
