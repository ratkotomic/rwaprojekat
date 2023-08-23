function generatePin(quizId, userId, url) {

}

function showAlert(message) {
    alert(message);
}

const startButtons = document.querySelectorAll('.start-quiz-button');
startButtons.forEach(button => {
    button.addEventListener("click", (event) => startQuiz(event.currentTarget));
});

function startQuiz(button) {
    const quizId = button.closest('.quiz-container').getAttribute('data-id');
    const userId = button.closest('.quiz-container').getAttribute('creator');

    let url = window.location.href;
    url = url.replace("home", "generatePin");

    fetch(url, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: 'quizId=' + quizId + '&userId=' + userId,
    })
        .then((response => {
            if (response.ok) {
                return response.json();
            } else {
                showAlert('Došlo je do greške prilikom generisanja PIN-a.');
            }
        }))
        .then(data => {
            window.localStorage.setItem("game", JSON.stringify(data));
            let url = window.location.href;
            url = url.replace("admin/home", "quiz/kontrola.jsp");
            window.location.href = url;

        })
        .catch(error => console.error('Error:', error));


}