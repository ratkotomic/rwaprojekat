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
                <a class="mdl-navigation__link tc-black fw-bold" href="home">Kvizovi</a>

                <%
                    if(userRole.equals("super-admin"))
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
            <a class="mdl-navigation__link  tc-black fw-bold" href="home">Kvizovi</a>
            <%
                if(userRole.equals("super-admin"))
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


        <!-- NEW QUIZ -->

        <dialog id="new-quiz-dialog" class="mdl-dialog">
            <h3 class="mdl-dialog__title text-center">Novi kviz</h3>

            <div class="mdl-dialog__content flex flex-column flex-center">

                <div class="w-100 mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                    <label class="mdl-textfield__label">Naziv</label>
                    <input class="mdl-textfield__input title" type="text">
                </div>

                <div class="w-100 mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                    <label class="mdl-textfield__label">Url Slike</label>
                    <input class="mdl-textfield__input image-url" type="text">
                </div>

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

                <button type="button" class=" new-question-button mdl-button mdl-js-button m-2">
                    Novo pitanje
                </button>


                <button type="button" id="add-quiz-button" class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored tc-primary-button">
                    Sačuvaj kviz
                </button>


            </div>

            <button type="button" class="mdl-button close close-dialog-button p-0">X</button>

        </dialog>


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


                <!-- EDIT WINDOW -->

                <dialog class="mdl-dialog edit-dialog">

                    <h3 class="mdl-dialog__title text-center">Editovanje</h3>

                    <div class="mdl-dialog__content">
                        <form class="flex flex-column gap-2">

                            <div class="w-100 mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                                <label class="mdl-textfield__label">Naziv</label>
                                <input class="mdl-textfield__input title" type="text" value="<%= quiz.getTitle() %>">
                            </div>

                            <div class="w-100 mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                                <label class="mdl-textfield__label">Url Slike</label>
                                <input class="mdl-textfield__input image-url" type="text" value="<%=quiz.getImageUrl()%>">
                            </div>
                        </form>

                        <div class="mdl-dialog__actions flex flex-row flex-space-between p-1">
                            <button type="button" class="mdl-button p-0 save-changes-button ">Sačuvaj</button>
                            <button type="button" class="mdl-button p-0 delete-button ">Izbriši</button>
                        </div>

                    </div>

                    <button type="button" class="mdl-button close close-dialog-button p-0">X</button>
                </dialog>
                <button type="button"  class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored tc-primary-button w-100 edit-button">
                    Edit
                </button>


                <button type="button" class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored tc-primary-button w-100">
                    Započni
                </button>

            </div>

            <%
                }
            %>
        </div>
    </main>
</div>


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

        <button type="button" class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored tc-primary-button action-button"></button>

    </div>
    <button type="button" class="mdl-button close close-dialog-button p-0">X</button>
</dialog>


</body>


<script>


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


    /* EDITING */

    const editButtons = document.querySelectorAll(".edit-button");
    for(let i = 0; i < editButtons.length; ++i)
    {
        editButtons[i].addEventListener("click", (event) => showEditDialog(event.currentTarget));
    }

    function showEditDialog(button)
    {
        const quizContainer = button.parentElement;
        const dialog = button.previousElementSibling;

        /* we have to do this here because when we make a new quiz container the values in the edit dialog
        remain the same as the old quiz container that we cloned
        so we just make sure that when the edit button is clicked we set the values to their correct value
         */
        dialog.querySelector(".title").value = quizContainer.querySelector(".title").innerText
        dialog.querySelector(".image-url").value =  quizContainer.querySelector(".image-url").getAttribute("src");
        dialog.showModal();

    }


    const saveChangesButtons = document.querySelectorAll(".save-changes-button");
    for(let i = 0; i < saveChangesButtons.length; ++i)
    {
        saveChangesButtons[i].addEventListener("click", (event) => saveQuizChanges(event.currentTarget));
    }


    function saveQuizChanges(button)
    {
        button.disabled = true;

        const dialog = button.parentElement.parentElement.parentElement;
        const quizContainer = dialog.parentElement;
        const title = dialog.querySelector(".title").value;
        const imageUrl = dialog.querySelector(".image-url").value;

        let quizRequest = {
            id: quizContainer.getAttribute("data-id"),
            title: title,
            imageUrl: imageUrl
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
                dialog.close();
                quizContainer.querySelector(".title").innerText = title;
                quizContainer.querySelector(".image-url").setAttribute("src", imageUrl);

            })
            .catch((error) => {
                console.log(error)
            })


        button.disabled = false;
    }



    /* DELETING */

    const deleteButtons = document.querySelectorAll(".delete-button");
    for(let i = 0; i < deleteButtons.length; ++i) {
        deleteButtons[i].addEventListener("click", (event) => deleteQuiz(event.currentTarget));
    }


    function deleteQuiz(button)
    {
        const userChoice = confirm("Da li sigurno želite izbrisati ovaj kviz?");
        if (!userChoice) {
            return;
        }

        const dialog = button.parentElement.parentElement.parentElement;
        const quizContainer = dialog.parentElement;


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
                dialog.close();
                quizContainer.remove();

            })
            .catch((error) => {
                console.log(error)
            })

    }



        /* NEW QUIZ */

        const newQuizDialog = document.getElementById("new-quiz-dialog");
        const questionDialog = document.getElementById("question-dialog");

        const newQuizButton = document.getElementById("new-quiz-button");
        const addQuizButton = document.getElementById("add-quiz-button");

        newQuizButton.addEventListener("click", () => newQuizDialog.showModal());

        // we the user click the new question button we use the question dialog
        // we set all the necessary things here
        const newQuestionButton = newQuizDialog.querySelector(".new-question-button");
        newQuestionButton.addEventListener("click", () =>
        {
            questionDialog.querySelector(".title").innerText = "Novo pitanje";
            questionDialog.querySelector(".text").value = "";
            questionDialog.querySelector(".points").value = "";
            questionDialog.querySelector(".time-to-answer").value = "";

            let oldActionButton = questionDialog.querySelector(".action-button");
            let newActionButton = oldActionButton.cloneNode(true);
            oldActionButton.parentNode.replaceChild(newActionButton, oldActionButton);
            newActionButton.innerText = "Dodaj";
            newActionButton.addEventListener("click", (event) => addQuestionToTable(event.currentTarget));

            questionDialog.showModal();
        });

        const tableOfQuestions = newQuizDialog.querySelector("table");

        /* adding a new question to the table */
        function addQuestionToTable(button) {
            button.disabled = true;
            const questionDialog = button.parentElement.parentElement;

            let row = tableOfQuestions.insertRow(-1);
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
            editButton.addEventListener("click", (event) => questionEditButton(event.currentTarget, row));
            c4.appendChild(editButton);

            questionDialog.close();
            button.disabled = false;
        }


    function questionEditButton(button, row)
    {
        questionDialog.querySelector(".title").innerText = "Pitanje edit";
        questionDialog.querySelector(".text").value = row.cells[0].innerText;
        questionDialog.querySelector(".points").value = row.cells[1].innerText;
        questionDialog.querySelector(".time-to-answer").value = row.cells[2].innerText;

        /* we have to do this to remove all event listeners ,
        they were added when were adding a question
         */
        let oldActionButton = questionDialog.querySelector(".action-button");
        let newActionButton = oldActionButton.cloneNode(true);
        oldActionButton.parentNode.replaceChild(newActionButton, oldActionButton);
        newActionButton.innerText = "Sačuvaj";
        newActionButton.addEventListener("click", (event) => editQuestionInTable(event.currentTarget, row));

        questionDialog.showModal();
    }

    function editQuestionInTable(button, row)
    {
        const questionDialog = button.parentElement.parentElement;
        row.cells[0].innerText = questionDialog.querySelector(".text").value;
        row.cells[1].innerText = questionDialog.querySelector(".points").value;
        row.cells[2].innerText = questionDialog.querySelector(".time-to-answer").value;

        questionDialog.close();

    }

    addQuizButton.addEventListener("click", (event) =>
    {
        const button = event.currentTarget;
        button.disabled = true;

        const dialog = event.target.parentElement.parentElement;
        const title = dialog.querySelector(".title").value;
        const imageUrl = dialog.querySelector(".image-url").value;
        const quizzesContainer = document.querySelector(".quizzes-container");

        const questions = [];
        let row;
        for(let i = 1; i < tableOfQuestions.rows.length; ++i){
            row = tableOfQuestions.rows[i];
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
            .then(() =>
            {
                dialog.close();

                const quizContainer = document.querySelector(".quiz-container");
                const newQuizContainer = quizContainer.cloneNode(true);

                newQuizContainer.querySelector(".title").innerText = title;
                newQuizContainer.querySelector(".image-url").setAttribute("src", imageUrl);

                newQuizContainer.querySelector(".edit-button").addEventListener("click", (event) => showEditDialog(event.currentTarget));
                newQuizContainer.querySelector(".close-dialog-button").addEventListener("click", (event) => closeDialog(event.currentTarget));
                newQuizContainer.querySelector(".save-changes-button").addEventListener("click", (event) => saveQuizChanges(event.currentTarget));
                newQuizContainer.querySelector(".delete-button").addEventListener("click", (event) => deleteQuiz(event.currentTarget));

                quizzesContainer.appendChild(newQuizContainer);


                button.disabled = false;

            })
            .catch((error) => {
                console.log(error)
            })


        });



</script>

<script defer src="https://code.getmdl.io/1.3.0/material.min.js"></script>

</html>
