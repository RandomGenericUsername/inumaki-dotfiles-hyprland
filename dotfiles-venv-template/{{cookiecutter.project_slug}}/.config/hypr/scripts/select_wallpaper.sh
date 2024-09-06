#!/bin/bash


#identify_event(){
#}

#on_wallpaper_selected(){
#}
is_image() {
    local file_path="$1"
    if identify "$file_path" > /dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

check_valid_wallpaper_path(){
    local wallpaper_path="$1"
    if [ -z "$wallpaper_path" ]; then
        echo ""
        return 2
    else
        if [ -e "$wallpaper_path" ]; then
            if is_image "$wallpaper_path"; then
                echo "$wallpaper_path"
                return 0
            else
                echo ""
                return 2
            fi
        else
            echo ""
            return 2
        fi
    fi
}

set_wallpaper(){
    local wallpaper="$1"
    killall -e hyprpaper > /dev/null 2>&1 &
    sleep 0.3;
    hyprpaper_config_template_contents=$(cat "$hyprpaper_config_template")
    hyprpaper_config_template_contents="${hyprpaper_config_template_contents//WALLPAPER/${wallpaper}}"
    echo "$hyprpaper_config_template_contents" > "$hyprpaper_config"
    hyprpaper --config "$hyprpaper_config" > /dev/null 2>&1 &
}

# Path to utils (authentic_path, _or)
utils_dir="{{cookiecutter.HYPR_SCRIPTS_DIR}}/utils.sh"
# Path to Scripts dir
hypr_scripts_dir="{{cookiecutter.HYPR_SCRIPTS_DIR}}"
# Path to venv script
venv="{{cookiecutter.VENV_CLI_UTILITY}}"
# Path to Argument parser script
arg_parser_script="{{cookiecutter.ARGUMENT_PARSER_UTILITY}}"
# Path to print debug script
print_debug_script="{{cookiecutter.PRINT_DEBUG_UTILITY}}"
# Path to hyprpaper config file template
hyprpaper_config_template="{{cookiecutter.HYPRPAPER_CONFIG_TEMPLATE}}"
# Path to hyprpaper config file
hyprpaper_config="{{cookiecutter.HYPR_DIR}}/hyprpaper.conf"


# Source required/util scripts
source $utils_dir
# Source script to generate wallpapers with effects
source "$hypr_scripts_dir/generate_wallpaper_effects_dir_icons.sh"
# Source the print_debug script
source "$print_debug_script"
# Source the argument parser script
source "$arg_parser_script"

# Load a custom wallpaper dir from venv
custom_wallpaper_dir="$(venv get "{{cookiecutter.CUSTOM_WALLPAPER_DIR_VAR}}" --env "{{cookiecutter.BASH_VENV}}" )"

# Define the wallpaper directory accordingly if a custom dir is set 
export wallpaper_dir; wallpaper_dir="$( authentic_path "$(_or "$custom_wallpaper_dir" "{{cookiecutter.WALLPAPERS_DIR}}")" )"

# Define the identifier for the random wallpaper flag
random_wallpaper_option_identifiers=("-r" "--random" "--random-wallpaper")
default_wallpaper_option_identifiers=("-d" "--default" "--default-wallpaper")

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

RANDOM_WALLPAPER="$(get_arg_value "random_wallpaper")"
DEFAULT_WALLPAPER="$(get_arg_value "default_wallpaper")"
WALLPAPER_PATH="${POSITIONAL_ARGS[0]}"

echo "Wallpaper: $WALLPAPER_PATH"
echo "Random wallpaper: $RANDOM_WALLPAPER"
echo "Default wallpaper: $DEFAULT_WALLPAPER"

if [[ -z "$WALLPAPER_PATH" ]] && [[ "$DEFAULT_WALLPAPER" == "false" ]] && [[ "$RANDOM_WALLPAPER" == "false" ]]; then
    print_debug "You must either provide a wallpaper path as argument or set any of the -r or -d options" -t "error"
    exit 1
fi

# check after
# Check if the wallpaper path is provided as an argument
# 0: wallpaper path was provided and is valid
# 1: no arguments were passed to the function
# 2: invalid or no wallpaper path passed
# 3: passed random flag 
wallpaper_path_provided=$(check_valid_wallpaper_path "$@")
is_wallpaper_path_provided=$?

exit 0

# Flag to choose whether the wallpaper with effect should be generated
#generate_icons_required="false"

# 
#export blur; blur="$( venv get "{{cookiecutter.WALLPAPER_BLUR_VAR}}" --env "{{cookiecutter.BASH_VENV}}" )"

# 0: wallpaper path was provided and is valid
# 1: no arguments were passed to the function
# 2: invalid or no wallpaper path passed
# 3: passed random flag 
wallpaper_path_provided="$(check_wallpaper_path_arg "$@")"
is_wallpaper_path_provided=$?

if [ $is_wallpaper_path_provided -eq 0 ]; then
    venv set "{{cookiecutter.ROFI_SELECTED_WALLPAPER_VAR}}" "$wallpaper_path_provided" --env "{{cookiecutter.BASH_VENV}}"
elif [ "$is_wallpaper_path_provided" -eq 1 ]; then
    rofi -show Wallpaper -i -replace -config "{{cookiecutter.ROFI_DIR}}/wallpapers-and-effects-mode.rasi"
elif [ "$is_wallpaper_path_provided" -eq 2 ]; then
    echo "Default wallpaper"
elif [ "$is_wallpaper_path_provided" -eq 3 ]; then
    echo "Random wallpaper"
else
    #echo "The path does not exist."
    echo "unknown error"
    exit 0
fi

selected_wallpaper="$(venv get "{{cookiecutter.ROFI_SELECTED_WALLPAPER_VAR}}" --env "{{cookiecutter.BASH_VENV}}")"
current_wallpaper="$( venv get "{{cookiecutter.ROFI_CURRENT_WALLPAPER_VAR}}" --env "{{cookiecutter.BASH_VENV}}" )"
selected_wallpaper_effect="$(venv get "{{cookiecutter.ROFI_SELECTED_WALLPAPER_EFFECT_VAR}}" --env "{{cookiecutter.BASH_VENV}}")"
current_wallpaper_effect="$(venv get "{{cookiecutter.ROFI_CURRENT_WALLPAPER_EFFECT_VAR}}" --env "{{cookiecutter.BASH_VENV}}")"

echo "selected wallpaper: $selected_wallpaper"
echo "current wallpaper: $current_wallpaper"
echo "selected effect: $selected_wallpaper_effect"
echo "current effect: $current_wallpaper_effect"
identify_event "$selected_wallpaper" "$selected_wallpaper_effect"
event=$?

# 0: not recognized event, error
# 1: Wallpaper selected event
# 2: Wallpaper effect selected event
if [[ $event -eq 1 ]];then
    on_wallpaper_selected
elif [[ $event -eq 2 ]];then
    on_wallpaper_effect_selected
else 
    echo "No wallpaper or effect selected."
    exit 0
fi

selected_wallpaper_name="$(basename "$selected_wallpaper")"
selected_wallpaper_name_with_effect="${selected_wallpaper_name%.*}"
wal_cached_colors="{{cookiecutter.WAL_CACHE_DIR}}/${selected_wallpaper_name_with_effect}__colors.sh"
wal_waybar_cached_colors="{{cookiecutter.WAL_CACHE_DIR}}/${selected_wallpaper_name_with_effect}__waybar_colors.sh"
blurred_wallpaper="{{cookiecutter.CACHE_DIR}}/__BLURRED__$selected_wallpaper_name_with_effect"
square_wallpaper="{{cookiecutter.CACHE_DIR}}/__SQUARE__$selected_wallpaper_name_with_effect"
wal_colors="{{cookiecutter.WAL_CACHE_DIR}}/colors.sh"
wal_colors_waybar="{{cookiecutter.WAL_CACHE_DIR}}/colors-waybar.css"

if [[ ! -e "$wal_cached_colors" ]];then
    generate_color_scheme
fi

