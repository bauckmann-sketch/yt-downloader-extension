# YouTube Downloader Pro v3.7 (Stable Edition)

Moderní a vysoce stabilní rozšíření pro Google Chrome, které umožňuje stahování videí z YouTube přímo do tvého počítače pomocí lokálního PowerShell serveru.

## 🚀 Proč tato verze? (Historie vývoje)

Tento projekt prošel několika fázemi vývoje, aby dosáhl maximální stability:

1.  **Fáze 1: Cloud API (Cobalt v7/v10)** - *SELHALO*. 
    - **Důvod:** YouTube a cloudové služby (Cobalt) zavedly přísné restrikce (JWT tokeny, CORS policy), které blokovaly přímé volání z doplňků prohlížeče.
2.  **Fáze 2: Python Backend** - *ZAVRŽENO*. 
    - **Důvod:** Vyžaduje instalaci Pythonu a závislostí, což bylo pro uživatele nepohodlné.
3.  **Fáze 3: PowerShell Backend (Aktuální)** - **VÍTĚZ**. 
    - **Důvod:** Využívá nativní nástroje Windows (PowerShell), které jsou v každém systému. Kombinace s profesionálním motorem `yt-dlp` zaručuje, žeYouTube stahování nezablokuje, protože se tváří jako běžný prohlížeč.

## 🛠️ Instalace a spuštění

### 1. Prerekvizity (Jednorázově)
Otevři PowerShell jako administrátor a spusť:
```powershell
winget install yt-dlp
```

### 2. Spuštění serveru
V každé relaci, kdy chceš stahovat, spusť tento skript:
```powershell
powershell -ExecutionPolicy Bypass -File "path/to/yt_server.ps1"
```

### 3. Instalace doplňku
1. Jdi na `chrome://extensions/`.
2. Zapni "Developer Mode".
3. Klikni na "Load unpacked" a vyber složku `chrome_extension`.

## 📁 Technické detaily
- **Server:** PowerShell HTTP Listener (Port 5003).
- **Frontend:** Vanilla JS Chrome Extension v3.
- **Stahování:** yt-dlp s podporou FFmpeg pro maximální kvalitu.
