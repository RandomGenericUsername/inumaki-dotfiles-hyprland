#!/bin/bash

# Path to print debug script
print_debug_script="{{cookiecutter.PRINT_DEBUG_UTIL}}"
# Path to variables handler script
variables_handler="{{cookiecutter.HYPR_DIR}}/scripts/variables_handler.sh"
# Path to utils (authentic_path, _or)
utils_dir="{{cookiecutter.HYPR_DIR}}/scripts/utils.sh"
# Path to Argument parser script
arg_parser_script="{{cookiecutter.ARGUMENT_PARSER_UTIL}}"
# Script that will get executed if a wallpaper is selected
on_selected_wallpaper="{{cookiecutter.HYPR_DIR}}/scripts/wallpaper_selector/on_selected_wallpaper.sh"
# Script that will get executed if a wallpaper effect is selected
on_selected_wallpaper_effect="{{cookiecutter.HYPR_DIR}}/scripts/wallpaper_selector/on_selected_wallpaper_effect.sh"
# Script that applies the generated color palleted using pywal
apply_pywal_color_pallete="{{cookiecutter.HYPR_DIR}}/scripts/wallpaper_selector/apply_pywal_pallete.sh"
# Script to reload waybar
toggle_waybar="{{cookiecutter.HYPR_DIR}}/scripts/waybar/toggle.sh"
# Script to cache the generated wallpapers
cache_wallpapers="{{cookiecutter.HYPR_DIR}}/scripts/wallpaper_selector/cache_wallpapers.sh"

# Source required/util scripts
source $utils_dir
# Source the argument parser script
source "$arg_parser_script"

# Set the number of mandatory arguments for this script
mandatory_arguments=1
# Define the allowed values for the argument
allowed_commands=("wallpaper" "wallpaper-effect")
set_mandatory_arguments $mandatory_arguments 1:"${allowed_commands[*]}"
# Parse the command line arguments
parse_command_line "$@"
COMMAND="${POSITIONAL_ARGS[0]}"


exit 0