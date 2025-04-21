#!/bin/bash

# Path to utils (authentic_path, _or)
utils_dir="{{cookiecutter.UTILS_SCRIPT}}"
# Path to print debug script
print_debug="{{cookiecutter.PRINT_DEBUG_UTIL}}"
# Path to change wallpaper script
change_wallpaper_script="{{cookiecutter.CHANGE_WALLPAPER_SCRIPT}}"
# Path to variables handler script
variables_handler="{{cookiecutter.VARIABLES_HANDLER_SCRIPT}}"

# Source required/util scripts
# shellcheck disable=SC1090
source $utils_dir
# Source the variables handler script
# shellcheck disable=SC1090
source "$variables_handler"

current_wallpaper="$(get_variable "wallpaper.current.path")"

if [[ -z "$current_wallpaper" ]];then
    $print_debug "No current wallpaper..." -t "info"
    exit 0
fi

# Change the wallpaper
"$change_wallpaper_script" "$current_wallpaper"
# Write the wallpaper path to rofi
echo "* { current-image: url(\"$current_wallpaper\", height); }" > "{{cookiecutter.ROFI_CONFIG_CURRENT_WALLPAPER}}"



