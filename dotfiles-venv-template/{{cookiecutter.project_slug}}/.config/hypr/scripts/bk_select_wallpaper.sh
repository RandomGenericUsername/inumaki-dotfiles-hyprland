#!/bin/bash

function modify_path() {
    local input_path="$1"
    local effect_name="$2"
    local only_name=false

    while [[ "$#" -gt 0 ]]; do
        case $1 in
            -n|--name)
                only_name=true
                shift
                ;;
            *)
                shift
                ;;
        esac
    done

    # Extract the directory, base name, and extension
    local dir; dir=$(dirname "$input_path")
    local base; base=$(basename "$input_path")
    local extension; extension="${base##*.}"

    # Case 1: Path does not contain '__' (i.e., /some/path/to/file.jpeg)
    if [[ "$base" != *__* ]]; then
        local name="${base%.*}"
        local new_base="${name}__${effect_name}.${extension}"

    # Case 2: Path contains '__' (i.e., /some/path/to/file__effect.jpg)
    else
        local name="${base%%__*}"
        local new_base="${name}__${effect_name}.${extension}"
    fi

    # Form the new path
    local new_path="${dir}/${new_base}"

    # Output based on the -n or --name option
    if [ "$only_name" = true ]; then
        echo "$new_base"
    else
        echo "$new_path"
    fi
}


function extract_name() {
    local filename="$1"

    # Extract the base name and extension
    local base
    base=$(basename "$filename")
    local extension="${base##*.}"

    # Check if the base name contains '__'
    if [[ "$base" == *__* ]]; then
        local name="${base%%__*}"
    else
        local name="${base%.*}"
    fi

    echo "$name"
}

is_image() {
    local file_path="$1"
    if identify "$file_path" >/dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

check_wallpaper_path_arg() {
    local wallpaper_path=""
    if [[ $# -eq 0 ]];then
        return 1
    fi
    if [[ $# -eq 1 ]];then
        wallpaper_path="$1"
    fi
    if [[ $# -eq 1 ]] && [[ "$1" == "-r" ]] || [[ "$1" == "--random" ]];then
        return 3
    fi
    while [[ $# -gt 0 ]]; do
        case $1 in
            -w|--wallpaper-path)
                wallpaper_path="$2"
                shift # past argument
                shift # past value
                ;;
            *)
                shift # past unrecognized argument
                ;;
        esac
    done

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

identify_event(){
    local selected_wallpaper="$1"
    local selected_wallpaper_effect="$2"

    if [[ -n "$selected_wallpaper" ]] && [[ -z "$selected_wallpaper_effect" ]]; then
        echo "Wallpaper selected event"
        return 1
    elif [[ -z "$selected_wallpaper" ]] && [[ -n "$selected_wallpaper_effect" ]]; then
        echo "Wallpaper effect selected event"
        return 2
    else
        return 0
    fi
}

on_wallpaper_selected(){
    echo "on_wallpaper_selected"
    selected_wallpaper_name="$(extract_name "$selected_wallpaper")"
    current_wallpaper_name="$(extract_name "$current_wallpaper")"
    if [ "$selected_wallpaper_name" != "$current_wallpaper_name" ]; then
        generate_icons_required="true"
    fi
}

on_wallpaper_effect_selected(){
    echo "on_wallpaper_effect_selected"
    current_wallpaper_name="$(extract_name "$current_wallpaper")"
}

generate_color_scheme(){
    echo "Generating color scheme for wallpaper $selected_wallpaper"
    wal_status=$(wal --backend Haishoku -i "$selected_wallpaper" -q; echo $?)
    #if [[ "$wal_status" -ne 0 ]];then

    #fi
    echo "[MOVING $wal_colors to $wal_cached_colors]"
    mv "$wal_colors" "$wal_cached_colors"
    echo "[MOVING $wal_colors_waybar to $wal_waybar_cached_colors]"
    mv "$wal_colors_waybar" "$wal_waybar_cached_colors"
}

# Path to venv script
venv="{{cookiecutter.VENV_CLI_UTILITY}}"

hypr_scripts_dir="{{cookiecutter.HYPR_SCRIPTS_DIR}}"
source "$hypr_scripts_dir/generate_wallpaper_effects_dir_icons.sh"

# Source required/util scripts
utils_dir="{{cookiecutter.HYPR_SCRIPTS_DIR}}/utils.sh"
source $utils_dir

#
generate_icons_required="false"

#
custom_wallpaper_dir="$(venv get "{{cookiecutter.CUSTOM_WALLPAPER_DIR_VAR}}" --env "{{cookiecutter.BASH_VENV}}" )"

#
export wallpaper_dir; wallpaper_dir="$( authentic_path "$(_or "$custom_wallpaper_dir" "{{cookiecutter.WALLPAPERS_DIR}}")" )"

#
export blur; blur="$( venv get "{{cookiecutter.WALLPAPER_BLUR_VAR}}" --env "{{cookiecutter.BASH_VENV}}" )"


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

