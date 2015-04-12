@echo off

setlocal ENABLEDELAYEDEXPANSION

if "%OS%" == "Windows_NT" setlocal
rem ---------------------------------------------------------------------------
rem Startup Script for JavaSnoop

rem   JAVA_HOME       Must point at your Java Development Kit installation.
rem   JAVA_OPTS       (Optional) Java runtime options.

set unsafe_policy=resources\unsafe.policy
set safe_policy=resources\safe.policy
set user_policy=%USERPROFILE%\.java.policy
set user_policy_jk=%USERPROFILE%\AppData\LocalLow\Sun\Java\Deployment\security\java.policy

echo %JAVA_HOME% | find /i "jdk" > NUL

if not errorlevel 1 (
echo [1] Found Java JDK in JAVA_HOME variable!
copy "%JAVA_HOME%\lib\tools.jar" .\lib\tools.jar
set JDK_EXEC="%JAVA_HOME%\bin\java.exe"
) else (
echo [1] JAVA_HOME variable wasn't set to a valid Java installation.
echo exiting.
goto :EOF
)

echo [2] Turning off Java security for JavaSnoop usage.
del %user_policy% 2>NUL
copy %unsafe_policy% %user_policy% >NUL

echo [3] Starting JavaSnoop
start /wait /MIN "JavaSnoop" %JDK_EXEC% -jar JavaSnoop.jar

echo [4] Turning Java security back on for safe browsing.
del %user_policy% 2> NUL
copy %safe_policy% %user_policy% > NUL

if "%OS%" == "Windows_NT" endlocal
