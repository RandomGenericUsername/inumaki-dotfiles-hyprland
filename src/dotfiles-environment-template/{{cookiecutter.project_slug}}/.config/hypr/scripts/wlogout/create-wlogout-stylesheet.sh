#!/bin/bash

replace_placeholders() {
    local calculated_font_size="$1"
    local background_image="$2"
    local output_file="$3"
    local template_file="$4"

    # Use sed for replacement
    sed -e "s|{% raw %}{{FONT_SIZE}}{% endraw %}|$calculated_font_size|g" \
        -e "s|{% raw %}{{WLOGOUT_BACKGROUND_IMAGE}}{% endraw %}|$background_image|g" \
        "$template_file" > "$output_file"

    $print_debug "Generated $output_file successfully." 
}

# Function to calculate font size
calculate_font_size() {
    local screen_size="$1"
    local font_size="$2"    
    local width;local height
    # Check if SCREEN_SIZE contains 'x'
    if [[ "$screen_size" == *"x"* ]]; then
        IFS='x' read -r width height <<< "$screen_size"
    else
        # If no 'x', assume the value is the width and height
        width=$screen_size
        height=$screen_size
    fi
    
    # Determine the largest dimension
    local largest
    if [[ $width -gt $height ]]; then
        largest=$width
    else
        largest=$height
    fi
    
    # Calculate font size
    local calculated_size
    calculated_size=$((largest * font_size / 100))
    echo "$calculated_size"
}

WLOGOUT_CONFIG="{{cookiecutter.WLOGOUT_DIR}}/config.sh"
if [[ ! -f "$WLOGOUT_CONFIG" ]];then
    $print_debug "Wlogout config file not found" -t "error"
    exit 1
fi
source "$WLOGOUT_CONFIG"
if [[ -z "$FONT_SIZE" ]];then
    $print_debug "Font size is not set" -t "error"
    exit 1
fi

# Path to print debug script
print_debug="{{cookiecutter.PRINT_DEBUG_UTIL}}"
# Path to Argument parser script
arg_parser_script="{{cookiecutter.ARGUMENT_PARSER_UTIL}}"
# Path to variables handler script
variables_handler="{{cookiecutter.VARIABLES_HANDLER_SCRIPT}}"
source "$variables_handler"

# Source the argument parser script
# shellcheck disable=SC1090
source "$arg_parser_script"

# Define the identifier for the css template file parameter 
css_template_file_option_identifiers=("-t" "--template")
output_file_option_identifiers=("-o" "--output")
background_image_option_identifiers=("-b" "--background-image")

# Set the options/flags identifiers
options=(
    "css_template_file_option_identifiers" "css_template"
    "output_file_option_identifiers" "output_path"
    "background_image_option_identifiers" "background_image"
)

set_options "${options[@]}"
parse_command_line "$@"

CSS_TEMPLATE="$(get_arg_value "css_template")"
OUTPUT_FILE="$(get_arg_value "output_path")"
BACKGROUND_IMAGE="$(get_arg_value "background_image")"

if [[ -z "$CSS_TEMPLATE" ]];then
    $print_debug "You must provide a template file" -t "error"
    $print_debug "Use -t or --template to provide the path to the template file" -t "info"
    exit 1
fi
if [[ -z "$OUTPUT_FILE" ]];then
    $print_debug "You must provide an output directory" -t "error"
    $print_debug "Use -o or --output to provide the path to the output file" -t "info"
    exit 1
fi
if [[ -z "$BACKGROUND_IMAGE" ]];then
    $print_debug "You must provide the path to the background image." -t "error"
    $print_debug "Use -b or --background-image" -t "info"
    exit 1
fi

screen_size="$(get_variable "system.screen_size")"
if [[ -z "$screen_size" ]];then
    $print_debug "Screen size is not set" -t "error"
    exit 1
fi

#
font_size_percentage="$(calculate_font_size "$screen_size" "$FONT_SIZE")"
replace_placeholders "$font_size_percentage" "$BACKGROUND_IMAGE" "$OUTPUT_FILE" "$CSS_TEMPLATE"