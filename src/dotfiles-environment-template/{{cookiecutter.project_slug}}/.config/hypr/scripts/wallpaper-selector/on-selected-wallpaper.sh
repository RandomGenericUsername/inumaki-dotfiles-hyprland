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

selected_wallpaper="$(get_variable "wallpaper.selected.path")"
selected_wallpaper_name="$(get_variable "wallpaper.selected.name")"
current_wallpaper="$(get_variable "wallpaper.current.path")"
current_wallpaper_name="$(get_variable "wallpaper.current.name")"


$print_debug "Selected wallpaper: $selected_wallpaper" -t "info"
$print_debug "Current wallpaper: $current_wallpaper" -t "info"
$print_debug "Selected wallpaper name: $selected_wallpaper_name" -t "info"
$print_debug "Current wallpaper name: $current_wallpaper_name" -t "info"

if [[ -z "$selected_wallpaper" ]];then
    $print_debug "No wallpaper selected..." -t "info"
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
    echo "* { current-image: url(\"$selected_wallpaper\", height); }" > "{{cookiecutter.ROFI_CONFIG_CURRENT_WALLPAPER}}"
    cached_dir="{{cookiecutter.GENERATED_WALLPAPERS_WITH_EFFECTS_DIR}}/$selected_wallpaper_name"
    mkdir -p "$cached_dir"
    cp "$selected_wallpaper" "$cached_dir/off"
fi


