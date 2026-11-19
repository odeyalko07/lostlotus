# Makefile for Lost Lotus (Windows cmd.exe, GNU Make)
# Requires: GNU Make in PATH, .env with venv, game.py, icon.ico, LostLotus.spec

SHELL := cmd.exe
.SHELLFLAGS := /C

PYTHON   := .env\Scripts\python.exe
PIP      := .env\Scripts\pip.exe
ACTIVATE := .env\Scripts\activate.bat

GAME     := game.py
ICON     := icon.ico
EXE      := LostLotus.exe
DIST     := dist
BUILD    := build
SPEC     := LostLotus.spec

# Resources to copy next to exe (if present)
DATA_JSON := data.json
RES_DIR   := resources

.PHONY: all run build clean run-dist

all: run

# Run the game inside venv
run:
	@call $(ACTIVATE) && python $(GAME)

# Build onefile exe + copy external resources to dist
build:
	@call $(ACTIVATE) && pyinstaller $(SPEC) && if exist $(BUILD) rmdir /s /q $(BUILD)
	@echo --- Copying resources to $(DIST) ---
	@if exist $(DATA_JSON) ( copy /Y $(DATA_JSON) $(DIST)\ >nul && echo   [OK] $(DATA_JSON) ) else ( echo   [SKIP] $(DATA_JSON) not found )
	@if exist $(ICON) ( copy /Y $(ICON) $(DIST)\ >nul && echo   [OK] $(ICON) ) else ( echo   [SKIP] $(ICON) not found )
	@if exist $(RES_DIR) ( xcopy /E /I /Y $(RES_DIR) $(DIST)\$(RES_DIR)\ >nul && echo   [OK] $(RES_DIR)\ ) else ( echo   [SKIP] $(RES_DIR)\ not found )
	@echo Done: $(DIST)\$(EXE)

# Full project cleanup (keeps LostLotus.spec - it is a source file)
clean:
	@echo --- Cleaning project ---
	@if exist $(BUILD) ( rmdir /s /q $(BUILD) && echo   [OK] removed $(BUILD)\ )
	@if exist $(DIST) ( rmdir /s /q $(DIST) && echo   [OK] removed $(DIST)\ )
	@echo --- Removing __pycache__ and *.pyc ---
	@for /d /r . %%d in (__pycache__) do @if exist "%%d" ( rmdir /s /q "%%d" && echo   [OK] %%d )
	@del /s /q *.pyc *.pyo 2>nul
	@echo --- Clearing PyInstaller cache ---
	@if exist "%LOCALAPPDATA%\pyinstaller" ( rmdir /s /q "%LOCALAPPDATA%\pyinstaller" && echo   [OK] PyInstaller cache cleared )
	@echo Done. Project cleaned.

# Run built exe (to verify resources are picked up)
run-dist:
	@if exist $(DIST)\$(EXE) ( $(DIST)\$(EXE) ) else ( echo $(DIST)\$(EXE) not found. Run make build first. )