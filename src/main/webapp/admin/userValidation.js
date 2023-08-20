const userDialog = document.getElementById("new-user-dialog");
let action = userDialog.querySelector(".action-button-one");

const usernameInput = userDialog.querySelector(".username");
const passwordInput = userDialog.querySelector(".password");
const role = document.getElementById("role-select");

usernameInput.addEventListener("input", checkUserValidity);
passwordInput.addEventListener("input", checkUserValidity);
role.addEventListener("change", checkUserValidity);

function checkUserValidity()
{
    action.disabled = usernameInput.value === "" || passwordInput.value === "" || !passwordInput.checkValidity() || role.value === "";
}


export function setupValidation()
{
    action = userDialog.querySelector(".action-button-one");
    if(action.innerText == "Dodaj")
    {
        action.disabled = true;
    }
}