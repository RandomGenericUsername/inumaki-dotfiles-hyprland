#!/bin/bash

# Path to venv script
venv="{{cookiecutter.VENV_CLI_UTILITY}}"
# Path to utils (authentic_path, _or)
utils_dir="{{cookiecutter.HYPR_SCRIPTS_DIR}}/utils.sh"
# Path to print debug script
print_debug_script="{{cookiecutter.PRINT_DEBUG_UTILITY}}"
# Path to change wallpaper script
change_wallpaper_script="{{cookiecutter.HYPR_SCRIPTS_DIR}}/change_wallpaper.sh"

# Source required/util scripts
source $utils_dir
# Source the print_debug script
source "$print_debug_script"

###
selected_wallpaper_effect="$("$venv" get "{{cookiecutter.ROFI_SELECTED_WALLPAPER_EFFECT_VAR}}" --env "{{cookiecutter.BASH_VENV}}")"
current_wallpaper_effect="$("$venv" get "{{cookiecutter.ROFI_CURRENT_WALLPAPER_EFFECT_VAR}}" --env "{{cookiecutter.BASH_VENV}}")"
current_wallpaper_name="$("$venv" get "{{cookiecutter.ROFI_CURRENT_WALLPAPER_NAME_VAR}}" --env "{{cookiecutter.BASH_VENV}}")"
wallpaper_with_effect="{{cookiecutter.GENERATED_WALLPAPERS_WITH_EFFECTS_DIR}}/$current_wallpaper_name/$selected_wallpaper_effect"
#current_wallpaper_name="$(get_file_name "$current_wallpaper")"

print_debug "Selected effect $selected_wallpaper_effect" -t "info"
print_debug "Current effect $current_wallpaper_effect" -t "info"
print_debug "Current wallpaper is: $current_wallpaper_name" -t "info"
print_debug "Setting wallpaper: $wallpaper_with_effect" -t "info"

if [[ "$selected_wallpaper_effect" != "$current_wallpaper_effect" ]];then
    # 0. Change the wallpaper
    "$change_wallpaper_script" "$wallpaper_with_effect"
    # 1. Update the current wallpaper path
    "$venv" update "{{cookiecutter.ROFI_CURRENT_WALLPAPER_VAR}}" "$wallpaper_with_effect" --env "{{cookiecutter.BASH_VENV}}"
    # 2. Write the current wallpaper to rofi config
    echo "* { current-image: url(\"$wallpaper_with_effect\", height); }" > "{{cookiecutter.ROFI_CURRENT_WALLPAPER_RASI}}"
    # Update the current effect
    "$venv" update "{{cookiecutter.ROFI_CURRENT_WALLPAPER_EFFECT_VAR}}" "$selected_wallpaper_effect" --env "{{cookiecutter.BASH_VENV}}"
fi