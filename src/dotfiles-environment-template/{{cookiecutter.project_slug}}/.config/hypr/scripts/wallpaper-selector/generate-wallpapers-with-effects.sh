#!/bin/bash

# Path to utils (authentic_path, _or)
utils="{{cookiecutter.Utils_SCRIPT}}"
# Path to print debug script
print_debug="{{cookiecutter.PRINT_DEBUG_UTIL}}"
# Path to dir cotaining the source code for wallpaper effects
effects_dir="{{cookiecutter.WALLPAPER_EFFECTS_DIR}}"
# Path to directory that will contain the generated images
output_dir="{{cookiecutter.GENERATED_WALLPAPERS_WITH_EFFECTS_DIR}}"
# Path to variables handler script
variables_handler="{{cookiecutter.VARIABLES_HANDLER_SCRIPT}}"

# shellcheck disable=SC1090
source "$utils"
# shellcheck disable=SC1090
source "$variables_handler"

# Check if the required arguments are provided
if [[ $# -ne 1 ]]; then
    $print_debug "Usage: generate_icons <selected_wallpaper_path> [--blur <blur_file_path>]" -t "error"
    return 1
fi

wallpaper_path="$(check_valid_wallpaper_path "$1")"
export wallpaper_path

if [[ -z "$wallpaper_path" ]];then
    $print_debug "Not a valid wallpaper path was provided..." -t "error"
    exit 1
fi


wallpaper_name="$(get_file_name "$wallpaper_path")"
system_setting_blur="$(get_variable "wallpaper.blur")" 
system_setting_brigthness="$(get_variable "wallpaper.brightness")"
default_blur_value="{{cookiecutter.WALLPAPER_BLUR_DEFAULT_VALUE}}"
default_brightness_value="{{cookiecutter.WALLPAPER_BRIGHTNESS_DEFAULT_VALUE}}"
blur="$( _or "$system_setting_blur" "$default_blur_value" )"
brightness="$( _or "$system_setting_brigthness" "$default_brightness_value" )"
wallpaper_effects_dir="$output_dir/$wallpaper_name"

export blur
export brightness

mkdir -p "$wallpaper_effects_dir"

# Iterate through each subdirectory in the effects directory
find "$effects_dir" -mindepth 1 -maxdepth 1 -type d | while read -r subdir; do
    effect_name=$(basename "$subdir")
    effect_script="$subdir/$effect_name"
    
    if [[ -f "$effect_script" ]]; then
        wallpaper_with_effect="$wallpaper_effects_dir/$effect_name"
        $print_debug "Applying $effect_name on $wallpaper_name. Wallpaper generated at $wallpaper_with_effect"
        export wallpaper_with_effect 
        # Source the effect script
        if [[ "$ENABLE_DEBUG" == "true" ]];then
            # shellcheck disable=SC1090
            source "$effect_script"
        else
            # shellcheck disable=SC1090
            source "$effect_script" > /dev/null 2>&1
        fi
    fi
done

# Handle the "no effect" case
no_effect_wallpaper="$output_dir/$wallpaper_name/off"
cp "$wallpaper_path" "$no_effect_wallpaper"
$print_debug "All effects have been processed and icons generated."
dunstify "All effects have been processed and icons generated."