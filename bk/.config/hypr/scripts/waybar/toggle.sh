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
current_waybar_status="$("$venv" get "{{cookiecutter.WAYBAR_CURRENT_STATUS_VAR}}" --env "{{cookiecutter.BASH_VENV}}")"
[[ -z "$current_waybar_status" ]] && current_waybar_status="enabled"

if [[ "$current_waybar_status" == "enabled" ]];then
    "$venv" set "{{cookiecutter.WAYBAR_CURRENT_STATUS_VAR}}" "disabled" --env "{{cookiecutter.BASH_VENV}}"
    command="killall waybar"
elif [[ "$current_waybar_status" == "disabled" ]];then
    "$venv" set "{{cookiecutter.WAYBAR_CURRENT_STATUS_VAR}}" "enabled" --env "{{cookiecutter.BASH_VENV}}"
    command="$("$venv" get "{{cookiecutter.WAYBAR_CURRENT_LAUNCH_COMMAND_VAR}}" --env "{{cookiecutter.BASH_VENV}}")"
    if [[ -z "$command" ]];then
        command="waybar -c {{cookiecutter.WAYBAR_THEMES_DIR}}/default/config -s {{cookiecutter.WAYBAR_THEMES_DIR}}/default/style.css &"
        print_debug "No launch command found, using default one: $command"
    fi
else
    print_debug "Error. State: $current_waybar_status is not recognized" -t "error"
    exit 0
fi

eval "$command"


