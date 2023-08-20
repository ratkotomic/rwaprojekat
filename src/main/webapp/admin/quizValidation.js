
const quizDialogCurr = document.getElementById("quiz-dialog");
let actionButton = quizDialogCurr.querySelector(".action-button-one");

const titleInput = quizDialogCurr.querySelector(".title");
let isTitleValid = false;

const imageUrlInput = quizDialogCurr.querySelector(".image-url");
let isImageUrlValid = false;

const table = quizDialogCurr.querySelector("table");
let isTableValid = false;

titleInput.addEventListener("input", checkTitleValidity);
imageUrlInput.addEventListener("input", checkImageUrlValidity);

export function setupValidation()
{
    actionButton = quizDialogCurr.querySelector(".action-button-one");

    /* if we are editing just check all the fields */
    /* if we aren't it means we are creating a new one so action button should be disabled */
    if(actionButton.innerText == "Sačuvaj")
    {
        checkImageUrlValidity();
        checkTableValidity();
        checkTitleValidity();
        checkQuizValidity();
    }
    else{
        actionButton.disabled = true;
        table.nextElementSibling.style.visibility = "hidden";
    }
}

const observer = new MutationObserver(() => {
    checkTableValidity();
});
observer.observe(table, {subtree: true, childList: true});

function checkTitleValidity() {
    isTitleValid =  titleInput.value.length >= 4;
    checkQuizValidity();
}

function checkTableValidity()
{
    /* todo */
    /* for testing purposes i've set it to 3 but it should be set to 11 */
    /* 10 questions and 1 header row */
    isTableValid = table.rows.length >= 3;
    if(!isTableValid)
    {
        table.nextElementSibling.style.visibility = "visible";
    }
    else
    {
        table.nextElementSibling.style.visibility = "hidden";
    }
    checkQuizValidity();
}
function checkImageUrlValidity() {
    const imageUrl = imageUrlInput.value;

    fetch(imageUrl)
        .then(response => {
            isImageUrlValid = response.ok;
            if (!isImageUrlValid) {
                imageUrlInput.parentElement.classList.add("is-invalid");
                imageUrlInput.nextElementSibling.innerText = "Url nije validan!";
                return;
            }

            let contentType = response.headers.get("Content-Type");
            isImageUrlValid = contentType && contentType.includes("image");
            if (!isImageUrlValid) {
                imageUrlInput.parentElement.classList.add("is-invalid");
                imageUrlInput.nextElementSibling.innerText = "Url ne pokazuje na sliku!";
                return;
            }

            imageUrlInput.parentElement.classList.remove("is-invalid");
            checkQuizValidity();

        })
        .catch(error => {
            console.error('Error validating image URL:', error);
            isImageUrlValid = false;
            imageUrlInput.parentElement.classList.add("is-invalid");
            imageUrlInput.nextElementSibling.innerText = "Url nije validan!";
            checkQuizValidity();
        });

}

function checkQuizValidity() {
    const isQuizValid = isImageUrlValid && isTitleValid && isTableValid;
    actionButton.disabled = !isQuizValid;
}