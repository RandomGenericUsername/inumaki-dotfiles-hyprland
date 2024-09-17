#!/bin/bash


set_current_wallpaper(){
    local wallpaper_with_effect="$1"
    # Path to venv script
    venv="{{cookiecutter.VENV_CLI_UTILITY}}"
    # Path to change wallpaper script
    change_wallpaper_script="{{cookiecutter.WALLPAPER_SELECTOR_SCRIPTS_DIR}}/change_wallpaper.sh"
    # 0. Change the wallpaper
    "$change_wallpaper_script" "$wallpaper_with_effect"
    # 1. Update the current wallpaper path
    "$venv" update "{{cookiecutter.ROFI_CURRENT_WALLPAPER_VAR}}" "$wallpaper_with_effect" --env "{{cookiecutter.BASH_VENV}}"
    # 2. Write the current wallpaper to rofi config
    echo "* { current-image: url(\"$wallpaper_with_effect\", height); }" > "{{cookiecutter.ROFI_CURRENT_WALLPAPER_RASI}}"
}