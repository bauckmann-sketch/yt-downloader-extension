document.getElementById('dlBtn').addEventListener('click', async () => {
    const status = document.getElementById('status');
    status.innerText = "Posílám povel na tvůj počítač...";
    status.style.color = "#065fd4";

    const [tab] = await chrome.tabs.query({ active: true, currentWindow: true });

    if (!tab.url.includes("youtube.com") && !tab.url.includes("youtu.be")) {
        status.innerText = "Chyba: Toto není video z YouTube.";
        status.style.color = "red";
        return;
    }

    try {
        // Voláme přímo tvůj lokální PowerShell server na portu 5003
        const response = await fetch('http://localhost:5003/download', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ url: tab.url })
        });

        const result = await response.json();

        if (response.ok && result.status === 'success') {
            status.innerText = "Hotovo! Sleduj složku Downloads.";
            status.style.color = "green";
        } else {
            status.innerText = "Chyba: " + (result.message || "Server odmítl požadavek.");
            status.style.color = "red";
        }
    } catch (err) {
        status.innerText = "Chyba: PowerShell server neběží!";
        status.style.color = "red";
    }
});
