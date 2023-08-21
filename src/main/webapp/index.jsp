<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="reset.css">
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


        <div class="container h-100 flex flex-column flex-center">

            <div class="wrapper py-3 w-80 px-3 flex flex-column flex-center gap-4">

                <h1 class="fs-heading"> Dobrodošli u Kviz aplikaciju</h1>

                    <div class="w-100 mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                        <label class="mdl-textfield__label" for="pin">Unesite pin za početak kviza.</label>
                        <input class="mdl-textfield__input" type="text" pattern="-?[0-9]*(\.[0-9]+)?" id="pin"
                               name="pin" title="Unos mora biti broj!">
                        <span class="mdl-textfield__error">Unos nije broj!</span>
                    </div>

                    <input type="submit" id="submit" value="Potvrdi pin"
                           class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored  tc-primary-button">
                <p>${errorMessage}</p>

            </div>
        </div>

    </main>
</div>

<script>

    const submit = document.getElementById("submit");
    submit.addEventListener("click", showQuiz);
    document.getElementById("pin").addEventListener("input", inputModified);

    function inputModified(e) {
        submit.disabled = e.target.value === "" || !e.target.checkValidity();
    }

    function redirectToNewPage() {
        window.location.href = "o_vama.jsp";
    }


    function showQuiz(){
        window.location.href = "quiz/quiz.jsp";
    }

</script>

<script defer src="https://code.getmdl.io/1.3.0/material.min.js"></script>

</body>
</html>