// Prevent form submissions (since this is just a mock interface)
document.querySelectorAll('form').forEach(form => {
    form.addEventListener('submit', (e) => {
        e.preventDefault();
        alert('This is a mock interface. In a real application, this would interact with the database.');
    });
}); 