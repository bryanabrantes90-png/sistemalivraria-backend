@echo off
chcp 65001 > nul
title Sistema Livraria - Iniciador
color 0A

:menu
cls
echo ==================================================
echo          SISTEMA LIVRARIA - GERENCIADOR
echo ==================================================
echo.
echo  1 - Iniciar BACKEND (Java Spring Boot)
echo  2 - Iniciar FRONTEND (React + Vite)
echo  3 - Iniciar AMBOS
echo  4 - Sair
echo ==================================================
set /p op=Escolha uma opção: 

:: ----------------------
:: OPÇÃO 1 - BACKEND
:: ----------------------
if "%op%"=="1" (
    cls
    echo 🚀 Iniciando Backend...
    echo Caminho: C:\Users\Alunos\sistemalivraria-backend
    echo -----------------------
    cd /d "C:\Users\Alunos\sistemalivraria-backend"
    "C:\Users\Alunos\sistemalivraria-backend\maven\apache-maven-3.9.9\bin\mvn.cmd" spring-boot:run
    pause
    goto menu
)

:: ----------------------
:: OPÇÃO 2 - FRONTEND
:: ----------------------
if "%op%"=="2" (
    cls
    echo ⚛️ Iniciando Frontend...
    echo Caminho: C:\Users\Alunos\SistemaLivrariaB
    echo -----------------------
    cd /d "C:\Users\Alunos\SistemaLivrariaB"
    npm run dev
    pause
    goto menu
)

:: ----------------------
:: OPÇÃO 3 - AMBOS
:: ----------------------
if "%op%"=="3" (
    cls
    echo 🚀 Iniciando Backend...
    start cmd /k "cd /d C:\Users\Alunos\sistemalivraria-backend && C:\Users\Alunos\sistemalivraria-backend\maven\apache-maven-3.9.9\bin\mvn.cmd spring-boot:run"
    
    timeout /t 5 /nobreak > nul

    echo ⚛️ Iniciando Frontend...
    start cmd /k "cd /d C:\Users\Alunos\SistemaLivrariaB && npm run dev"
    
    echo ✅ Ambos iniciados em janelas separadas!
    pause
    goto menu
)

:: ----------------------
:: OPÇÃO 4 - SAIR
:: ----------------------
if "%op%"=="4" (
    exit
)

goto menu