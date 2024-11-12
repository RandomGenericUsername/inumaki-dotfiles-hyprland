#!/bin/bash

# Path to utils (authentic_path, _or)
utils_dir="{{cookiecutter.HYPR_DIR}}/scripts/utils.sh"
# Path to print debug script
print_debug="{{cookiecutter.PRINT_DEBUG_UTIL}}"
# Path to variables handler script
variables_handler="{{cookiecutter.HYPR_DIR}}/scripts/variables_handler.sh"


source "$utils_dir"
source "$variables_handler"


rofi -show "Waybar themes selector" -i replace -config "{{cookiecutter.ROFI_DIR}}/waybar-themes.rasi"

selected_theme="$(get_variable "waybar.theme.selected")"    
if [[ -z "$selected_theme" ]];then
    $print_debug "No theme was selected..." -t "error"
    exit 1
fi

$print_debug "Selected theme: $selected_theme" -t "info"

killall waybar

IFS=';' read -ra arrThemes <<< "$selected_theme"
if [ ! -f "{{cookiecutter.WAYBAR_DIR}}/themes/${arrThemes[1]}/style.css" ]; then
    $print_debug "Selected theme: $selected_theme does not define a CSS. Using default..." -t "error"
    waybar_theme="{{cookiecutter.WAYBAR_DEFAULT_THEME}}"
fi

config_file="config"
style_file="style.css"
# Standard files can be overwritten with an existing config-custom or style-custom.css
if [ -f "{{cookiecutter.WAYBAR_DIR}}/themes/${arrThemes[0]}/custom-config" ] ;then
    config_file="custom-config"
fi
if [ -f "{{cookiecutter.WAYBAR_DIR}}/themes/${arrThemes[1]}/custom-style.css" ] ;then
    style_file="custom-style.css"
fi

launch="waybar -c {{cookiecutter.WAYBAR_DIR}}/themes/${arrThemes[0]}/$config_file -s {{cookiecutter.WAYBAR_DIR}}/themes/${arrThemes[1]}/$style_file &"
# Check if a custom launch script exists for the theme.
if [ -f "{{cookiecutter.WAYBAR_DIR}}/themes/${arrThemes[0]}/launch.sh" ]; then
	print_debug "Custom waybar command found" -t "info"
    launch="{{cookiecutter.WAYBAR_DIR}}/themes/${arrThemes[0]}/launch.sh"
fi

set_variable "waybar.launch_command" "$launch"
$print_debug "Applying theme: $waybar_theme" -t "info"
$print_debug "Executing launch command: $launch"  -t "info"
eval "$launch"


