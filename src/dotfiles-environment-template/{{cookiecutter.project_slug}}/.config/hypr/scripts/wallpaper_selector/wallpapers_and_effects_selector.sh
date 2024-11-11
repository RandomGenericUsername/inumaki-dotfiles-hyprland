#!/bin/bash

# Path to print debug script
print_debug="{{cookiecutter.PRINT_DEBUG_UTIL}}"
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
# shellcheck disable=SC1090
source $utils_dir
# Source the argument parser script
# shellcheck disable=SC1090
source "$arg_parser_script"
# Source the variables handler script
# shellcheck disable=SC1090
source "$variables_handler"

# Set the number of mandatory arguments for this script
mandatory_arguments=1
# Define the allowed values for the argument
allowed_commands=("wallpaper" "wallpaper-effect")
set_mandatory_arguments $mandatory_arguments 1:"${allowed_commands[*]}"
# Parse the command line arguments
parse_command_line "$@"
COMMAND="${POSITIONAL_ARGS[0]}"

# Set the wallpaper directory
wallpaper_dir="$( authentic_path "{{cookiecutter.WALLPAPERS_DIR}}" )"
export wallpaper_dir

# Execute the right command
if [[ "$COMMAND" == "wallpaper" ]];then
    rofi -show Wallpaper -i -replace -config "{{cookiecutter.ROFI_DIR}}/wallpapers-and-effects-mode.rasi"
elif [[ "$COMMAND" == "wallpaper-effect" ]];then
    rofi -show Effects -i -replace -config "{{cookiecutter.ROFI_DIR}}/wallpapers-and-effects-mode.rasi"
fi

selected_wallpaper="$(get_variable "wallpaper.selected.path")"
selected_wallpaper_effect="$(get_variable "wallpaper.effect.selected.path")"

if [[ -n "$selected_wallpaper" ]] && [[ -z "$selected_wallpaper_effect" ]];then
    $print_debug "Selected wallpaper event" -t "info"
    "$on_selected_wallpaper"
elif [[ -z "$selected_wallpaper" ]] && [[ -n "$selected_wallpaper_effect" ]];then
    $print_debug "Selected wallpaper effect event" -t "info"
    "$on_selected_wallpaper_effect"
else
    $print_debug "No wallpaper nor effect selected" -t "warn"
    exit 0
fi
exit 0

# Apply pywal to the current wallpaper
"$apply_pywal_color_pallete"

# Reload waybar
"$toggle_waybar"
"$toggle_waybar"

print_debug "Finished but generating wallpapers" -t "info"
# Cache the wallpapers
"$cache_wallpapers"
print_debug "Finished!!!" -t "info"
