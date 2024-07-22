#!/bin/bash


show_effects() {
    # Source the argument parser script
	#path={{cookiecutter.HYPR_WALLPAPER_EFFECTS_DIR}}
    arg_parser={{cookiecutter.SCRIPTS_DIR}}/arg_parser.sh
    source $arg_parser
    # Define the arguments and their corresponding variable names
    effects_path_options=("--path" "-p")
    # Define the arguments and their corresponding variable names
    args=( "effects_path_options" "EFFECTS_PATH" )
    # Parse the argument definitions
    parse_args "${args[@]}"
    # Parse the command line arguments
    parse_command_line "$@"
    # Get the value of the argument
    effects_path=$(get_arg_value "EFFECTS_PATH")
	options="$(ls $effects_path)\noff"
	echo -e "$options"
}

on_selected_effect(){
	effects_folder="$2"
	selected="$3"
	if [ -z "$selected" ]; then
		exit 1
	fi
	echo "$selected" > {{cookiecutter.WALLPAPER_EFFECT}}
	dunstify "Changing Wallpaper Effect to " "$selected"
	{{cookiecutter.HYPR_SCRIPTS_DIR}}/wallpaper.sh init
	exit 0
}

if [ "$ROFI_RETV" -eq 0 ]; then
	show_effects "$@"
elif [ "$ROFI_RETV" -eq 1 ] && [ -n "$3" ]; then
	on_selected_effect "$@"
fi
