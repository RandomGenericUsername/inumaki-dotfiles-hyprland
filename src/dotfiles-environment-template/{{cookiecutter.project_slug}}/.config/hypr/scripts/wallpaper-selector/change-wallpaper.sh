#!/bin/bash


# Function to return a random wallpaper from the given directory, including subdirectories, only selecting image files
get_random_wallpaper() {
    $print_debug "Setting random wallpaper" -t "info"
    local wallpaper_dir="$1"

    # Check if the provided argument is a directory
    if [[ ! -d "$wallpaper_dir" ]]; then
        $print_debug "'$wallpaper_dir' is not a valid directory." -t "error"
        return 1
    fi

    # Get a list of image files in the directory and its subdirectories
    local wallpapers=()
    while IFS= read -r -d $'\0' file; do
        wallpapers+=("$file")
    done < <(find -L "$wallpaper_dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.bmp" -o -iname "*.tiff" \) -print0)

    # Check if there are any image files in the directory or subdirectories
    {% raw %} if [[ ${#wallpapers[@]} -eq 0 ]]; then {% endraw %}
        $print_debug "No image files found in the directory '$wallpaper_dir'." -t "error"
        return 1
    fi

    # Pick a random file from the array of wallpapers
    {% raw %}local random_wallpaper="${wallpapers[RANDOM % ${#wallpapers[@]}]}"{% endraw %}

    $print_debug "Random wallpaper is: $random_wallpaper" -t "info"
    # Return the path of the randomly chosen wallpaper
    echo "$random_wallpaper"
}


change_wallpaper() {
    local wallpaper="$1"
    killall -e hyprpaper > /dev/null 2>&1 &
    sleep 0.3;
    hyprpaper_config_template_contents=$(cat "$hyprpaper_config_template")
    hyprpaper_config_template_contents="${hyprpaper_config_template_contents//WALLPAPER/${wallpaper}}"
    echo "$hyprpaper_config_template_contents" > "$hyprpaper_config"
    hyprpaper --config "$hyprpaper_config" > /dev/null 2>&1 &
}




# Path to utils (authentic_path, _or)
utils_dir="{{cookiecutter.UTILS_SCRIPT}}"
# Path to print debug script
print_debug="{{cookiecutter.PRINT_DEBUG_UTIL}}"
# Path to Argument parser script
arg_parser_script="{{cookiecutter.ARGUMENT_PARSER_UTIL}}"
# Path to hyprpaper config file template
hyprpaper_config_template="{{cookiecutter.HYPRPAPER_CONFIG_TEMPLATE}}"
# Path to hyprpaper config file
hyprpaper_config="{{cookiecutter.HYPRPAPER_CONFIG}}"
# Path to wlogout scripts dir
create_wlogout_stylesheet_script="{{cookiecutter.CREATE_WLOGOUT_STYLESHEET_SCRIPT}}"
# Path to variables handlerscript
variables_handler="{{cookiecutter.VARIABLES_HANDLER_SCRIPT}}"

# Source required/util scripts
source $utils_dir
# Source the argument parser script
source "$arg_parser_script"
# Source variables handler script
source "$variables_handler"

# Define the wallpaper directory accordingly if a custom dir is set 
wallpaper_dir="$( authentic_path "{{cookiecutter.WALLPAPERS_DIR}}")"
export wallpaper_dir 

# Define the identifier for the random wallpaper flag
random_wallpaper_option_identifiers=("-r" "--random-wallpaper")
default_wallpaper_option_identifiers=("-d" "--default-wallpaper")

# Set the options/flags identifiers
options=(
    "random_wallpaper_option_identifiers" "random_wallpaper"
    "default_wallpaper_option_identifiers" "default_wallpaper"
)
set_options "${options[@]}"

# Enable the random wallpaper option
enable_flag "${random_wallpaper_option_identifiers[@]}"
enable_flag "${default_wallpaper_option_identifiers[@]}"

# Parse the command line arguments
parse_command_line "$@"

SET_RANDOM_WALLPAPER="$(get_arg_value "random_wallpaper")"
SET_DEFAULT_WALLPAPER="$(get_arg_value "default_wallpaper")"
WALLPAPER_PATH="${POSITIONAL_ARGS[0]}"

# Assert that a path to a wallpaper was passed or any of the -r or -d options
if [[ -z "$WALLPAPER_PATH" ]] && [[ "$SET_DEFAULT_WALLPAPER" == "false" ]] && [[ "$SET_RANDOM_WALLPAPER" == "false" ]]; then
    $print_debug "You must either provide a wallpaper path as argument or set any of the -r or -d options" -t "error"
    exit 1
fi

# Check if the default or random flag was passed
if [[ "$SET_RANDOM_WALLPAPER" == "true" ]] && [[ -z "$WALLPAPER_PATH" ]]; then
    WALLPAPER_PATH="$(get_random_wallpaper "$wallpaper_dir")"
    [[ -z "$WALLPAPER_PATH" ]] && WALLPAPER_PATH="{{cookiecutter.WALLPAPERS_DIR}}/default.png"
elif [[ "$DEFAULT_WALLPAPER" == "true" ]] && [[ -z "$WALLPAPER_PATH" ]]; then
    WALLPAPER_PATH="{{cookiecutter.WALLPAPERS_DIR}}/default.png"
fi

if [[ -n "$WALLPAPER_PATH" ]] &&  [[ -z "$(check_valid_wallpaper_path "$WALLPAPER_PATH")" ]];then
    $print_debug "Bad wallpaper path passed..." -t "error"
    exit 1
fi

#$create_wlogout_stylesheet_script -o {{cookiecutter.WLOGOUT_DIR}}/style.css -t {{cookiecutter.WLOGOUT_DIR}}/style.css.tpl -b $WALLPAPER_PATH
$print_debug "Setting wallpaper: $WALLPAPER_PATH"
change_wallpaper "$WALLPAPER_PATH"