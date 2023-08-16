<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 8/11/2023
  Time: 2:16 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <title>Registracija</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="Authorization/register.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.cyan-deep_orange.min.css" />
</head>
<body>


<div class="container h-100 flex flex-column flex-center">

    <div class="wrapper py-3  mb-1 w-80 px-3 flex flex-column gap-2">

        <h1 class="fs-heading"> Registracija </h1>

        <form method="post" class="flex flex-column gap-2">

            <div class="w-100 mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                <label class="mdl-textfield__label" for="username">Korisničko ime</label>
                <input class="mdl-textfield__input" type="text" id="username" name="username">
            </div>

            <div class="w-100 mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                <label class="mdl-textfield__label" for="password">Šifra</label>
                <input class="mdl-textfield__input" type="password" id="password" name="password" pattern=".{8,}" title="Šifra mora sadržavati minimalno 8 karaktera.">
                <span class="mdl-textfield__error"> Šifra mora biti minimalno 8 karaktera! </span>
            </div>


            <input id="submit" type="submit" value="Registruj se" class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored tc-primary-button" disabled>
        </form>

        <%
            Object errorMessage = request.getAttribute("errorMessage");
            if(errorMessage != null)
            {
        %>
        <p class="tc-error"><%= errorMessage.toString() %></p>
        <%
            }
        %>


        <p>Već imate račun? Kliknite <a class="tc-link" href="login"> OVDJE </a> </p>


        <!--
        Nakon sto se posalje post treba mi neka bool varijabla koja ce mi reci da li je registracija bila uspijesana ili ne.
        Ako nije bilo uspijesno treba mi razlog zasto nije bilo uspijesno.
        Ovo bi bilo bolje raditi sa ajax.

        Pseudo kod:

        if(variable != null)
        {
        if(variable)
        {
        <p> Registracija je uspijesna. Slijedi redirekcija na login. </p>
        }
        else
        {
        <p> Registracija nije bila uspijesna. ErrorMessage </p>
        }

        }

        -->






    </div>



</div>


<script>
    const submit = document.getElementById("submit");

    const usernameInput = document.getElementById("username");
    const passwordInput = document.getElementById("password");

    usernameInput.addEventListener("input", inputModified);
    passwordInput.addEventListener("input", inputModified);

    function inputModified()
    {
        submit.disabled = usernameInput.value === "" || passwordInput.value === "" || !passwordInput.checkValidity();
    }

</script>


<script defer src="https://code.getmdl.io/1.3.0/material.min.js"></script>


</body>
</html>
