#!/bin/bash

# Path to utils (authentic_path, _or)
utils_dir="{{cookiecutter.UTILS_SCRIPT}}"
# Path to print debug script
print_debug="{{cookiecutter.PRINT_DEBUG_UTIL}}"
# Path to variables handler script
variables_handler="{{cookiecutter.VARIABLES_HANDLER_SCRIPT}}"
# Path to script to generate waybar CSS
create_waybar_stylesheet="{{cookiecutter.GENERATE_WAYBAR_STYLESHEET_SCRIPT}}"


source "$utils_dir"
source "$variables_handler"

if [[ -z "$@" ]]; then
    rofi -show "Waybar themes selector" -i replace -config "{{cookiecutter.ROFI_CONFIG_WAYBAR_THEMES_MODE}}"
    selected_theme="$(get_variable "waybar.theme.selected")"    
else
    selected_theme="$@"
fi

if [[ -z "$selected_theme" ]];then
    $print_debug "No theme was selected..." -t "error"
    exit 1
fi

$print_debug "Selected theme: $selected_theme" -t "info"

killall waybar

IFS=';' read -ra arrThemes <<< "$selected_theme"

config_file="config"
style_file="style.css"
use_custom_style="false"
# Standard files can be overwritten with an existing config-custom or style-custom.css
if [ -f "{{cookiecutter.WAYBAR_THEMES_DIR}}/${arrThemes[0]}/custom-config" ] ;then
    config_file="custom-config"
fi
if [ -f "{{cookiecutter.WAYBAR_THEMES_DIR}}/${arrThemes[1]}/custom-style.css" ] ;then
    use_custom_style="true"
    style_file="custom-style.css"
fi
if [ "$use_custom_style" == "false" ]; then
    $create_waybar_stylesheet -o "{{cookiecutter.WAYBAR_THEMES_DIR}}/${arrThemes[1]}/$style_file" -e "{{cookiecutter.WAYBAR_THEMES_DIR}}/${arrThemes[0]}/config.sh" -t "{{cookiecutter.WAYBAR_THEMES_DIR}}/${arrThemes[1]}/$style_file.tpl"
fi
if [ ! -f "{{cookiecutter.WAYBAR_THEMES_DIR}}/${arrThemes[1]}/$style_file" ]; then
    $print_debug "Selected theme: $selected_theme does not define a CSS. Using default..." -t "error"
    #waybar_theme="{{cookiecutter.WAYBAR_DEFAULT_THEME}}"
fi

launch="waybar -c {{cookiecutter.WAYBAR_THEMES_DIR}}${arrThemes[0]}/$config_file -s {{cookiecutter.WAYBAR_THEMES_DIR}}${arrThemes[1]}/$style_file &"
# Check if a custom launch script exists for the theme.
if [ -f "{{cookiecutter.WAYBAR_THEMES_DIR}}/${arrThemes[0]}/launch.sh" ]; then
	print_debug "Custom waybar command found" -t "info"
    launch="{{cookiecutter.WAYBAR_THEMES_DIR}}${arrThemes[0]}/launch.sh"
fi

set_variable "waybar.launch_command" "$launch"
$print_debug "Applying theme: ${arrThemes[0]}" -t "info"
$print_debug "Executing launch command: $launch"  -t "info"
eval "$launch"


