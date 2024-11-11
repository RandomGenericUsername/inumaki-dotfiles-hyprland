#!/bin/bash

# Path to variables handler script
variables_handler="{{cookiecutter.HYPR_DIR}}/scripts/variables_handler.sh"
# Path to utils (authentic_path, _or)
utils_dir="{{cookiecutter.HYPR_DIR}}/scripts/utils.sh"
# Source the variables handler script
# shellcheck disable=SC1090
source "$variables_handler"
# Source required/util scripts 
# shellcheck disable=SC1090
source $utils_dir

show_wallpapers() {
    set_variable "wallpaper.selected.path" ""
    set_variable "wallpaper.selected.name" ""
    # shellcheck disable=SC2154
    find -L "$wallpaper_dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -exec basename {} \; | sort -R | while read -r rfile
    do
        echo -en "$rfile\x00icon\x1f$wallpaper_dir/${rfile}\n"
    done
}

on_wallpaper_selected(){
    selected="$1"
    local current_wallpaper_path;current_wallpaper_path="$(authentic_path "$wallpaper_dir")/$selected"
    local current_wallpaper_name;current_wallpaper_name="$(get_file_name "$current_wallpaper_path")"   
    set_variable "wallpaper.selected.path" "$current_wallpaper_path"
    set_variable "wallpaper.selected.name" "$current_wallpaper_name"
}

if [ "$ROFI_RETV" -eq 0 ]; then
    show_wallpapers "$@"
elif [ "$ROFI_RETV" -eq 1 ]; then
    on_wallpaper_selected "$@"
fi


