#!/bin/bash

# Path to print debug script
print_debug_script="{{cookiecutter.PRINT_DEBUG_UTILITY}}"
# Source the print_debug script
source "$print_debug_script"
# Path to venv script
venv="{{cookiecutter.VENV_CLI_UTILITY}}"
current_wallpaper="$("$venv" get "{{cookiecutter.ROFI_CURRENT_WALLPAPER_VAR}}" --env "{{cookiecutter.BASH_VENV}}")"

print_debug "Generating color scheme with wal..." -t "info"
source "{{cookiecutter.PYTHON_VENV}}/bin/activate"
wal -i "$current_wallpaper" -q
deactivate
print_debug "Finished generating color scheme..." -t "info"
