#!/bin/bash

# Path to print debug script
print_debug_script="{{cookiecutter.PRINT_DEBUG_UTILITY}}"
source "$print_debug_script"

show_effects() {

    source "{{cookiecutter.HYPR_SCRIPTS_DIR}}/utils.sh"
    local venv="{{cookiecutter.VENV_CLI_UTILITY}}"

    "$venv" delete "{{cookiecutter.ROFI_SELECTED_WALLPAPER_EFFECT_VAR}}" --env "{{cookiecutter.BASH_VENV}}"

    current_wallpaper_name="$("$venv" get "{{cookiecutter.ROFI_CURRENT_WALLPAPER_NAME_VAR}}" --env "{{cookiecutter.BASH_VENV}}")"
    cached_wallpaper_dir="{{cookiecutter.GENERATED_WALLPAPERS_WITH_EFFECTS_DIR}}/$current_wallpaper_name"
    print_debug "Current wallpaper is: $current_wallpaper_name" -t "info"

	# Find all subdirectories in the effects path
    find "{{cookiecutter.HYPR_WALLPAPER_EFFECTS_DIR}}" -mindepth 1 -maxdepth 1 -type d | while read -r subdir
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
    "{{cookiecutter.VENV_CLI_UTILITY}}" set "{{cookiecutter.ROFI_SELECTED_WALLPAPER_EFFECT_VAR}}" "$selected" --env "{{cookiecutter.BASH_VENV}}"
}

if [ "$ROFI_RETV" -eq 0 ]; then
	show_effects "$@"
elif [ "$ROFI_RETV" -eq 1 ]; then
	on_selected_effect "$@"
fi
