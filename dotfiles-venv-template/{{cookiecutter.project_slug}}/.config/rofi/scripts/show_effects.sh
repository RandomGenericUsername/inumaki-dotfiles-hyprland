#!/bin/bash


show_effects() {
    "{{cookiecutter.VENV_CLI_UTILITY}}" delete "{{cookiecutter.ROFI_SELECTED_WALLPAPER_EFFECT_VAR}}" --env "{{cookiecutter.BASH_VENV}}"
	# Find all subdirectories in the effects path
    find "{{cookiecutter.HYPR_WALLPAPER_EFFECTS_DIR}}" -mindepth 1 -maxdepth 1 -type d | while read -r subdir
    do
        # Extract the effect name from the subdirectory
        effect_name=$(basename "$subdir")
        icon_file="$subdir/icon"
        echo -en "$effect_name\x00icon\x1f$icon_file\n"
    done
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
