@echo off
setlocal enabledelayedexpansion

REM Set the input and output folder paths
REM set "input_folder=C:\Users\admin\WebstormProjects\cut10sProject\folder1"
REM set "output_folder=C:\Users\admin\WebstormProjects\cut10sProject\folder2"

set /p input_folder=Enter the input folder path:

echo Input folder: %input_folder%
set /p output_folder= Enter the output folder path:
echo Output folder: %output_folder%

set /p start_time=Enter the start time to cut (e.g., 00:00:00):
echo Start time: %start_time%
set /p end_time=Enter the end time to cut (e.g., 00:00:00):
echo End time: %end_time%


REM Ensure the output folder exists
if not exist "%output_folder%" mkdir "%output_folder%"

REM Loop through the videos in the input folder
for %%i in ("%input_folder%\*.mp4") do (
    set "input_video=%%i"
    set "output_video=%output_folder%\%%~nxi"

    REM Use FFmpeg to copy frames without "10" in the output video
    REM ffmpeg -i "!input_video!"  -ss 00:00:05 -c:a copy "temp_output.mp4"
    if "%end_time%" == "" (
        ffmpeg -i "!input_video!" -ss %start_time%  -c:a copy "!output_video!"
    ) else (
        ffmpeg -i "!input_video!" -ss %start_time% -to %end_time% -c:a copy "!output_video!"
    )
    REM Rename the temporary output file to the final output video
    REM move /y "temp_output.mp4" "!output_video!"
)

echo All videos processed.
pause


