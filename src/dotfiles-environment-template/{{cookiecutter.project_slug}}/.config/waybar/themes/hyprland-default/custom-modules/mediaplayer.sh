#!/bin/bash

# Path to the mediaplayer script
mediaplayer_script="{{cookiecutter.WAYBAR_HYPRLAND_DEFAULT_THEME_DIR}}/custom-modules/mediaplayer.py"

# Path to the Python virtual environment
venv_path="{{cookiecutter.PYTHON_VENV}}/bin/activate"

# Check if the virtual environment exists
if [ ! -f "$venv_path" ]; then
    echo "Error: Virtual environment not found at $venv_path"
    exit 1
fi

# Activate the virtual environment
source "$venv_path"

# Execute the Python script
python "$mediaplayer_script"

# Deactivate the virtual environment (optional, especially if running in a subshell)
deactivate
