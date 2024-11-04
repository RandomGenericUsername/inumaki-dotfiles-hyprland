#!/bin/bash

# Path to print debug script
print_debug_script="{{cookiecutter.PRINT_DEBUG_UTIL}}"
# Path to variables handler script
variables_handler="{{cookiecutter.HYPR_DIR}}/scripts/variables_handler.sh"
# Source the variables handler script
source "$variables_handler"
# Get the current wallpaper
if ! current_wallpaper="$(get_variable "wallpaper.current")";then
    $print_debug_script "Error getting current wallpaper" -t "error"
    return 1
fi
# if the current wallpaper is empty, exit
if [[ -z "$current_wallpaper" ]]; then
    $print_debug_script "Current wallpaper is empty" -t "error"
    return 1
fi
# Print the current wallpaper
$print_debug_script "Generating color scheme with wal out of wallpaper: $current_wallpaper" -t "info"
# Activate the python venv
source "{{cookiecutter.PYTHON_VENV}}/bin/activate"
# Generate the color scheme with wal
if ! wal -i "$current_wallpaper" -q; then
    $print_debug_script "Error generating color scheme with wal." -t "error"
    return 1
fi
# Deactivate the python venv
deactivate
$print_debug_script "Finished generating color scheme!" -t "info"


