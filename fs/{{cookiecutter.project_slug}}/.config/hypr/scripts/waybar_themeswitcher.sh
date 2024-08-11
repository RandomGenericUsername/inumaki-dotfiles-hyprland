#!/bin/bash

kill_waybar() {
    echo "Attempting to kill all Waybar instances"

    # Check if any Waybar instances are running
    if pgrep waybar > /dev/null; then
        echo "Waybar is running, terminating instances..."
        killall waybar
        sleep 0.2
        echo "Waybar instances terminated"
    else
        echo "No Waybar instances are running"
    fi
}

use_default=false
default_theme="/default;/default/"
utils_dir="{{cookiecutter.HYPR_SCRIPTS_DIR}}/utils.sh"
waybar_cached_status="{{cookiecutter.CACHE_DIR}}/waybar-disabled"
waybar_theme_file="{{cookiecutter.CACHE_DIR}}/waybar-theme.sh"
# shellcheck disable=SC1090
source $utils_dir


# Parse command-line arguments
for arg in "$@"; do
    case $arg in
        -d|--default)
        use_default="true"
        shift
        ;;
    esac
done

if [[ $use_default == "true" ]]; then
    echo "$default_theme" > "$waybar_theme_file"
else
    rofi -show "Waybar themes selector" -i -replace -config "{{cookiecutter.ROFI_DIR}}/waybar-themes.rasi"
fi

if [[ "$(safe_cat "$waybar_theme_file")" == "" ]]; then
    echo "No theme selected. Exiting..."
    exit 0
fi

if [[ "$(safe_cat "$waybar_cached_status")" == "disabled" ]]; then
    echo "Disabling waybar"
    kill_waybar
    exit 0
fi

waybar_theme=$(safe_cat "$waybar_theme_file")

kill_waybar

IFS=';' read -ra arrThemes <<< "$waybar_theme"
if [ ! -f "{{cookiecutter.WAYBAR_THEMES_DIR}}${arrThemes[1]}/style.css" ]; then
    waybar_theme="$default_theme"
fi

config_file="config"
style_file="style.css"

# Standard files can be overwritten with an existing config-custom or style-custom.css
if [ -f "{{cookiecutter.WAYBAR_THEMES_DIR}}${arrThemes[0]}/custom-config" ] ;then
    config_file="custom-config"
fi
if [ -f "{{cookiecutter.WAYBAR_THEMES_DIR}}${arrThemes[1]}/style-custom.css" ] ;then
    style_file="style-custom.css"
fi

launch="waybar -c {{cookiecutter.WAYBAR_THEMES_DIR}}${arrThemes[0]}/$config_file -s {{cookiecutter.WAYBAR_THEMES_DIR}}${arrThemes[1]}/$style_file &"
# Check if a custom launch script exists for the theme.
if [ -f "{{cookiecutter.WAYBAR_THEMES_DIR}}${arrThemes[0]}/main-config" ]; then
	echo "Custom waybar command found"
    launch="{{cookiecutter.WAYBAR_THEMES_DIR}}${arrThemes[0]}/launch.sh"
fi

echo "Applying theme: $waybar_theme"
echo "Executing launch command: $launch"
eval "$launch"


