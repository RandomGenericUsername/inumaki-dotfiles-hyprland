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


show_effects() {
    set_variable "wallpaper.effect.selected.name" ""
    set_variable "wallpaper.effect.selected.path" ""
    current_wallpaper_name="$(get_variable "wallpaper.current.name")"
    cached_wallpaper_dir="{{cookiecutter.GENERATED_WALLPAPERS_WITH_EFFECTS_DIR}}/$current_wallpaper_name"

	# Find all subdirectories in the effects path
    find "{{cookiecutter.HYPR_DIR}}/effects/wallpapers" -mindepth 1 -maxdepth 1 -type d | while read -r subdir
    do
        # Extract the effect name from the subdirectory
        effect_name=$(basename "$subdir")
        local icon_file="$cached_wallpaper_dir/$effect_name"
        if [[ -f "$icon_file" ]];then
            echo -en "$effect_name\x00icon\x1f$icon_file\n"
        else
            icon_file="{{cookiecutter.GENERATED_WALLPAPERS_WITH_EFFECTS_DIR}}/$current_wallpaper_name/off"
            print_debug "No preview icon for wallpaper $current_wallpaper_name with effect $effect_name" -t "error"
            echo -en "$effect_name\x00icon\x1f$icon_file\n"
        fi

    done
    echo -en "off\x00icon\x1f$cached_wallpaper_dir/off"
}

on_selected_effect(){
	local selected="$1"
    set_variable "wallpaper.effect.selected.path" "$selected"
    set_variable "wallpaper.effect.selected.name" "$(get_base_name "$selected")"
}

if [ "$ROFI_RETV" -eq 0 ]; then
	show_effects "$@"
elif [ "$ROFI_RETV" -eq 1 ]; then
	on_selected_effect "$@"
fi