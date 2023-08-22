function generatePin(quizId, userId, url) {
    fetch('/rwaprojekat/admin/generatePin', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: 'quizId=' + quizId + '&userId=' + userId,
    })
        .then(response => {
            if (response.ok) {
                showAlert('PIN je generisan!');
                window.location.href = url;
            } else {
                showAlert('Došlo je do greške prilikom generisanja PIN-a.');
            }
        })
        .catch(error => console.error('Error:', error));
}

function showAlert(message) {
    alert(message);
}

const startButtons = document.querySelectorAll('.start-quiz-button');
startButtons.forEach(button => {
    const quizId = button.closest('.quiz-container').getAttribute('data-id');
    const userId = button.closest('.quiz-container').getAttribute('creator');
    const url = '/rwaprojekat/quiz/kontrola.jsp'
    button.addEventListener('click', () => generatePin(quizId, userId, url));
});