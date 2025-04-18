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

selected_wallpaper_effect="$(get_variable "wallpaper.effect.selected.path")"
current_wallpaper_effect="$(get_variable "wallpaper.effect.current.path")"
current_wallpaper_name="$(get_variable "wallpaper.current.name")"
wallpaper_with_effect="{{cookiecutter.GENERATED_WALLPAPERS_WITH_EFFECTS_DIR}}/$current_wallpaper_name/$selected_wallpaper_effect"

if [[ "$selected_wallpaper_effect" != "$current_wallpaper_effect" ]];then

    # Change the wallpaper
    "$change_wallpaper_script" "$wallpaper_with_effect"
    # Update the current wallpaper path
    set_variable "wallpaper.current.path" "$wallpaper_with_effect"
    # Update the current wallpaper effect
    set_variable "wallpaper.current.effect" "$selected_wallpaper_effect"
    set_variable "wallpaper.effect.selected.path" "$wallpaper_with_effect"
    # Write the current wallpaper to rofi config
    echo "* { current-image: url(\"$wallpaper_with_effect\", height); }" > "{{cookiecutter.ROFI_CONFIG_CURRENT_WALLPAPER}}"

    set_variable "wallpaper.selected.path" "$wallpaper_with_effect"
    set_variable "wallpaper.selected.name" "$current_wallpaper_name"
fi