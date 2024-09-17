#!/bin/bash

# Function to check if an element is in an array
wallpaper_cached() {
    local element="$1"
    shift
    local array=("$@")
    for item in "${array[@]}"; do
        if [[ "$item" == "$element" ]]; then
            return 0  # Found, return success
        fi
    done

    return 1  # Not found, return failure
}

# Path to venv script
venv="{{cookiecutter.VENV_CLI_UTILITY}}"
# Path to utils (authentic_path, _or)
utils_dir="{{cookiecutter.HYPR_SCRIPTS_DIR}}/utils.sh"
# Path to print debug script
print_debug_script="{{cookiecutter.PRINT_DEBUG_UTILITY}}"
# Path to script that generates all of the wallpapers effects variants
generate_wallpapers_with_effect_script="{{cookiecutter.WALLPAPER_SELECTOR_SCRIPTS_DIR}}/generate_wallpapers_with_effect.sh"

# Source required/util scripts
source $utils_dir
# Source the print_debug script
source "$print_debug_script"


current_wallpaper="$("$venv" get "{{cookiecutter.ROFI_CURRENT_WALLPAPER_VAR}}" --env "{{cookiecutter.BASH_VENV}}")"
current_wallpaper_name="$(get_file_name "$current_wallpaper")"


eval "cached_wallpapers=("$("$venv" get "{{cookiecutter.CACHED_WALLPAPER_EFFECTS_VAR}}" --env "{{cookiecutter.BASH_VENV}}")")"
wallpaper_cached "$current_wallpaper_name" "${cached_wallpapers[@]}"
is_wallpaper_cached=$?
if [[ "$is_wallpaper_cached" -eq 1 ]];then
    print_debug "$current_wallpaper is not cached yet. Adding...." -t "info"
    "$generate_wallpapers_with_effect_script" "$current_wallpaper"
    "$venv" update "{{cookiecutter.CACHED_WALLPAPER_EFFECTS_VAR}}" "$current_wallpaper_name" --env "{{cookiecutter.BASH_VENV}}" --variable-type array
    exit 0
fi
print_debug "Wallpaper $current_wallpaper_name | $current_wallpaper is already cached" -t "info"