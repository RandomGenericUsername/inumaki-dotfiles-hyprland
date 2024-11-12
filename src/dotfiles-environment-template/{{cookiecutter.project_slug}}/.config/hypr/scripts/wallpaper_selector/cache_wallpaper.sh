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
generate_wallpapers_with_effect_script="{{cookiecutter.HYPR_DIR}}/scripts/wallpaper_selector/generate_wallpapers_with_effect.sh"
# Path to variable handler script
variables_handler="{{cookiecutter.HYPR_DIR}}/scripts/variables_handler.sh"

# Source required/util scripts
source $utils_dir
# Source the variables handler script
source "$variables_handler"


current_wallpaper="$(get_variable "wallpaper.current.path")" 
current_wallpaper_name="$(get_variable "wallpaper.current.name")"


eval "cached_wallpapers=($(get_variable "wallpaper.cached" ))"
echo "Cached wallpapers: ${cached_wallpapers[@]}"

exit 0
