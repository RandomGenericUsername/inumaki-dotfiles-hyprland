#!/bin/bash

# Source required/util scripts
utils_dir="{{cookiecutter.HYPR_SCRIPTS_DIR}}/utils.sh"
# shellcheck disable=SC1090
source $utils_dir


show_wallpapers() {
    echo "" > "{{cookiecutter.SELECTED_WALLPAPER_FILE}}"
    # shellcheck disable=SC2154
    find -L "$wallpaper_dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -exec basename {} \; | sort -R | while read -r rfile
    do
        echo -en "$rfile\x00icon\x1f$wallpaper_dir/${rfile}\n"
    done
}

on_wallpaper_selected(){
    selected="$1"
    echo "$(authentic_path "$wallpaper_dir")/$selected" > "{{cookiecutter.SELECTED_WALLPAPER_FILE}}"
}

if [ "$ROFI_RETV" -eq 0 ]; then
    show_wallpapers "$@"
elif [ "$ROFI_RETV" -eq 1 ]; then
    on_wallpaper_selected "$@"
fi



#echo -en "\x00icon\x1f$wallpaper_dir/${rfile}\n"

# Source the argument parser script
#arg_parser={{cookiecutter.SCRIPTS_DIR}}/arg_parser.sh
#source $arg_parser
# Define the arguments and their corresponding variable names
#wallpaper_path_options=("--path" "-p")
# Define the arguments and their corresponding variable names
#args=( "wallpaper_path_options" "WALLPAPER_PATH" )
# Parse the argument definitions
#parse_args "${args[@]}"
# Parse the command line arguments
#parse_command_line "$@"
# Get the value of the argument
#wallpaper_dir=$(get_arg_value "WALLPAPER_PATH")
