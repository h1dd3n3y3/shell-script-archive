# A reminder script for dummies, lazy to read the README.md

Write-Output "Don't just copy & paste."
Write-Output "Read the README.md CAREFULLY!"
Write-Output "Openning in 3 seconds..."

$osName = (Get-WmiObject Win32_OperatingSystem).Caption

sleep 3

if ($osName -like '*Linux*') {
    python3 -m webbrowser https://github.com/h1dd3n3y3/shell-script-archive/tree/main/powershell
}
elseif ($osName -like '*Windows*') {
    python -m webbrowser https://github.com/h1dd3n3y3/shell-script-archive/tree/main/powershell
}
else {
    Write-Output "Unknown Operating System"
}
