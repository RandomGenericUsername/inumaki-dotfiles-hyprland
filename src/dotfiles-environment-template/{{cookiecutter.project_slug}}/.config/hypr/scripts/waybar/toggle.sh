#!/bin/bash

# Path to utils (authentic_path, _or)
utils_dir="{{cookiecutter.HYPR_DIR}}/scripts/utils.sh"
# Path to print debug script
print_debug="{{cookiecutter.PRINT_DEBUG_UTIL}}"
# Path to change wallpaper script
change_wallpaper_script="{{cookiecutter.HYPR_DIR}}/scripts/wallpaper_selector/change_wallpaper.sh"
# Path to variables handler script
variables_handler="{{cookiecutter.HYPR_DIR}}/scripts/variables_handler.sh"

source "$utils_dir"
source "$variables_handler"

current_waybar_status="$(get_variable "waybar.status")"
[[ -z "$current_waybar_status" ]] || [[ "$current_waybar_status" == "null" ]] && current_waybar_status="enabled"

if [[ "$current_waybar_status" == "enabled" ]];then
    set_variable "waybar.status" "disabled"
    command="killall waybar"
elif [[ "$current_waybar_status" == "disabled" ]];then
    set_variable "waybar.status" "enabled"
    command="$(get_variable "waybar.launch_command")"   
    if [[ -z "$command" ]] || [[ "$command" == "none" ]] || [[ "$command" == "null" ]];then
        command="waybar -c {{cookiecutter.WAYBAR_DIR}}/themes/default/config -s {{cookiecutter.WAYBAR_DIR}}/themes/default/style.css &"
        $print_debug "No launch command found, using default one: $command"
    fi
else
    $print_debug "Error. State: $current_waybar_status is not recognized" -t "error"
    exit 0
fi

eval "$command"


