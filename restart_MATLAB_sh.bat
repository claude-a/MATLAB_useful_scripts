@echo off  
 
set APP_NAME=MATLAB.exe

for /f %%i in ('tasklist /fi "IMAGENAME eq %APP_NAME%" 2^>^&1') do (  
 
    if /i %%i==%APP_NAME% (  
          
        taskkill /im %APP_NAME% /f  
         
        goto ENDLOOP;  
    )  
)  
:ENDLOOP 

start " " %1