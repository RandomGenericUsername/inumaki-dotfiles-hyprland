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

selected_wallpaper="$(get_variable "wallpaper.selected.path")"
selected_wallpaper_name="$(get_variable "wallpaper.selected.name")"
current_wallpaper="$(get_variable "wallpaper.current.path")"
current_wallpaper_name="$(get_variable "wallpaper.current.name")"


print_debug "Selected wallpaper: $selected_wallpaper" -t "info"
print_debug "Current wallpaper: $current_wallpaper" -t "info"
print_debug "Selected wallpaper name: $selected_wallpaper_name" -t "info"
print_debug "Current wallpaper name: $current_wallpaper_name" -t "info"

if [[ -z "$selected_wallpaper" ]];then
    print_debug "No wallpaper selected..." -t "info"
    exit 0
fi

if [[ "$selected_wallpaper_name" != "$current_wallpaper_name" ]];then

    # Change the wallpaper
    "$change_wallpaper_script" "$selected_wallpaper"
    # Update the current wallpaper path
    set_variable "wallpaper.current.path" "$selected_wallpaper"
    # Update the current wallpaper name
    set_variable "wallpaper.current.name" "$selected_wallpaper_name"
    # Update the current wallpaper effect
    set_variable "wallpaper.current.effect" "off"
    # Write the current wallpaper to rofi config
    echo "* { current-image: url(\"$selected_wallpaper\", height); }" > "{{cookiecutter.ROFI_DIR}}/current-wallpaper.rasi"
    cached_dir="{{cookiecutter.GENERATED_WALLPAPERS_WITH_EFFECTS_DIR}}/$selected_wallpaper_name"
    mkdir -p "$cached_dir"
    cp "$selected_wallpaper" "$cached_dir/off"
fi


