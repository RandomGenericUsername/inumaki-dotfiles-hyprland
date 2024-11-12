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

# Path to utils (authentic_path, _or)
utils_dir="{{cookiecutter.HYPR_DIR}}/scripts/utils.sh"
# Path to print debug script
print_debug="{{cookiecutter.PRINT_DEBUG_UTIL}}"
# Path to script that generates all of the wallpapers effects variants
generate_wallpapers_with_effect_script="{{cookiecutter.HYPR_DIR}}/scripts/wallpaper_selector/generate_wallpapers_with_effects.sh"
# Path to variable handler script
variables_handler="{{cookiecutter.HYPR_DIR}}/scripts/variables_handler.sh"

# Source required/util scripts
source $utils_dir
# Source the variables handler script
source "$variables_handler"


current_wallpaper="$(get_variable "wallpaper.current.path")" 
current_wallpaper_name="$(get_variable "wallpaper.current.name")"


eval "cached_wallpapers=($(get_variable "wallpaper.cached" ))"
wallpaper_cached "$current_wallpaper_name" "${cached_wallpapers[@]}"
is_wallpaper_cached=$?
if [[ "$is_wallpaper_cached" -eq 1 ]];then
    $print_debug "$current_wallpaper is not cached yet. Adding...." -t "info"
    "$generate_wallpapers_with_effect_script" "$current_wallpaper"

    # Add a new item to the array
    cached_wallpapers+=("$current_wallpaper")

    # Convert the array to TOML format
    toml_array="[$(printf '"%s", ' "${cached_wallpapers[@]}")]"
    echo "$toml_array"  # This should display the array as expected by TOML

    # Save it back to the TOML file
    set_variable "wallpaper.cached" "$toml_array"

    exit 0
fi
$print_debug "Wallpaper $current_wallpaper_name | $current_wallpaper is already cached" -t "info"
exit 0
