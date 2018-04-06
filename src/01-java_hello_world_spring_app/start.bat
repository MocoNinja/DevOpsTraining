@echo off

if "%1"=="" (set port=8080) else (set port=%1)
java -Dserver.port=%port% -jar target/gs-serving-web-content-0.1.0.jar
