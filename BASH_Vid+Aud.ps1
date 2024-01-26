# Функция для проверки rtsp URL
function Test-RtspUrl {
    param (
        [string]$url
    )
    
    # Регулярное выражение для проверки rtsp URL
    $rtspRegex = '^rtsp:\/\/'

    # Проверка
    if ($url -match $rtspRegex) {
        return $true
    } else {
        return $false
    }
}

# Запрос ввода rtsp URL для видео
$rtsp_Vid = ""
while (-not (Test-RtspUrl -url $rtsp_Vid)) {
    $rtsp_Vid = Read-Host "Enter video rtsp"
}

# Запрос ввода rtsp URL для аудио
$rtsp_Aud = ""
while (-not (Test-RtspUrl -url $rtsp_Aud)) {
    $rtsp_Aud = Read-Host "Enter audio rtsp"
}

# Формирование команды gstreamer
$command = "gst-launch-1.0 rtspsrc location=$rtsp_Vid ! rtph264depay ! h264parse ! matroskamux name=mux ! filesink location=output.mkv rtspsrc location=$rtsp_Aud ! rtpmp4gdepay ! aacparse ! mux."

# Вывод сформированной команды
Write-Output "Running $command"

# Запуск команды
Invoke-Expression $command
