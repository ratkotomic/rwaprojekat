<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>QuizTopia</title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="reset.css">
    <link rel="stylesheet" href="index.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.cyan-deep_orange.min.css"/>
    <script defer src="https://code.getmdl.io/1.3.0/material.min.js"></script>
</head>
<body>

<div class="mdl-layout mdl-js-layout mdl-layout--fixed-header">
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
            <div class="wrapper py-1 w-80 px-2 flex flex-column flex-center gap-2">
                <h1 class="fs-heading"> O vama </h1>
                <p> Ispod možete unijeti svoje ime i prezime.Ovo koristimo da vas mozemo prikazati u ranking listi
                    naspram drugih takmicara.</p>

                <form method="post" action="" class="flex flex-column gap-1 w-100">
                    <div class="w-100 mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                        <label class="mdl-textfield__label" for="ime"> Ime</label>
                        <input class="mdl-textfield__input" type="text" id="ime" name="ime">
                    </div>
                    <div class="w-100 mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                        <label class="mdl-textfield__label" for="prezime">Prezime</label>
                        <input class="mdl-textfield__input" type="text" id="prezime" name="prezime">
                    </div>
                    <input id="submit" type="submit" value="Pocetak"
                           class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored tc-primary-button">
                </form>
                <p>${errorMessage}</p>
            </div>
        </div>
    </main>
</div>

</body>
</html>

