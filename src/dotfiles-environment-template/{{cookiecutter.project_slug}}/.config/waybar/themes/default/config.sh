#!/bin/bash

# Path to variables handler script
variables_handler="{{cookiecutter.VARIABLES_HANDLER_SCRIPT}}"
# Source the variables handler script
source "$variables_handler"

theme_name="Default"
SCREEN_SIZE="$(get_variable "system.screen_size")"
FONT_SIZE=1
FONT="Roboto Mono Medium, Helvetica, Arial, sans-serif"
