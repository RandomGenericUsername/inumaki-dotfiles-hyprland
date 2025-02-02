#!/bin/bash


replace_placeholders() {
    local template_file="$1"
    local output_file="$2"
    local calculated_font_size="$3"
    local missing_vars=()

    # Read template file content
    template_content="$(cat "$template_file")"

    # Extract all placeholders from the template
    {% raw %}placeholders=($(grep -oP "{{\K[^}]*(?=}})" "$template_file" | sort -u)){% endraw %}

    # Check if variables exist in the environment
    for placeholder in "${placeholders[@]}"; do
        if [[ "$placeholder" =~ ^cookiecutter\. ]]; then
            # Skip placeholders starting with 'cookiecutter.'
            continue
        elif [[ "$placeholder" == "FONT_SIZE" ]] && declare -p "FONT_SIZE" &>/dev/null; then
            value="$calculated_font_size"
        elif ! declare -p "$placeholder" &>/dev/null; then
            missing_vars+=("$placeholder")
            continue
        else
            value="${!placeholder}"
        fi
        {% raw %}template_content="${template_content//"{{$placeholder}}"/$value}"{% endraw %}
    done

    # Check if there are missing variables
    if [[ {% raw %}${#missing_vars[@]}{% endraw %} -gt 0 ]]; then
        echo "Error: The following placeholders are not defined in the environment variables file:" >&2
        printf ' - %s\n' "{% raw %}${missing_vars[@]}{% endraw %}" >&2
        exit 1
    fi

    # Write processed content to the output file
    echo "$template_content" > "$output_file"

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
env_vars_file_option_identifiers=("-e" "--env-vars")

# Set the options/flags identifiers
options=(
    "css_template_file_option_identifiers" "css_template"
    "output_file_option_identifiers" "output_path"
    "env_vars_file_option_identifiers" "env_vars"
)

set_options "${options[@]}"
parse_command_line "$@"

CSS_TEMPLATE="$(get_arg_value "css_template")"
OUTPUT_FILE="$(get_arg_value "output_path")"
ENV_FILE="$(get_arg_value "env_vars")"

if [[ -z "$CSS_TEMPLATE" ]];then
    $print_debug "You must provide a template file" -t "error"
    $print_debug "Use -t or --template to provide the path to the template file" -t "info"
    exit 1
fi
if [[ -z "$OUTPUT_FILE" ]];then
    $print_debug "You must provide an output directory" -t "error"
    $print_debug "Use -o or --output to provide the path to the output file" -t "info"
fi
if [[ -z "$ENV_FILE" ]];then
    $print_debug "You must provide an environment variables file" -t "error"
    $print_debug "Use -e or --env-vars to provide the path to the environment variables file" -t "info"
fi

source "$ENV_FILE"
if [[ -z "$FONT_SIZE" ]];then
    $print_debug "Font size is not set in config.sh" -t "error"
    exit 1
fi

screen_size="$(get_variable "system.screen_size")"
if [[ -z "$screen_size" ]];then
    $print_debug "Screen size is not set" -t "error"
    exit 1
fi

#
font_size_percentage="$(calculate_font_size "$screen_size" "$FONT_SIZE")"
replace_placeholders "$CSS_TEMPLATE" "$OUTPUT_FILE" "$font_size_percentage"