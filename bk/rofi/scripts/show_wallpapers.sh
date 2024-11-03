#!/bin/bash

# Source required/util scripts
utils="{{cookiecutter.HYPR_SCRIPTS_DIR}}/utils.sh"
source $utils

show_wallpapers() {
    "{{cookiecutter.VENV_CLI_UTILITY}}" delete "{{cookiecutter.ROFI_SELECTED_WALLPAPER_VAR}}" --env "{{cookiecutter.BASH_VENV}}"
    # shellcheck disable=SC2154
    find -L "$wallpaper_dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -exec basename {} \; | sort -R | while read -r rfile
    do
        echo -en "$rfile\x00icon\x1f$wallpaper_dir/${rfile}\n"
    done
}

on_wallpaper_selected(){
    selected="$1"
    #echo "$(authentic_path "$wallpaper_dir")/$selected" > "cookiecutter.SELECTED_WALLPAPER_FILE"
    local path="$(authentic_path "$wallpaper_dir")/$selected"
    "{{cookiecutter.VENV_CLI_UTILITY}}" set "{{cookiecutter.ROFI_SELECTED_WALLPAPER_VAR}}" "$path" --env "{{cookiecutter.BASH_VENV}}"
}

if [ "$ROFI_RETV" -eq 0 ]; then
    show_wallpapers "$@"
elif [ "$ROFI_RETV" -eq 1 ]; then
    on_wallpaper_selected "$@"
fi


