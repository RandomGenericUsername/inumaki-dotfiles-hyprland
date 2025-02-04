#!/bin/bash



# Path to venv script
venv="{{cookiecutter.VENV_CLI_UTILITY}}"
# Path to utils (authentic_path, _or)
utils_dir="{{cookiecutter.HYPR_SCRIPTS_DIR}}/utils.sh"
# Path to print debug script
print_debug_script="{{cookiecutter.PRINT_DEBUG_UTILITY}}"
# Path to dir cotaining the source code for wallpaper effects
effects_dir="{{cookiecutter.HYPR_WALLPAPER_EFFECTS_DIR}}"
# Path to directory that will contain the generated images
output_dir="{{cookiecutter.GENERATED_WALLPAPERS_WITH_EFFECTS_DIR}}"

source "$utils_dir"
source "$print_debug_script"

# Check if the required arguments are provided
if [[ $# -ne 1 ]]; then
    print_debug "Usage: generate_icons <selected_wallpaper_path> [--blur <blur_file_path>]" -t "error"
    return 1
fi

export wallpaper_path;wallpaper_path="$(check_valid_wallpaper_path "$1")"
if [[ -z "$wallpaper_path" ]];then
    print_debug "Not a valid wallpaper path was provided..." -t "error"
    exit 1
fi


wallpaper_name="$(get_file_name "$wallpaper_path")"
blur_venv_value="$( "$venv" get "{{cookiecutter.WALLPAPER_BLUR_VAR}}" --env "{{cookiecutter.BASH_VENV}}" )"
brightness_venv_value="$( "$venv" get "{{cookiecutter.WALLPAPER_BRIGHTNESS_VAR}}" --env "{{cookiecutter.BASH_VENV}}" )"
default_blur_value="{{cookiecutter.WALLPAPER_BLUR_DEFAULT_VALUE}}"
default_brightness_value="{{cookiecutter.WALLPAPER_BRIGHTNESS_DEFAULT_VALUE}}"
export blur;blur="$( _or "$blur_venv_value" "$default_blur_value" )"
export brightness;brightness="$( _or "$brightness_venv_value" "$default_brightness_value" )"
wallpaper_effects_dir="$output_dir/$wallpaper_name"


mkdir -p "$wallpaper_effects_dir"

# Iterate through each subdirectory in the effects directory
find "$effects_dir" -mindepth 1 -maxdepth 1 -type d | while read -r subdir; do
    effect_name=$(basename "$subdir")
    effect_script="$subdir/$effect_name"
    
    if [[ -f "$effect_script" ]]; then
        wallpaper_with_effect="$wallpaper_effects_dir/$effect_name"
        print_debug "Applying $effect_name on $wallpaper_name. Wallpaper generated at $wallpaper_with_effect"
        export wallpaper_with_effect 
        # Source the effect script
        if [[ "$ENABLE_DEBUG" == "true" ]];then
            source "$effect_script"
        else
            source "$effect_script" > /dev/null 2>&1
        fi
    fi
done

# Handle the "no effect" case
#no_effect_wallpaper="$output_dir/$wallpaper_name/off"
#cp "$wallpaper_path" "$no_effect_wallpaper"
print_debug "All effects have been processed and icons generated."
dunstify "All effects have been processed and icons generated."