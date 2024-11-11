#!/bin/bash

# Path to utils (authentic_path, _or)
utils_dir="{{cookiecutter.HYPR_SCRIPTS_DIR}}/utils.sh"
# Path to print debug script
print_debug_script="{{cookiecutter.PRINT_DEBUG_UTIL}}"
# Path to change wallpaper script
change_wallpaper_script="{{cookiecutter.HYPR_DIR}}/scripts/wallpaper_selector/change_wallpaper.sh"
# Path to variables handler script
variables_handler="{{cookiecutter.HYPR_DIR}}/scripts/variables_handler.sh"

# Source required/util scripts
# shellcheck disable=SC1090
source $utils_dir
# Source the print_debug script
# shellcheck disable=SC1090
source "$print_debug_script"
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
    # Write the current wallpaper to rofi config
    echo "* { current-image: url(\"$wallpaper_with_effect\", height); }" > "{{cookiecutter.ROFI_DIR}}/current-wallpaper.rasi"
fi