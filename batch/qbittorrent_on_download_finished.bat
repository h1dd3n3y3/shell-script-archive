@echo off

:: Save args to vars
set movie_path=%2
explorer %movie_path%


:: Get Movie title, using %~1 to remove quotes
for /f "tokens=1,2 delims=()" %%a in ("%~1") do set "movie_name=%%a(%%b)"


:: Check if connected to home wifi or Wireguard home
if (netsh wlan show networks | findstr "h0n3yP0t") || (ipconfig | findstr "adapter home")


:: If one of the above, execute NTFY curl
if %ERRORLEVEL% NEQ 0 (
    curl -d "%movie_name% finished!" 192.168.1.254/qbittorrent
)