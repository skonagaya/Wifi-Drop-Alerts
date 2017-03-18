@echo off

rem Minimum balues the ping latency must be to trigger sounds to be played
set WARN_THRESHOLD=10
set SEVERE_THRESHOLD=100
set WARNING_SOUND_FILE=warn.wav
set SEVERE_SOUND_FILE=severe.mp3

setlocal ENABLEDELAYEDEXPANSION


for /f "tokens=1-2 delims=:" %%a in ('ipconfig^|find "Default"') do if not defined ip set ip=%%b

cls
echo.
ECHO  Loading sounds files.

if exist %WARNING_SOUND_FILE% (
    rem Found file
    if exist warn.vbs ( del warn.vbs )
) else (
    ECHO %WARNING_SOUND_FILE% was not found.
    goto eof
)

if exist %SEVERE_SOUND_FILE% (
    rem Found file
    if exist severe.vbs ( del severe.vbs )
) else (
    ECHO %SEVERE_SOUND_FILE% was not found.
    goto eof
)

rem Load files and executed through visual basic scripts so users do not see cmd prompt
( echo Set Sound = CreateObject("WMPlayer.OCX.7"^)
 echo Sound.URL = "%WARNING_SOUND_FILE%"
 echo Sound.Controls.play
 echo do while Sound.currentmedia.duration = 0
 echo wscript.sleep 100
 echo loop
 echo wscript.sleep (int(Sound.currentmedia.duration^)+1^)*1000) >warn.vbs
( echo Set Sound = CreateObject("WMPlayer.OCX.7"^)
 echo Sound.URL = "%SEVERE_SOUND_FILE%"
 echo Sound.Controls.play
 echo do while Sound.currentmedia.duration = 0
 echo wscript.sleep 100
 echo loop
 echo wscript.sleep (int(Sound.currentmedia.duration^)+1^)*1000) >severe.vbs

rem Set initial time
set t0=%time: =0%

ECHO  Script is now ready.
ECHO  Now listening over%ip%...
echo.

:loop
FOR /f "tokens=1,5 delims=: " %%A IN ('ping -n 1 %ip%') DO IF %%A==Reply set ms=%%B
set ms=!ms:~5,-2!
set /a ms=%ms%

if %ms% gtr %SEVERE_THRESHOLD% (
 start /min warn.vbs
 goto printtime
)
if %ms% gtr %WARN_THRESHOLD% (
 start /min severe.vbs
 goto printtime
)

timeout /t 1 /nobreak > NUL
goto loop

:printtime

set t=%time: =0%
set /a h=1%t0:~0,2%-100
set /a m=1%t0:~3,2%-100
set /a s=1%t0:~6,2%-100
set /a c=1%t0:~9,2%-100
set /a starttime = %h% * 360000 + %m% * 6000 + 100 * %s% + %c%
set /a h=1%t:~0,2%-100
set /a m=1%t:~3,2%-100
set /a s=1%t:~6,2%-100
set /a c=1%t:~9,2%-100
set /a endtime = %h% * 360000 + %m% * 6000 + 100 * %s% + %c%
set /a runtime = (%endtime% - %starttime%)
set runtime = %s%.%c%
ECHO  [%time%]	%ms% ms	%runtime%0 ms since last blip
set t0=%time: =0%
timeout /t 1 /nobreak > NUL
goto loop

:eof
