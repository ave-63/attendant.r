:: USER OPTIONS:

:: Path to folder containing all your downloaded csv files. You must edit this!
set INPUT_DIRECTORY=C:\Users\bensm\Downloads\

:: Path to folder where you want your result csv files to go. You must edit this!
set OUTPUT_DIRECTORY=C:\Users\bensm\Desktop\

:: The current year.
set YEAR=2021

:: Do not mess with anything below.
Rscript.exe ./attendant.r %INPUT_DIRECTORY% %OUTPUT_DIRECTORY% %YEAR%
pause
