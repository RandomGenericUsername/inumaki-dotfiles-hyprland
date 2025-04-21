#!/bin/bash

# Path to print debug script
print_debug="{{cookiecutter.PRINT_DEBUG_UTIL}}"
# Path to variables handler script
variables_handler="{{cookiecutter.VARIABLES_HANDLER_SCRIPT}}"
source "$variables_handler"

launch_command="$(get_variable "waybar.launch_command")"
$print_debug "Executing waybar launch command: $launch_command"  -t "info"
killall waybar
eval "$launch_command"


