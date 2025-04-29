#!/bin/bash

# Path to print debug script
print_debug="{{cookiecutter.PRINT_DEBUG_UTIL}}"
# Path to variables handler script
variables_handler="{{cookiecutter.VARIABLES_HANDLER_SCRIPT}}"
# Path to utils (authentic_path, _or)
utils_dir="{{cookiecutter.UTILS_SCRIPT}}"
# Path to Argument parser script
arg_parser_script="{{cookiecutter.ARGUMENT_PARSER_UTIL}}"
# Script that will get executed if a wallpaper is selected
on_selected_wallpaper="{{cookiecutter.ON_SELECTED_WALLPAPER_SCRIPT}}"
# Script that will get executed if a wallpaper effect is selected
on_selected_wallpaper_effect="{{cookiecutter.ON_SELECTED_WALLPAPER_EFFECT_SCRIPT}}"
# Script that applies the generated color palleted using pywal
apply_pywal_color_pallete="{{cookiecutter.APPLY_PYWAL_PALLETE_SCRIPT}}"
# Script to reload waybar
toggle_waybar="{{cookiecutter.WAYBAR_TOGGLE_SCRIPT}}"
# Script to cache the generated wallpapers
cache_wallpaper="{{cookiecutter.CACHE_WALLPAPER_SCRIPT}}"
# path to create battery icon script
create_battery_icon="{{cookiecutter.WAYBAR_CREATE_BATTERY_ICON_SCRIPT}}"

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
    echo "About to show wallpapers"
    rofi -show Wallpaper -i -replace -config "{{cookiecutter.ROFI_CONFIG_WALLPAPERS_AND_EFFECTS_MODE}}"
elif [[ "$COMMAND" == "wallpaper-effect" ]];then
    rofi -show Effects -i -replace -config "{{cookiecutter.ROFI_CONFIG_WALLPAPERS_AND_EFFECTS_MODE}}"
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

# Apply pywal to the current wallpaper
"$apply_pywal_color_pallete" 

# Create waybar battery icon
"$create_battery_icon" "{{cookiecutter.WAYBAR_ASSETS_DIR}}/templates/battery-icons/battery-0.svg" "{{cookiecutter.WAYBAR_ASSETS_DIR}}/battery-icons/battery-0.svg" "$HOME/.cache/wal/colors.sh" "foreground"
"$create_battery_icon" "{{cookiecutter.WAYBAR_ASSETS_DIR}}/templates/battery-icons/battery-25.svg" "{{cookiecutter.WAYBAR_ASSETS_DIR}}/battery-icons/battery-25.svg" "$HOME/.cache/wal/colors.sh" "foreground"
"$create_battery_icon" "{{cookiecutter.WAYBAR_ASSETS_DIR}}/templates/battery-icons/battery-50.svg" "{{cookiecutter.WAYBAR_ASSETS_DIR}}/battery-icons/battery-50.svg" "$HOME/.cache/wal/colors.sh" "foreground"
"$create_battery_icon" "{{cookiecutter.WAYBAR_ASSETS_DIR}}/templates/battery-icons/battery-75.svg" "{{cookiecutter.WAYBAR_ASSETS_DIR}}/battery-icons/battery-75.svg" "$HOME/.cache/wal/colors.sh" "foreground"
"$create_battery_icon" "{{cookiecutter.WAYBAR_ASSETS_DIR}}/templates/battery-icons/battery-100.svg" "{{cookiecutter.WAYBAR_ASSETS_DIR}}/battery-icons/battery-100.svg" "$HOME/.cache/wal/colors.sh" "foreground"
"$create_battery_icon" "{{cookiecutter.WAYBAR_ASSETS_DIR}}/templates/battery-icons/battery-0-charging.svg" "{{cookiecutter.WAYBAR_ASSETS_DIR}}/battery-icons/battery-0-charging.svg" "$HOME/.cache/wal/colors.sh" "foreground"
"$create_battery_icon" "{{cookiecutter.WAYBAR_ASSETS_DIR}}/templates/battery-icons/battery-25-charging.svg" "{{cookiecutter.WAYBAR_ASSETS_DIR}}/battery-icons/battery-25-charging.svg" "$HOME/.cache/wal/colors.sh" "foreground"
"$create_battery_icon" "{{cookiecutter.WAYBAR_ASSETS_DIR}}/templates/battery-icons/battery-50-charging.svg" "{{cookiecutter.WAYBAR_ASSETS_DIR}}/battery-icons/battery-50-charging.svg" "$HOME/.cache/wal/colors.sh" "foreground"
"$create_battery_icon" "{{cookiecutter.WAYBAR_ASSETS_DIR}}/templates/battery-icons/battery-75-charging.svg" "{{cookiecutter.WAYBAR_ASSETS_DIR}}/battery-icons/battery-75-charging.svg" "$HOME/.cache/wal/colors.sh" "foreground"
"$create_battery_icon" "{{cookiecutter.WAYBAR_ASSETS_DIR}}/templates/battery-icons/battery-100-charging.svg" "{{cookiecutter.WAYBAR_ASSETS_DIR}}/battery-icons/battery-100-charging.svg" "$HOME/.cache/wal/colors.sh" "foreground"


# Reload waybar
"$toggle_waybar"
"$toggle_waybar"

# Cache the wallpapers
"$cache_wallpaper"
