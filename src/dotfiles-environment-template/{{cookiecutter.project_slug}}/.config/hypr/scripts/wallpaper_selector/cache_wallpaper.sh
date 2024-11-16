#!/bin/bash

# Function to check if an element is in an array
is_wallpaper_cached() {
    local current_wallpaper_name="$1"
    shift
    local cached_wallpapers=("$@")

    for wallpaper in "${cached_wallpapers[@]}"; do
        if [[ "$wallpaper" == "$current_wallpaper_name" ]]; then
            return 0  # Element found
        fi
    done

    return 1  # Element not found
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
mapfile -t cached_wallpapers < <(tomlq -r '.cache.wallpapers[]' "{{cookiecutter.DOTFILES_METADATA}}")
echo "Cached wallpapers: ${cached_wallpapers[*]}"
is_wallpaper_cached "$current_wallpaper" "${cached_wallpapers[@]}"
is_wallpaper_cached=$?
if [[ "$is_wallpaper_cached" -eq 1 ]];then
    $print_debug "$current_wallpaper is not cached yet. Adding...." -t "info"
    "$generate_wallpapers_with_effect_script" "$current_wallpaper"
    tomlq --toml-output '.cache.wallpapers += ["'"$current_wallpaper"'"]' "{{cookiecutter.DOTFILES_METADATA}}" > \
        "{{cookiecutter.DOTFILES_METADATA}}.tmp" && \
        mv "{{cookiecutter.DOTFILES_METADATA}}.tmp" "{{cookiecutter.DOTFILES_METADATA}}"

else
    $print_debug "Wallpaper $current_wallpaper is already cached" -t "info"
fi
