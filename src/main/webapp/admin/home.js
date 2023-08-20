import {setupValidation as setupQuizValidation} from "./quizValidation.js";
import {setupValidation as setupQuestionValidation} from "./questionValidation.js";
import {setupValidation as setupAnswerValidation} from "./answerValidation.js";

const tabLinks = document.querySelectorAll('.mdl-navigation__link');
const tabContents = document.querySelectorAll('.tab-content');

tabLinks.forEach(tabLink => {
    tabLink.addEventListener('click', event => {
        event.preventDefault();
        const targetId = event.target.getAttribute('href').substring(1);

        tabContents.forEach(tabContent => {
            if (tabContent.id === targetId) {
                tabContent.style.display = 'block';
            } else {
                tabContent.style.display = 'none';
            }
        });
    });
});


const quizDialog = document.getElementById("quiz-dialog");
const questionDialog = document.getElementById("question-dialog");
const answerDialog = document.getElementById("answer-dialog");
const userDialog = document.getElementById("new-user-dialog");


/* QUIZ DIALOG */


/*
    This part is for when the quiz dialog is used when the edit button,
    of an already existing quiz, is clicked
    we make a fetch call to get the quiz and then we fill out the dialog
 */

const editQuizButtons = document.querySelectorAll(".edit-quiz-button");
editQuizButtons.forEach((button) => button.addEventListener("click", (event) => showEditQuizDialog((button))));


document.getElementById("new-question-button").addEventListener("click", (event) => showNewQuestionDialog(event.currentTarget));
document.getElementById("new-answer-button").addEventListener("click", (event) => showNewAnswerDialog(event.currentTarget));

function showEditQuizDialog(button) {

    const quizContainer = button.parentElement;
    const quizId = quizContainer.getAttribute("data-id");

    let url = window.location.href;
    url = url.replace("home", "getQuiz");
    const params = new URLSearchParams({id: quizId});

    fetch(url + "?" + params)
        .then((response) => {
            return response.json();
        })
        .then((data) => {
            let quizObject = data;

            quizDialog.querySelector("h3").innerText = "Kviz Edit";
            const titleInput = quizDialog.querySelector(".title");
            titleInput.value = quizObject.title;
            titleInput.parentElement.classList.add("is-dirty");
            titleInput.parentElement.classList.add("is-upgraded");
            titleInput.parentElement.classList.remove("is-invalid");

            const imageUrlInput = quizDialog.querySelector(".image-url");
            imageUrlInput.value = quizObject.imageUrl;
            imageUrlInput.parentElement.classList.add("is-dirty");
            imageUrlInput.parentElement.classList.add("is-upgraded");
            imageUrlInput.parentElement.classList.remove("is-invalid");

            const tableOfQuestions = quizDialog.querySelector("table");
            while (tableOfQuestions.rows.length > 1) {
                tableOfQuestions.deleteRow(tableOfQuestions.rows.length - 1);
            }

            let question;
            for (let i = 0; i < quizObject.questions.length; ++i) {
                question = quizObject.questions[i];
                let row = tableOfQuestions.insertRow(-1);
                row.setAttribute("question-id", question.id);
                let c1 = row.insertCell(0);
                let c2 = row.insertCell(1);
                let c3 = row.insertCell(2);
                let c4 = row.insertCell(3);
                let c5 = row.insertCell(4);

                c1.innerText = question.questionText;
                c2.innerText = question.timeToAnswer;
                c3.innerText = question.points;


                let editButton = document.createElement("button");
                editButton.classList.add("mdl-button");
                editButton.classList.add("mdl-js-button");
                editButton.innerText = "Edit";
                editButton.addEventListener("click", (event) => showEditQuestionDialog(event.currentTarget, row));
                c4.appendChild(editButton);

                let answersTable = questionDialog.querySelector("table").cloneNode(true);
                while (answersTable.rows.length > 1) {
                    answersTable.deleteRow(answersTable.rows.length - 1);
                }
                let answers = question.answers;
                let answer;
                for (let j = 0; j < answers.length; ++j) {
                    answer = answers[j];
                    let row = answersTable.insertRow(-1);
                    row.setAttribute("answer-id", answer.id);
                    let c1 = row.insertCell(0);
                    let c2 = row.insertCell(1);
                    let c3 = row.insertCell(2);

                    let editButton = document.createElement("button");
                    editButton.classList.add("mdl-button");
                    editButton.classList.add("mdl-js-button");
                    editButton.innerText = "Edit";
                    editButton.addEventListener("click", (event) => showEditAnswerDialog(event.currentTarget, event.currentTarget.parentElement.parentElement));
                    c3.appendChild(editButton);

                    c1.innerText = answer.answerText;
                    if (answer.correct) {
                        c2.innerText = "Tačan";
                    } else {
                        c2.innerText = "Netačan"
                    }
                }

                c5.append(answersTable);
                answersTable.style.display = "none";
                c5.style.display = "none";

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

            setupQuizValidation();
            quizDialog.showModal();
        })
        .catch(() => {
            throw new Error("Get quiz failed!");
        })

}


/* while editing a quiz the user might decide to edit a question */

function showEditQuestionDialog(button, row) {
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
    newActionButtonOne.style.display = "block";


    let oldActionButtonTwo = questionDialog.querySelector(".action-button-two");
    oldActionButtonTwo.style.display = "block";
    let newActionButtonTwo = oldActionButtonTwo.cloneNode(true);
    oldActionButtonTwo.parentNode.replaceChild(newActionButtonTwo, oldActionButtonTwo);
    newActionButtonTwo.innerText = "Izbriši";
    newActionButtonTwo.addEventListener("click", (event) => {
        quizDialog.querySelector("table").deleteRow(row.rowIndex);
        questionDialog.close();
    });

    const orgTable = row.cells[4].firstElementChild;
    const newTable = orgTable.cloneNode(true);
    newTable.style.display = "block";

    const oldTable = questionDialog.querySelector("table");
    oldTable.parentElement.replaceChild(newTable, oldTable);
    const editButtons = newTable.querySelectorAll("button");
    if (editButtons != null) {
        for (let i = 0; i < editButtons.length; ++i)
            editButtons[i].addEventListener("click", (event) => showEditAnswerDialog(event.currentTarget, event.currentTarget.parentElement.parentElement));
    }
    getComputedStyle(newTable);
    setupQuestionValidation();
    questionDialog.showModal();
}

function showEditAnswerDialog(button, row) {
    answerDialog.querySelector(".title").innerText = "Odgovor edit";
    const textInput = answerDialog.querySelector(".text");
    textInput.value = row.cells[0].innerText;
    textInput.parentElement.classList.add("is-dirty")
    textInput.parentElement.classList.add("is-upgraded");


    const checkbox = answerDialog.querySelector(".is-correct");
    checkbox.checked = (row.cells[1].innerText == "Tačan");


    /*
        we have to do this to remove all event listeners ,
        they might be added when were adding a question
     */

    let oldActionButtonOne = answerDialog.querySelector(".action-button-one");
    let newActionButtonOne = oldActionButtonOne.cloneNode(true);
    oldActionButtonOne.parentNode.replaceChild(newActionButtonOne, oldActionButtonOne);
    newActionButtonOne.innerText = "Sačuvaj";
    newActionButtonOne.addEventListener("click", (event) => editAnswerInTable(event.currentTarget, row));
    newActionButtonOne.style.display = "block";


    let oldActionButtonTwo = answerDialog.querySelector(".action-button-two");
    oldActionButtonTwo.style.display = "block";
    let newActionButtonTwo = oldActionButtonTwo.cloneNode(true);
    oldActionButtonTwo.parentNode.replaceChild(newActionButtonTwo, oldActionButtonTwo);
    newActionButtonTwo.innerText = "Izbriši";
    newActionButtonTwo.addEventListener("click", (event) => {
        questionDialog.querySelector("table").deleteRow(row.rowIndex);
        answerDialog.close();
    });

    setupAnswerValidation();
    answerDialog.showModal();
}


function showNewQuestionDialog() {
    questionDialog.querySelector(".title").innerText = "Novo pitanje";
    questionDialog.querySelector(".text").value = "";
    questionDialog.querySelector(".points").value = ""
    questionDialog.querySelector(".time-to-answer").value = "";

    const table = questionDialog.querySelector("table");
    while (table.rows.length > 1) {
        table.deleteRow(table.rows.length - 1);
    }

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

    setupQuestionValidation();
    questionDialog.showModal();
}

function showNewAnswerDialog() {
    answerDialog.querySelector(".title").innerText = "Novi odgovor";
    answerDialog.querySelector(".text").value = "";
    answerDialog.querySelector(".is-correct").checked = false;

    /*
        we have to do this to remove all event listeners ,
        they might be added when were adding a question
     */

    let oldActionButtonOne = answerDialog.querySelector(".action-button-one");
    let newActionButtonOne = oldActionButtonOne.cloneNode(true);
    oldActionButtonOne.parentNode.replaceChild(newActionButtonOne, oldActionButtonOne);
    newActionButtonOne.innerText = "Dodaj";
    newActionButtonOne.addEventListener("click", (event) => addAnswerToTable(event.currentTarget));
    newActionButtonOne.style.display = "block";


    let oldActionButtonTwo = answerDialog.querySelector(".action-button-two");
    let newActionButtonTwo = oldActionButtonTwo.cloneNode(true);
    oldActionButtonTwo.parentNode.replaceChild(newActionButtonTwo, oldActionButtonTwo);
    newActionButtonTwo.innerText = "";
    newActionButtonTwo.style.display = "none";

    setupAnswerValidation();
    answerDialog.showModal();
}


function saveQuizChanges(button, quizContainer) {
    button.disabled = true;

    const title = quizDialog.querySelector(".title").value;
    const imageUrl = quizDialog.querySelector(".image-url").value;
    const questions = [];
    let row;
    const questionsTable = quizDialog.querySelector("table");

    let answersTable;
    let answerRow;
    let answers = [];
    for (let i = 1; i < questionsTable.rows.length; ++i) {
        answers = [];
        row = questionsTable.rows[i];
        answersTable = questionsTable.rows[i].cells[4].firstElementChild;
        for (let j = 1; j < answersTable.rows.length; ++j) {
            answerRow = answersTable.rows[j];
            answers.push({
                id: answerRow.getAttribute("answer-id"),
                text: answerRow.cells[0].innerText,
                correct: (answerRow.cells[1].innerText == "Tačan")
            });
        }
        questions.push({
            id: row.getAttribute("question-id"),
            text: row.cells[0].innerText,
            timeToAnswer: row.cells[1].innerText,
            points: row.cells[2].innerText,
            questionNumber: i,
            answerRequests: answers
        });
    }

    let quizRequest = {
        id: quizContainer.getAttribute("data-id"),
        title: title,
        imageUrl: imageUrl,
        questions: questions
    };

    let quizRequestString = JSON.stringify(quizRequest);

    let url = window.location.href;
    url = url.replace("home", "updateQuiz");

    fetch(url, {
        method: 'post',
        body: quizRequestString

    })
        .then(() => {
            quizDialog.close();
            quizContainer.querySelector(".title").innerText = title;
            quizContainer.querySelector(".image-url").setAttribute("src", imageUrl);

        })
        .catch((error) => {
            console.log(error)
        })


    button.disabled = false;
}


function editQuestionInTable(button, row) {
    button.disabled = true;
    row.cells[0].innerText = questionDialog.querySelector(".text").value;
    row.cells[1].innerText = questionDialog.querySelector(".time-to-answer").value;
    row.cells[2].innerText = questionDialog.querySelector(".points").value;
    row.cells[4].firstElementChild.remove();
    row.cells[4].appendChild(questionDialog.querySelector("table").cloneNode(true));
    questionDialog.close();
    button.disabled = false;
}


function editAnswerInTable(button, row) {
    button.disabled = true;
    row.cells[0].innerText = answerDialog.querySelector(".text").value;
    if (answerDialog.querySelector(".is-correct").checked) {
        row.cells[1].innerText = "Tačan";
    } else {
        row.cells[1].innerText = "Netačan";
    }
    answerDialog.close();
    button.disabled = false;
}

function addQuestionToTable(button) {

    button.disabled = true;

    const table = quizDialog.querySelector("table");

    let row = table.insertRow(-1);
    let c1 = row.insertCell(0);
    let c2 = row.insertCell(1);
    let c3 = row.insertCell(2);
    let c4 = row.insertCell(3);
    let c5 = row.insertCell(4);

    c1.innerText = questionDialog.querySelector(".text").value;
    c2.innerText = questionDialog.querySelector(".time-to-answer").value;
    c3.innerText = questionDialog.querySelector(".points").value;
    let answersTable = questionDialog.querySelector("table").cloneNode(true);
    answersTable.style.display = "none";
    c5.appendChild(answersTable);
    c5.style.display = "none";

    let editButton = document.createElement("button");
    editButton.classList.add("mdl-button");
    editButton.classList.add("mdl-js-button");
    editButton.innerText = "Edit";
    editButton.addEventListener("click", (event) => showEditQuestionDialog(event.currentTarget, row));
    c4.appendChild(editButton);

    questionDialog.close();
    button.disabled = false;
}


function addAnswerToTable(button) {
    button.disabled = true;

    const answerTable = questionDialog.querySelector("table");

    let row = answerTable.insertRow(-1);
    let c1 = row.insertCell(0);
    let c2 = row.insertCell(1);
    let c3 = row.insertCell(2);

    c1.innerText = answerDialog.querySelector(".text").value;
    if (answerDialog.querySelector(".is-correct").checked) {
        c2.innerText = "Tačan";
    } else {
        c2.innerText = "Netačan";
    }

    let editButton = document.createElement("button");
    editButton.classList.add("mdl-button");
    editButton.classList.add("mdl-js-button");
    editButton.innerText = "Edit";
    editButton.addEventListener("click", (event) => showEditAnswerDialog(event.currentTarget, row));
    c3.appendChild(editButton);

    answerDialog.close();

    button.disabled = false;
}


function deleteQuiz(button, quizContainer) {
    button.disabled = true;
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
    button.disabled = false;
}


/* NEW QUIZ */

const newQuizButton = document.getElementById("new-quiz-button");
newQuizButton.addEventListener("click", (event) => showNewQuizDialog(event.currentTarget));


function showNewQuizDialog() {

    quizDialog.querySelector("h3").innerText = "Novi kviz";
    const titleInput = quizDialog.querySelector(".title");
    titleInput.value = "";
    titleInput.parentElement.classList.remove("is-invalid");

    const imageUrlInput = quizDialog.querySelector(".image-url");
    imageUrlInput.value = "";
    imageUrlInput.parentElement.classList.remove("is-invalid");

    const tableOfQuestions = quizDialog.querySelector("table");
    while (tableOfQuestions.rows.length > 1) {
        tableOfQuestions.deleteRow(tableOfQuestions.rows.length - 1);
    }

    const oldActionButtonOne = quizDialog.querySelector(".action-button-one");
    const oldActionButtonTwo = quizDialog.querySelector(".action-button-two");

    let newActionButtonOne = oldActionButtonOne.cloneNode(true);
    newActionButtonOne.innerText = "Dodaj";
    oldActionButtonOne.parentNode.replaceChild(newActionButtonOne, oldActionButtonOne);
    newActionButtonOne.addEventListener("click", (event) => addNewQuiz(event.currentTarget));

    let newActionButtonTwo = oldActionButtonTwo.cloneNode(true);
    oldActionButtonTwo.parentNode.replaceChild(newActionButtonTwo, oldActionButtonTwo);
    newActionButtonTwo.innerText = "";
    newActionButtonTwo.style.display = "none";

    setupQuizValidation();
    quizDialog.showModal();


}


function addNewQuiz(button) {
    button.disabled = true;

    const title = quizDialog.querySelector(".title").value;
    const imageUrl = quizDialog.querySelector(".image-url").value;
    const quizzesContainer = document.querySelector(".quizzes-container");

    const questions = [];
    let answers = [];
    let answer;
    let row;

    const table = quizDialog.querySelector("table");
    for (let i = 1; i < table.rows.length; ++i) {
        row = table.rows[i];
        answers = [];
        for (let j = 1; j < row.cells[4].firstElementChild.rows.length; ++j) {
            answer = row.cells[4].firstElementChild.rows[j];
            answers.push({text: answer.cells[0].innerText, correct: answer.cells[1].innerText == "Tačan"});
        }


        questions.push({
            text: row.cells[0].innerText, timeToAnswer: row.cells[1].innerText,
            points: row.cells[2].innerText, questionNumber: i, answerRequests: answers
        });
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
        .then((data) => {
            const quizContainer = document.querySelector(".quiz-container");

            /* if the quiz container is null we have to make a brand new one */
            if(quizContainer != null)
            {
                const newQuizContainer = quizContainer.cloneNode(true);
                newQuizContainer.setAttribute("data-id", data.id);

                newQuizContainer.querySelector(".title").innerText = title;
                newQuizContainer.querySelector(".image-url").setAttribute("src", imageUrl);

                newQuizContainer.querySelector(".edit-quiz-button").addEventListener("click", (event) => showEditQuizDialog(event.currentTarget));

                quizzesContainer.appendChild(newQuizContainer);
            }
            else
            {
                const quizContainer = document.createElement("DIV");
                quizContainer.classList.add("quiz-container");
                quizContainer.classList.add("flex");
                quizContainer.classList.add("flex-column");
                quizContainer.classList.add("flex-center");
                quizContainer.classList.add("gap-1");
                quizContainer.classList.add("p-2");
                quizContainer.setAttribute("data-id", data.id);

                const h2 = document.createElement("H2");
                h2.classList.add("title");
                h2.innerText = title;
                quizContainer.appendChild(h2);

                const img = document.createElement("IMG");
                img.classList.add("image-url");
                img.setAttribute("src", imageUrl);
                quizContainer.appendChild(img);

                const editQuizButton = document.createElement("BUTTON");
                editQuizButton.classList.add("mdl-button");
                editQuizButton.classList.add("mdl-js-button");
                editQuizButton.classList.add("mdl-button--raised");
                editQuizButton.classList.add("mdl-button--colored");
                editQuizButton.classList.add("tc-primary-button");
                editQuizButton.classList.add("w-100");
                editQuizButton.classList.add("edit-quiz-button");
                editQuizButton.setAttribute("type", "button");
                editQuizButton.innerText = "Edit";
                editQuizButton.addEventListener("click", (event) => showEditQuizDialog(event.currentTarget));
                quizContainer.appendChild(editQuizButton);

                const startQuizButton = document.createElement("BUTTON");
                startQuizButton.classList.add("mdl-button");
                startQuizButton.classList.add("mdl-js-button");
                startQuizButton.classList.add("mdl-button--raised");
                startQuizButton.classList.add("mdl-button--colored");
                startQuizButton.classList.add("tc-primary-button");
                startQuizButton.classList.add("w-100");
                startQuizButton.classList.add("start-quiz-button");
                startQuizButton.setAttribute("type", "button");
                startQuizButton.innerText = "Započni";
                quizContainer.appendChild(startQuizButton);

                /* todo */
                /* when we add the start functinoality we need to add the event listener here as well */

                quizzesContainer.appendChild(quizContainer);
            }


            quizDialog.close();
            button.disabled = false;

        })
        .catch((error) => {
            console.log(error)
        })


}

/* CLOSING DIALOG */

const closeDialogButtons = document.querySelectorAll(".close-dialog-button");
for (let i = 0; i < closeDialogButtons.length; ++i) {
    closeDialogButtons[i].addEventListener("click", (event) => closeDialog(event.currentTarget));
}

function closeDialog(button) {
    let dialog = button.parentElement;
    dialog.close();
}


const newUserButton = document.getElementById("new-user-button");
newUserButton.addEventListener("click", (event) => showNewUserDialog(event.currentTarget));


function showNewUserDialog(button) {

    userDialog.querySelector("h3").innerText = "Novi korisnik";
    userDialog.querySelector(".username").value = "";
    userDialog.querySelector(".password").value = "";
    userDialog.querySelector(".role").value = "";

    const oldActionButtonOne = userDialog.querySelector(".action-button-one");
    const oldActionButtonTwo = userDialog.querySelector(".action-button-two");

    let newActionButtonOne = oldActionButtonOne.cloneNode(true);
    oldActionButtonOne.parentNode.replaceChild(newActionButtonOne, oldActionButtonOne);
    newActionButtonOne.innerText = "Dodaj";
    newActionButtonOne.addEventListener("click", (event) => addNewUser(event.currentTarget));

    let newActionButtonTwo = oldActionButtonTwo.cloneNode(true);
    oldActionButtonTwo.parentNode.replaceChild(newActionButtonTwo, oldActionButtonTwo);
    newActionButtonTwo.innerText = "";
    newActionButtonTwo.style.display = "none";

    userDialog.showModal();
}


function addNewUser(button) {
    button.disabled = true;

    const username = userDialog.querySelector(".username").value;
    const password = userDialog.querySelector(".password").value;
    const role = userDialog.querySelector(".role").value;
    const quizzesContainer = document.querySelector(".users-container");


    let url = window.location.href;
    url = url.replace("home", "addUser") + "?username=" + username + "&password=" + password + "&role=" + role;

    fetch(url, {
        method: 'POST'
    })
        .then((response) => {
            return response.json();
        })
        .then((data) => {
            const userContainer = document.querySelector(".user-container");
            const newUserContainer = userContainer.cloneNode(true);

            console.log(newUserContainer)

            newUserContainer.setAttribute("id", data.id)
            newUserContainer.setAttribute("username", data.username)
            newUserContainer.querySelector(".username").innerText = 'Username: ' + username;
            newUserContainer.querySelector(".password").innerText = 'Password: ' + password;
            newUserContainer.querySelector(".role").innerText = 'Role: ' + role;

            newUserContainer.querySelector(".edit-user-button").addEventListener("click", (event) => showEditUserDialog(event.currentTarget));

            quizzesContainer.appendChild(newUserContainer);

            userDialog.close();
            button.disabled = false;

        })
        .catch((error) => {
            console.log(error)
        })
}

const editUserButtons = document.querySelectorAll(".edit-user-button");
editUserButtons.forEach((button) => button.addEventListener("click", (event) => showEditUserDialog((button))));


function showEditUserDialog(button) {

    const quizContainer = button.parentElement;
    const userId = quizContainer.getAttribute("id");

    let url = window.location.href;
    url = url.replace("home", "getUser");
    const params = new URLSearchParams({id: userId});

    fetch(url + "?" + params)
        .then((response) => {
            return response.json();
        })
        .then((data) => {
            let userObject = data;

            userDialog.querySelector("h3").innerText = "Editovanje";
            const usernameInput = userDialog.querySelector(".username");
            usernameInput.value = userObject.username;
            usernameInput.parentElement.classList.add("is-dirty");
            usernameInput.parentElement.classList.add("is-upgraded");

            const passwordInput = userDialog.querySelector(".password");
            passwordInput.value = userObject.password;
            passwordInput.parentElement.classList.add("is-dirty");
            passwordInput.parentElement.classList.add("is-upgraded");

            const roleInput = userDialog.querySelector(".role");
            roleInput.value = userObject.role;
            roleInput.parentElement.classList.add("is-dirty");
            roleInput.parentElement.classList.add("is-upgraded");


            const oldActionButtonOne = userDialog.querySelector(".action-button-one");
            const oldActionButtonTwo = userDialog.querySelector(".action-button-two");

            let newActionButtonOne = oldActionButtonOne.cloneNode(true);
            oldActionButtonOne.parentNode.replaceChild(newActionButtonOne, oldActionButtonOne);
            newActionButtonOne.innerText = "Sačuvaj";
            newActionButtonOne.addEventListener("click", (event) => saveUserChanges(event.currentTarget, quizContainer));

            oldActionButtonTwo.style.display = "block";
            let newActionButtonTwo = oldActionButtonTwo.cloneNode(true);
            oldActionButtonTwo.parentNode.replaceChild(newActionButtonTwo, oldActionButtonTwo);
            newActionButtonTwo.innerText = "Izbriši";
            newActionButtonTwo.addEventListener("click", (event) => deleteUser(event.currentTarget, quizContainer));

            userDialog.showModal();
        })
        .catch(() => {
            throw new Error("Get user failed!");
        })
}


function deleteUser(button, quizContainer) {
    const userChoice = confirm("Da li sigurno želite izbrisati ovog usera?");
    if (!userChoice) {
        return;
    }

    let params = new URLSearchParams({
        id: quizContainer.getAttribute("id")
    });

    let url = window.location.href;
    url = url.replace("home", "deleteUser");

    fetch(url, {
        method: 'post',
        body: params
    })
        .then(() => {
            userDialog.close();
            quizContainer.remove();

        })
        .catch((error) => {
            console.log(error)
        })
}


function saveUserChanges(button, quizContainer) {
    button.disabled = true;

    const id = quizContainer.getAttribute("id")
    const username = userDialog.querySelector(".username").value;
    const password = userDialog.querySelector(".password").value;
    const role = userDialog.querySelector(".role").value;

    let url = window.location.href;
    url = url.replace("home", "updateUser") + "?id=" + id + "&username=" + username + "&password=" + password + "&role=" + role;

    fetch(url, {
        method: 'post',
    })
        .then(() => {
            userDialog.close();
            quizContainer.querySelector(".username").innerText = 'Username: ' + username;
            quizContainer.querySelector(".password").innerText = 'Password: ' + password;
            quizContainer.querySelector(".role").innerText = 'Role: ' + role;

        })
        .catch((error) => {
            console.log(error)
        })
    button.disabled = false;
}