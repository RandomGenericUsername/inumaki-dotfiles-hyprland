#!/bin/bash

# Path to venv script
venv="{{cookiecutter.VENV_CLI_UTILITY}}"
# Path to utils (authentic_path, _or)
utils_dir="{{cookiecutter.HYPR_SCRIPTS_DIR}}/utils.sh"
# Path to Argument parser script
arg_parser_script="{{cookiecutter.ARGUMENT_PARSER_UTILITY}}"
# Path to print debug script
print_debug_script="{{cookiecutter.PRINT_DEBUG_UTILITY}}"
# Script that will get executed if a wallpaper is selected
on_selected_wallpaper="{{cookiecutter.WALLPAPER_SELECTOR_SCRIPTS_DIR}}/on_selected_wallpaper.sh"
# Script that will get executed if a wallpaper effect is selected
on_selected_wallpaper_effect="{{cookiecutter.WALLPAPER_SELECTOR_SCRIPTS_DIR}}/on_selected_wallpaper_effect.sh"
# Script that applies the generated color palleted using pywal
apply_pywal_color_pallete="{{cookiecutter.WALLPAPER_SELECTOR_SCRIPTS_DIR}}/apply_pywal_pallete.sh"
# Script to reload waybar
toggle_waybar="{{cookiecutter.HYPR_SCRIPTS_DIR}}/waybar/toggle.sh"
# Script to cache the generated wallpapers
cache_wallpapers="{{cookiecutter.WALLPAPER_SELECTOR_SCRIPTS_DIR}}/cache_wallpapers.sh"

# Source required/util scripts
source $utils_dir
# Source the print_debug script
source "$print_debug_script"
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

# Load a custom wallpaper dir from venv
custom_wallpaper_dir="$("$venv" get "{{cookiecutter.CUSTOM_WALLPAPER_DIR_VAR}}" --env "{{cookiecutter.BASH_VENV}}" )"

# Define the wallpaper directory accordingly if a custom dir is set 
export wallpaper_dir; wallpaper_dir="$( authentic_path "$(_or "$custom_wallpaper_dir" "{{cookiecutter.WALLPAPERS_DIR}}")" )"


# Execute the right command
if [[ "$COMMAND" == "wallpaper" ]];then
    rofi -show Wallpaper -i -replace -config "{{cookiecutter.ROFI_DIR}}/wallpapers-and-effects-mode.rasi"
elif [[ "$COMMAND" == "wallpaper-effect" ]];then
    rofi -show Effects -i -replace -config "{{cookiecutter.ROFI_DIR}}/wallpapers-and-effects-mode.rasi"
fi

selected_wallpaper="$( "$venv" get "{{cookiecutter.ROFI_SELECTED_WALLPAPER_VAR}}" --env "{{cookiecutter.BASH_VENV}}" )"
selected_wallpaper_effect="$( "$venv" get "{{cookiecutter.ROFI_SELECTED_WALLPAPER_EFFECT_VAR}}" --env "{{cookiecutter.BASH_VENV}}" )"

if [[ -n "$selected_wallpaper" ]] && [[ -z "$selected_wallpaper_effect" ]];then
    print_debug "Selected wallpaper event" -t "info"
    "$on_selected_wallpaper"
elif [[ -z "$selected_wallpaper" ]] && [[ -n "$selected_wallpaper_effect" ]];then
    print_debug "Selected wallpaper effect event" -t "info"
    "$on_selected_wallpaper_effect"
else
    print_debug "No wallpaper nor effect selected" -t "warn"
    exit 0
fi

# Apply pywal to the current wallpaper
#"$apply_pywal_color_pallete"

# Reload waybar
#"$toggle_waybar"
#"$toggle_waybar"

print_debug "Finished but generating wallpapers" -t "info"
# Cache the wallpapers
"$cache_wallpapers"
print_debug "Finished!!!" -t "info"

