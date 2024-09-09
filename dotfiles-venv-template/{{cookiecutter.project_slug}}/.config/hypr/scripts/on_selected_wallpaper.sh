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
# Path to change wallpaper script
change_wallpaper_script="{{cookiecutter.HYPR_SCRIPTS_DIR}}/change_wallpaper.sh"
# Path to script that generates all of the wallpapers effects variants
generate_wallpapers_with_effect_script="{{cookiecutter.HYPR_SCRIPTS_DIR}}/generate_wallpapers_with_effect.sh"

# Source required/util scripts
source $utils_dir
# Source the print_debug script
source "$print_debug_script"


###
selected_wallpaper="$("$venv" get "{{cookiecutter.ROFI_SELECTED_WALLPAPER_VAR}}" --env "{{cookiecutter.BASH_VENV}}")"
selected_wallpaper_name="$(get_file_name "$selected_wallpaper")"

current_wallpaper="$("$venv" get "{{cookiecutter.ROFI_CURRENT_WALLPAPER_VAR}}" --env "{{cookiecutter.BASH_VENV}}")"
current_wallpaper_name="$(get_file_name "$current_wallpaper")"

print_debug "Selected wallpaper: $selected_wallpaper" -t "info"
print_debug "Current wallpaper: $current_wallpaper" -t "info"
print_debug "Selected wallpaper name: $selected_wallpaper_name" -t "info"
print_debug "Current wallpaper name: $current_wallpaper_name" -t "info"

if [[ -z "$selected_wallpaper" ]];then
    print_debug "No wallpaper selected..." -t "info"
    exit 0
fi

if [[ "$selected_wallpaper_name" != "$current_wallpaper_name" ]];then
    # 0. Change the wallpaper
    "$change_wallpaper_script" "$selected_wallpaper"
    # 1. Update the current wallpaper path
    "$venv" update "{{cookiecutter.ROFI_CURRENT_WALLPAPER_VAR}}" "$selected_wallpaper" --env "{{cookiecutter.BASH_VENV}}"
    # 2. Write the current wallpaper to rofi config
    echo "* { current-image: url(\"$selected_wallpaper\", height); }" > "{{cookiecutter.ROFI_CURRENT_WALLPAPER_RASI}}"
    # Update the current wallpaper name
    "$venv" update "{{cookiecutter.ROFI_CURRENT_WALLPAPER_NAME_VAR}}" "$selected_wallpaper_name" --env "{{cookiecutter.BASH_VENV}}"
fi

eval "cached_wallpapers=("$("$venv" get "{{cookiecutter.CACHED_WALLPAPER_EFFECTS_VAR}}" --env "{{cookiecutter.BASH_VENV}}")")"
wallpaper_cached "$selected_wallpaper_name" "${cached_wallpapers[@]}"
is_wallpaper_cached=$?
if [[ "$is_wallpaper_cached" -eq 1 ]];then
    print_debug "$selected_wallpaper is not cached yet. Adding...." -t "info"
    "$generate_wallpapers_with_effect_script" "$selected_wallpaper"
    "$venv" update "{{cookiecutter.CACHED_WALLPAPER_EFFECTS_VAR}}" "$selected_wallpaper_name" --env "{{cookiecutter.BASH_VENV}}" --variable-type array
fi

