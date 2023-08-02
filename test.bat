@echo off
set LogFile=log.txt

REM Verifica se o arquivo de log existe
if not exist %LogFile% (
    echo Criando o arquivo de log...
    echo Log gerado em: %date% %time% > %LogFile%
) else (
    echo Adicionando entrada de log...
    echo Log gerado em: %date% %time% >> %LogFile%
)

echo Log registrado com sucesso!
