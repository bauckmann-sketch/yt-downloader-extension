document.getElementById('dlBtn').addEventListener('click', async () => {
    const status = document.getElementById('status');
    status.innerText = "PosĂ­lĂˇm na server...";

    // ZĂ­skĂˇ aktuĂˇlnĂ­ URL zĂˇloĹľky
    const [tab] = await chrome.tabs.query({ active: true, currentWindow: true });

    try {
        const response = await fetch('http://localhost:5000/download', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ url: tab.url })
        });

        const result = await response.json();
        if (response.ok) {
            status.innerText = "Hotovo! Sleduj sloĹľku Downloads.";
            status.style.color = "green";
        } else {
            status.innerText = "Chyba: " + result.error;
            status.style.color = "red";
        }
    } catch (err) {
        status.innerText = "Chyba: Server nebÄ›ĹľĂ­!";
        status.style.color = "red";
    }
});
