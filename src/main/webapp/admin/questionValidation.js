
const questionDialog = document.getElementById("question-dialog");
let actionButton = questionDialog.querySelector(".action-button-one");

const textInput = questionDialog.querySelector(".text");
let isTextValid = false;

const timeToAnswerInput = questionDialog.querySelector(".time-to-answer");
let isTimeToAnswerValid = false;

const pointsInput = questionDialog.querySelector(".points");
let isPointsValid = false;

let table = questionDialog.querySelector("table");
let isTableValid = false;

textInput.addEventListener("input", checkTextInputValidity);
timeToAnswerInput.addEventListener("input", checkTimeToAnswerValidity);
pointsInput.addEventListener("input", checkPointsValidity);

export function setupValidation()
{
    actionButton = questionDialog.querySelector(".action-button-one");
    table = questionDialog.querySelector("table");

    /* if we are editing just check all the fields */
    /* if we aren't it means we are creating a new one so action button should be disabled */
    if(actionButton.innerText == "Sačuvaj")
    {
        checkTextInputValidity();
        checkTimeToAnswerValidity();
        checkPointsValidity();
        checkTableValidity();
    }
    else{
        actionButton.disabled = true;
        table.nextElementSibling.style.visibility = "hidden";
    }
}

const observer = new MutationObserver(() => {
    checkTableValidity();
});
observer.observe(table, {subtree: true, childList: true, attributes: true});

function checkTextInputValidity() {
    isTextValid =  textInput.value.length >= 10;
    checkQuestionValidity();
}

function checkTableValidity()
{
    const errorMessage = table.nextElementSibling;
    if(table.rows.length < 3)
    {
        isTableValid = false;
        errorMessage.innerText = "Pitanje nema dovoljno odgovora!";
        errorMessage.style.visibility = "visible";
        checkQuestionValidity();
        return;
    }

    let doesQuestionHaveAnCorrectAnswer = false;
    let row;
    for(let i = 1; i < table.rows.length; ++i)
    {
        row = table.rows[i];
        if(row.cells[1].innerText == "Tačan"){
            doesQuestionHaveAnCorrectAnswer = true;
            break;
        }
    }

    if(!doesQuestionHaveAnCorrectAnswer)
    {
        isTableValid = false;
        errorMessage.innerText = "Pitanje mora imati bar jedan tačan odgovor!";
        errorMessage.style.visibility = "visible";
        checkQuestionValidity();
        return;
    }

    isTableValid = true;
    errorMessage.style.visibility = "hidden";
    checkQuestionValidity();
}

const numRegex = new RegExp("[0-9]+");
function checkTimeToAnswerValidity()
{
    const timeString = timeToAnswerInput.value;
    const errorMessage = timeToAnswerInput.nextElementSibling;
    if(!numRegex.test(timeString))
    {
        isTimeToAnswerValid = false;
        errorMessage.innerText = "Unos nije validan cijeli broj!";
        errorMessage.style.visibility = "visible";
        checkQuestionValidity();
        return;
    }

    const time = Number(timeString);
    if(time > 60)
    {
        isTimeToAnswerValid = false;
        errorMessage.innerText = "Unos ne može biti veći od 60 sekundi!";
        errorMessage.style.visibility = "visible";
        checkQuestionValidity();
        return;
    }

    if(time < 10)
    {
        isTimeToAnswerValid = false;
        errorMessage.innerText = "Unos ne može biti manji od 10 sekundi!";
        errorMessage.style.visibility = "visible";
        checkQuestionValidity();
        return;
    }


    errorMessage.style.visibility = "hidden";
    isTimeToAnswerValid = true;

    checkQuestionValidity();

}


function checkPointsValidity()
{
    const pointsString = pointsInput.value;
    const errorMessage = pointsInput.nextElementSibling;
    if(!numRegex.test(pointsString))
    {
        isPointsValid = false;
        errorMessage.innerText = "Unos nije validan cijeli broj!";
        errorMessage.style.visibility = "visible";
        checkQuestionValidity();
        return;
    }

    const points = Number(pointsString);

    if(points < 1)
    {
        isPointsValid = false;
        errorMessage.innerText = "Unos ne može biti manji od nule!";
        errorMessage.style.visibility = "visible";
        checkQuestionValidity();
        return;
    }


    errorMessage.style.visibility = "hidden";
    isPointsValid = true;

    checkQuestionValidity();

}

function checkQuestionValidity() {
    const isQuestionValid = isTextValid && isPointsValid && isTimeToAnswerValid && isTableValid;
    actionButton.disabled = !isQuestionValid;
}