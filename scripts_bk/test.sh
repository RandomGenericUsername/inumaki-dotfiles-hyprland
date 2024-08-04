#!/bin/bash

# Source the argument parser script
source ./arg_parser.sh

# Define the arguments and their corresponding variable names
wallpaper_args=("--wallpaper-dir" "-w")
other_args=("--other-option" "-o")
another_args=("--another-option")

args=(
    "wallpaper_args" "WALLPAPER_DIR"
    "other_args" "OTHER"
    "another_args" "ANOTHER"
)

# Parse the argument definitions
parse_args "${args[@]}"

# Enable multi-value parsing for specific arguments
enable_multi_value "--another-option"

# Parse the command line arguments
parse_command_line "$@"

# Access the parsed argument values
wallpaper_dir=$(get_arg_value "WALLPAPER_DIR")
other=$(get_arg_value "OTHER")
another=$(get_arg_value "ANOTHER")

# Example usage
echo "Wallpaper Directory: $wallpaper_dir"
echo "Other Option: $other"
echo "Another Option: ${another[@]}"
