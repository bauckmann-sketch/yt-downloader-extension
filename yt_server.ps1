# PowerShell Backend Server pro YT Downloader Pro v3.7 (STABLE)
# Vylepšené spouštění procesů a diagnostika na portu 5003

$ytDlpPath = "C:\Users\David\AppData\Local\Microsoft\WinGet\Packages\yt-dlp.yt-dlp_Microsoft.Winget.Source_8wekyb3d8bbwe\yt-dlp.exe"
$ffmpegBin = "C:\Users\David\AppData\Local\Microsoft\WinGet\Packages\yt-dlp.FFmpeg_Microsoft.Winget.Source_8wekyb3d8bbwe\ffmpeg-N-122609-g364d5dda91-win64-gpl\bin"
$ffmpegPath = Join-Path $ffmpegBin "ffmpeg.exe"

$env:PATH = "$ffmpegBin;$env:PATH"

$logFile = Join-Path $PSScriptRoot "download_server.log"
function Write-Log($msg) {
    $timestamp = Get-Date -Format "HH:mm:ss"
    $line = "[$timestamp] $msg"
    Write-Host $line
    Add-Content -Path $logFile -Value $line
}

Write-Log "Startuji server v3.7 na portu 5003..."

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:5003/")
try {
    $listener.Start()
}
catch {
    Write-Log "CHYBA: Port 5003 je obsazen."
    exit
}

$downloadPath = [System.IO.Path]::Combine($env:USERPROFILE, "Downloads")
Write-Log "Server naslouchá na http://localhost:5003/"
Write-Log "Videa ukládám do: $downloadPath"

while ($listener.IsListening) {
    try {
        $context = $listener.GetContext()
        $request = $context.Request
        $response = $context.Response

        $response.Headers.Add("Access-Control-Allow-Origin", "*")
        $response.Headers.Add("Access-Control-Allow-Methods", "POST, OPTIONS")
        $response.Headers.Add("Access-Control-Allow-Headers", "Content-Type")

        if ($request.HttpMethod -eq "OPTIONS") {
            $response.StatusCode = 200
            $response.Close()
            continue
        }

        if ($request.HttpMethod -eq "POST") {
            $reader = New-Object System.IO.StreamReader($request.InputStream)
            $body = $reader.ReadToEnd()
            $data = $body | ConvertFrom-Json
            $url = $data.url

            Write-Log "PŘIJATO: Stažení videa: $url"
            
            $dlLogId = [Guid]::NewGuid().ToString().Substring(0, 8)
            $dlLogFile = Join-Path $PSScriptRoot "dl_$dlLogId.log"

            # Vytvoření skriptu pro stahování, který spustíme na pozadí
            $cmd = "& '$ytDlpPath' '$url' -o '$downloadPath\%(title)s.%(ext)s' --no-mtime --ffmpeg-location '$ffmpegPath' --newline > '$dlLogFile' 2>&1"
            Write-Log "DEBUG: Spouštím příkaz: $cmd"

            # Spuštění přes powershell na pozadí
            Start-Process powershell.exe -ArgumentList "-WindowStyle Hidden", "-Command", $cmd -NoNewWindow

            $jsonRes = @{ status = "success"; message = "Stahování zahájeno. ID: $dlLogId" } | ConvertTo-Json
            $buffer = [System.Text.Encoding]::UTF8.GetBytes($jsonRes)
            $response.ContentType = "application/json"
            $response.ContentLength64 = $buffer.Length
            $response.OutputStream.Write($buffer, 0, $buffer.Length)
        }
    }
    catch {
        Write-Log "CHYBA: $($_.Exception.Message)"
    }
    finally {
        if ($null -ne $response) { $response.Close() }
    }
}
