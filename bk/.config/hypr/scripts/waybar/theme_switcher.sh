#!/bin/bash

# Path to venv script
venv="{{cookiecutter.VENV_CLI_UTILITY}}"
# Path to utils (authentic_path, _or)
utils_dir="{{cookiecutter.HYPR_SCRIPTS_DIR}}/utils.sh"
# Path to print debug script
print_debug_script="{{cookiecutter.PRINT_DEBUG_UTILITY}}"

# 
source "$utils_dir"
source "$print_debug_script"


rofi -show "Waybar themes selector" -i replace -config "{{cookiecutter.ROFI_DIR}}/waybar-themes.rasi"

selected_theme="$("$venv" get "{{cookiecutter.SELECTED_WAYBAR_THEME_VAR}}" --env "{{cookiecutter.BASH_VENV}}")"
if [[ -z "$selected_theme" ]];then
    print_debug "No theme was selected..." -t "error"
    exit 1
fi

print_debug "Selected theme: $selected_theme" -t "info"

killall waybar

IFS=';' read -ra arrThemes <<< "$selected_theme"
if [ ! -f "{{cookiecutter.WAYBAR_THEMES_DIR}}${arrThemes[1]}/style.css" ]; then
    print_debug "Selected theme: $selected_theme does not define a CSS. Using default..." -t "error"
    waybar_theme="{{cookiecutter.WAYBAR_DEFAULT_THEME}}"
fi

config_file="config"
style_file="style.css"
# Standard files can be overwritten with an existing config-custom or style-custom.css
if [ -f "{{cookiecutter.WAYBAR_THEMES_DIR}}${arrThemes[0]}/custom-config" ] ;then
    config_file="custom-config"
fi
if [ -f "{{cookiecutter.WAYBAR_THEMES_DIR}}${arrThemes[1]}/custom-style.css" ] ;then
    style_file="custom-style.css"
fi

launch="waybar -c {{cookiecutter.WAYBAR_THEMES_DIR}}${arrThemes[0]}/$config_file -s {{cookiecutter.WAYBAR_THEMES_DIR}}${arrThemes[1]}/$style_file &"
# Check if a custom launch script exists for the theme.
if [ -f "{{cookiecutter.WAYBAR_THEMES_DIR}}${arrThemes[0]}/launch.sh" ]; then
	print_debug "Custom waybar command found" -t "info"
    launch="{{cookiecutter.WAYBAR_THEMES_DIR}}${arrThemes[0]}/launch.sh"
fi

"$venv" set "{{cookiecutter.WAYBAR_CURRENT_LAUNCH_COMMAND_VAR}}" "$launch" --env "{{cookiecutter.BASH_VENV}}"
print_debug "Applying theme: $waybar_theme" -t "info"
print_debug "Executing launch command: $launch"  -t "info"
eval "$launch"


