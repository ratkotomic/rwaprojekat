
const answerDialog = document.getElementById("answer-dialog");
let actionButton = answerDialog.querySelector(".action-button-one");

const textInput = answerDialog.querySelector(".text");
let isTextValid = false;


textInput.addEventListener("input", checkTextInputValidity);

export function setupValidation()
{
    actionButton = answerDialog.querySelector(".action-button-one");

    /* if we are editing just check all the fields */
    /* if we aren't it means we are creating a new one so action button should be disabled */
    if(actionButton.innerText == "Sačuvaj")
    {
        checkTextInputValidity();
    }
    else{
        actionButton.disabled = true;
    }
}

function checkTextInputValidity() {
    isTextValid =  textInput.value.length >= 10;
    checkAnswerValidity();
}


function checkAnswerValidity() {
    const isAnswerValid = isTextValid;
    actionButton.disabled = !isAnswerValid;
}