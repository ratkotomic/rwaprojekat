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
        <div class="quizzes-container flex flex-row flex-wrap gap-2">
            <%

                List<Quiz> quizList = (List<Quiz>)request.getAttribute("quizList");

                for (Quiz quiz : quizList)
                {
            %>
            <div class="quiz-container flex flex-column flex-center gap-1 p-2" data-id="<%= quiz.getId()%>">
                <h2 class="title"><%= quiz.getTitle() %></h2>
                <img class="image-url" src="<%= quiz.getImageUrl() %>">

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

</body>


<script>

    const editButtons = document.querySelectorAll(".edit-button");
    for(let i = 0; i < editButtons.length; ++i)
    {
        let dialog;
        editButtons[i].addEventListener("click", () =>
        {
            dialog = editButtons[i].previousElementSibling;
            dialog.showModal();
        });
    }


    const closeDialogButtons = document.querySelectorAll(".close-dialog-button");

    for(let i = 0; i < closeDialogButtons.length; ++i)
    {
        let dialog;
        closeDialogButtons[i].addEventListener("click", () =>
        {
            dialog = closeDialogButtons[i].parentElement;
            dialog.close();
        });
    }



    const saveChangesButtons = document.querySelectorAll(".save-changes-button");
    for(let i = 0; i < saveChangesButtons.length; ++i)
    {
        saveChangesButtons[i].addEventListener("click", (event) =>
        {
            event.target.disabled = true;

            const dialog = saveChangesButtons[i].parentElement.parentElement.parentElement;
            const quizContainer = dialog.parentElement;
            const title = dialog.querySelector(".title").value;
            const imageUrl = dialog.querySelector(".image-url").value;

            let quizRequest = {
                id: quizContainer.getAttribute("data-id"),
                title: title,
                imageUrl: imageUrl
            };

            let quizRequestString = JSON.stringify(quizRequest);


            fetch("http://localhost:8080/rwaprojekat_war_exploded/admin/updateQuiz", {
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


            event.target.disabled = false;

        });
    }



    const deleteButtons = document.querySelectorAll(".delete-button");
    for(let i = 0; i < deleteButtons.length; ++i)
    {
        let dialog;
        deleteButtons[i].addEventListener("click", () =>
        {
            const userChoice = confirm("Da li sigurno želite izbrisati ovaj kviz?");
            if(!userChoice)
            {
                return;
            }

            const dialog = deleteButtons[i].parentElement.parentElement.parentElement;
            const quizContainer = dialog.parentElement;


            let params = new URLSearchParams({
                id: quizContainer.getAttribute("data-id")
            });

            fetch("http://localhost:8080/rwaprojekat_war_exploded/admin/deleteQuiz", {
                method: 'post',
                body: params
            })
            .then(() =>
            {
                dialog.close();
                quizContainer.remove();

            })
            .catch((error) => {
                console.log(error)
            })


        });
    }


</script>

<script defer src="https://code.getmdl.io/1.3.0/material.min.js"></script>

</html>
