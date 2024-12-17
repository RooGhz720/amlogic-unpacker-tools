@echo off
title Amlogic Tool created by Aghisna
color 0A

if not exist output (
    mkdir output
    echo Folder 'output' berhasil dibuat.
)

if not exist input (
    mkdir input
    echo Folder 'input' berhasil dibuat.
)

if not exist temp (
    mkdir temp
    echo Folder 'temp' berhasil dibuat.
)

:menu
cls
echo ========================================
echo Amlogic and Allwinner
echo      unpack repack tools
echo            created by Aghisna @RooGhz720    
echo ========================================
echo Option:
echo [1] Unpack Image Files
echo [2] Repack Image Files
echo [3] About me :)
echo ========================================
set /p choice=Select option: 

if "%choice%"=="1" goto unpack
if "%choice%"=="2" goto repack
if "%choice%"=="3" goto meee
echo huh...
pause
goto menu

:unpack
cls
echo ===========================
echo     UNPACK IMAGE FILES
echo ===========================
set file_found=
for %%f in (input\*.img) do set file_found=%%f

if "%file_found%"=="" (
    echo img file not found!
	echo first place img in input folder.
    pause
    goto menu
)

echo file found: %file_found%
copy "%file_found%" input\process.img >nul
timeout /t 2 >nul

echo verify file please wait...
amlogic.exe -c input\process.img > temp\verify_output.txt
timeout /t 2 >nul

findstr /c:"Image check OK" temp\verify_output.txt >nul
if errorlevel 1 (
    echo verify failed! this not correct img file
    del /q input\*
    pause
    goto menu
) else (
    echo File image valid. unpacking...
    amlogic.exe -d input\process.img temp
    timeout /t 2 >nul
    echo done... check temp folder
    del /q input\*
    pause
    goto menu
)

:repack
cls
echo ===========================
echo     REPACK IMAGE FILE
echo ===========================
if not exist temp\image.cfg (
    pause
    goto menu
)
echo Repacking...
amlogic.exe -r temp\image.cfg temp output\new_image.img
timeout /t 2 >nul
del /q temp\*
echo cleaning temp file...
timeout /t 5 >nul
pause
goto menu

:meee
cls
start "" "https://t.me/RooGhz720"
start "" "https://github.com/RooGhz720"
start "" "https://www.facebook.com/LuPikirLuSiapa"
pause
goto menu
