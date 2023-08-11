<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="index.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.cyan-deep_orange.min.css" />
</head>
<body>


<div class="container h-100 flex flex-column flex-center">

    <div class="wrapper py-3  mb-1 w-80 px-3 flex flex-column flex-center gap-4">

        <h1 class="fs-heading"> Dobrodošli u Kviz aplikaciju </h1>

        <form method="post" class="flex flex-column gap-2 w-100">

            <div class="w-100 mdl-textfield mdl-js-textfield mdl-textfield--floating-label">
                <label class="mdl-textfield__label" for="pin">Unesite pin za početak kviza.</label>
                <input class="mdl-textfield__input" type="text" pattern="-?[0-9]*(\.[0-9]+)?" id="pin" title="Unos mora biti broj!">
                <span class="mdl-textfield__error">Unos nije broj!</span>
            </div>

            <input type="submit" value="Potvrdi pin" class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored">
        </form>
        <p> Za admin pristup aplikaciji možete kliknuti <a class="" href="login"> OVDJE </a> </p>

    </div>



</div>



<script defer src="https://code.getmdl.io/1.3.0/material.min.js"></script>

</body>
</html>