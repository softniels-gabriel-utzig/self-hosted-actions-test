@echo off >> .\log.txt

REM Nome do Site no IIS
SET "SITE_NAME=Dog Api"

REM Path para o MSBuild
SET "MSBUILD_PATH=C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\MSBuild\Current\Bin\MSBuild.exe"   

REM Path para o arquivo rsvars.bat 
SET "RSVARS_PATH=C:\Program Files (x86)\Embarcadero\Studio\22.0\bin\rsvars.bat"   

REM path local do seu projeto 
SET "PROJECT_PATH=.\API\Projeto\DogApi.dproj"   

REM Logging Data
echo ----------------------------- >> .\log.txt
echo %DATE% %TIME% >> .\log.txt

REM O arquivo rsvars.bat contem as variaveis de ambiente necessarias para o MsBuild compilar o projeto
call "%RSVARS_PATH%"

net use z: \\pc-dev2\Componentes  

echo Stopping IIS site: %SITE_NAME% >> .\log.txt
%SystemRoot%\System32\inetsrv\appcmd.exe stop site "%SITE_NAME%"

echo Buildando o projeto como CLEAN >> .\log.txt
"%MSBUILD_PATH%" "%PROJECT_PATH%" /t:Clean

echo Buildando o projeto como BUILD >> .\log.txt
"%MSBUILD_PATH%" "%PROJECT_PATH%" /t:Build /p:Configuration=Release
SET MSBUILD_EXIT_CODE=%errorlevel%
echo MSBuild exit code: %MSBUILD_EXIT_CODE% >> .\log.txt


IF %MSBUILD_EXIT_CODE% EQU 0 (
    echo Starting IIS site: %SITE_NAME% >> .\log.txt
    %SystemRoot%\System32\inetsrv\appcmd.exe start site "%SITE_NAME%"
    echo -----------Sucesso----------- >> .\log.txt
    echo ----------------------------- >> .\log.txt
) ELSE (
    echo ------------Error------------ >> .\log.txt
    echo ----------------------------- >> .\log.txt

)



