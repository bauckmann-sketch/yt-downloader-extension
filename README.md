# YouTube Downloader Extension

Tento projekt umoĹľĹuje stahovĂˇnĂ­ YouTube videĂ­ pĹ™Ă­mo z prohlĂ­ĹľeÄŤe Chrome do sloĹľky Downloads na vaĹˇem poÄŤĂ­taÄŤi jedinĂ˝m kliknutĂ­m.

## Jak to zprovoznit na novĂ©m poÄŤĂ­taÄŤi

### 1. PĹ™Ă­prava Pythonu
1. Nainstalujte **Python 3** (z python.org nebo pĹ™es winget).
2. Nainstalujte potĹ™ebnĂ© knihovny:
   ```powershell
   pip install flask flask-cors yt-dlp
   ```

### 2. SpuĹˇtÄ›nĂ­ serveru
1. StĂˇhnÄ›te/Naklonujte toto repo.
2. SpusĹĄte server:
   ```powershell
   python yt_server.py
   ```
   *Toto okno nechte bÄ›Ĺľet, zatĂ­mco chcete stahovat.*

### 3. Instalace doplĹku do Chromu
1. OtevĹ™ete v Chrome: `chrome://extensions/`
2. ZapnÄ›te **Developer mode** (ReĹľim vĂ˝vojĂˇĹ™e).
3. KliknÄ›te na **Load unpacked** (NaÄŤĂ­st rozbalenĂ˝).
4. Vyberte sloĹľku `chrome_extension` z tohoto repozitĂˇĹ™e.

## PouĹľitĂ­
NavĹˇtivte jakĂ©koli video na YouTube, kliknÄ›te na ikonu doplĹku a zvolte **StĂˇhnout video**. Soubor se uloĹľĂ­ do vaĹˇĂ­ systĂ©movĂ© sloĹľky **Downloads**.
