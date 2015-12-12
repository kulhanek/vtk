@echo off
REM windows batch

set MODE=%1%
if "%MODE%"=="" (
    set MODE=quick
)

if "%MODE%"=="quick" (
	REM nothing to be here
)

if "%MODE%"=="deep" (
	for /d /r . %%d in (CMakeFiles) do (
		if exist "%%d" rd /s/q "%%d"
	)
	del /s /q /f CMakeCache.txt
	del /s /q /f cmake_install.cmake
	del /s /q /f Makefile
	del /s /q /f VTK-6.3.0.*
	rd /s/q build
	rd /s/q src/build
	rd /s/q src/VTK-6.3.0
)
