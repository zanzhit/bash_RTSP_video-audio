$rtsp_Vid = Read-Host "Enter rtsp for the video"

$rtsp_Aud = Read-Host "Enter rtsp for the audio"

$command = gst-launch-1.0 rtspsrc location=$rtsp_Vid ! rtph264depay ! h264parse ! matroskamux name=mux ! filesink location=output.mkv rtspsrc location=$rtsp_Aud ! rtpmp4gdepay ! aacparse ! mux.

Write-Output "Running: $command"

Invoke-Expression $command