# Makefile для Lost Lotus (Windows cmd.exe, GNU Make)
# Требуется: GNU Make в PATH, .env с venv, game.py, icon.ico

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

.PHONY: all run build clean

all: run

# Запуск игры внутри venv
run:
	@call $(ACTIVATE) && python $(GAME)

# Сборка в один exe, без папки build
build:
	@call $(ACTIVATE) && pyinstaller --noconfirm --clean --onefile --windowed --name LostLotus --icon $(ICON) $(GAME) && if exist $(BUILD) rmdir /s /q $(BUILD)
	@echo Готово: $(DIST)\$(EXE)

# Полная очистка артефактов
clean:
	@if exist $(BUILD) rmdir /s /q $(BUILD)
	@if exist $(DIST) rmdir /s /q $(DIST)
	@if exist LostLotus.spec del /q LostLotus.spec
	@echo Очищено.