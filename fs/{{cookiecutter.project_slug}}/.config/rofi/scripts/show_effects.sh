#!/bin/bash


show_effects() {
    effects_path="{{cookiecutter.HYPR_WALLPAPER_EFFECTS_DIR}}"
	echo "" > "{{cookiecutter.SELECTED_WALLPAPER_EFFECT_FILE}}"
	# Find all subdirectories in the effects path
    find "$effects_path" -mindepth 1 -maxdepth 1 -type d | while read -r subdir
    do
        # Extract the effect name from the subdirectory
        effect_name=$(basename "$subdir")
        icon_file="$subdir/icon"
        echo -en "$effect_name\x00icon\x1f$icon_file\n"
    done
}

on_selected_effect(){
	local selected="$1"
	echo "$selected" > "{{cookiecutter.SELECTED_WALLPAPER_EFFECT_FILE}}"
	echo "$selected" > "{{cookiecutter.CURRENT_WALLPAPER_EFFECT_FILE}}"
}

if [ "$ROFI_RETV" -eq 0 ]; then
	show_effects "$@"
elif [ "$ROFI_RETV" -eq 1 ]; then
	on_selected_effect "$@"
fi

# Source the argument parser script
#path={{cookiecutter.HYPR_WALLPAPER_EFFECTS_DIR}}
#arg_parser={{cookiecutter.SCRIPTS_DIR}}/arg_parser.sh
#source $arg_parser
## Define the arguments and their corresponding variable names
#effects_path_options=("--path" "-p")
## Define the arguments and their corresponding variable names
#args=( "effects_path_options" "EFFECTS_PATH" )
## Parse the argument definitions
#parse_args "${args[@]}"
## Parse the command line arguments
#parse_command_line "$@"
# Get the value of the argument