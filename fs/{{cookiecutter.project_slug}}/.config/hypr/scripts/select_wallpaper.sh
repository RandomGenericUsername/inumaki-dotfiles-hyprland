#!/bin/bash

function get_extension() {
    local filepath="$1"
    local filename; filename=$(basename -- "$filepath")
    local extension="${filename##*.}"

    if [[ "$filename" == *.* && "$extension" != "$filename" ]]; then
        echo "$extension"
    else
        echo "No extension found"
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

function on_selected_wallpaper() {
    # Load the selected wallpaper.
    selected_wallpaper_path=$(safe_cat "$selected_wallpaper_file")
    current_wallpaper_path=$(safe_cat "$current_wallpaper_file")
    selected_wallpaper_name="$(extract_name "$selected_wallpaper_path")"
    current_wallpaper_name="$(extract_name "$current_wallpaper_path")"
    echo "[SELECTED WALLPAPER EVENT]"
    echo "Selected wallpaper: $selected_wallpaper_path"
    echo "Current wallpaper: $current_wallpaper_path"
    if [ "$selected_wallpaper_path" != "$current_wallpaper_path" ] && [ "$selected_wallpaper_name" != "$current_wallpaper_name" ]; then
        echo "$selected_wallpaper_path" > "$current_wallpaper_file"
        echo "$selected_wallpaper_path" > "$cache_dir/selected-wallpaper-original-path"
        generate_icons_required="true"
    # generate_icons /path/to/source/image.png /path/to/off/image.png --blur /path/to/blur_file
    fi
}

function on_selected_wallpaper_effect() {
    selected_wallpaper_effect=$(safe_cat "$selected_wallpaper_effect_file")
    selected_wallpaper_path=$(safe_cat "$cache_dir/selected-wallpaper-original-path")
    current_wallpaper_name=$(basename "$selected_wallpaper_path")
    used_wallpaper_path="$generated_wallpaper_dir/$(modify_path "$current_wallpaper_name" "$selected_wallpaper_effect" -n)"
    echo "[SELECTED WALLPAPER EFFECT EVENT]"
    echo "Selected wallpaper effect: $selected_wallpaper_effect"
    echo "Applying effect to current wallpaper: $selected_wallpaper_path"
    echo "Checking that wallpaper with effect is new: $selected_wallpaper_path || $used_wallpaper_path"    
    if [ "$selected_wallpaper_effect" == "off" ]; then
        echo "Turning off effect"
        used_wallpaper_path="$selected_wallpaper_path"
    elif [ "$selected_wallpaper_path" != "$used_wallpaper_path" ] && [ ! -e "$used_wallpaper_path" ]; then
        echo "Generating wallpaper at: $used_wallpaper_path out of $selected_wallpaper_path"
        export selected_wallpaper_effect
        export used_wallpaper_path
        # shellcheck disable=SC1090  
        source "{{cookiecutter.HYPR_WALLPAPER_EFFECTS_DIR}}/$selected_wallpaper_effect/$selected_wallpaper_effect"
    fi
    echo "$used_wallpaper_path" > "$current_wallpaper_file"
    echo "$selected_wallpaper_effect" > "$current_wallpaper_effect_file"
}

function generate_blurred_version() {
    local blurred_wallpaper="$1"
    echo "Generating blurred version"
    # Generate the blurred version
    magick "$selected_wallpaper_path" -resize 75% "$blurred_wallpaper"
    if [ ! "$blur" == "0x0" ]; then
        magick "$blurred_wallpaper" -blur "$blur" "$blurred_wallpaper"
        blur_generated="$generated_wallpaper_dir/__BLUR__${blur}__${selected_wallpaper_name_with_effect}"
        cp "$blurred_wallpaper" "$blur_generated"
    fi
    cp "$blur_generated" "$blurred_wallpaper"
    # Create the rasi file
    echo "* { current-image: url(\"$blurred_wallpaper\", height); }" > "{{cookiecutter.ROFI_CURRENT_WALLPAPER_RASI}}"
}

function generate_square_version() {
    local square_wallpaper="$1"
    echo "Generating square version"
    # Generate square wallpaper
    magick "$selected_wallpaper_path" -gravity Center -extent 1:1 "$square_wallpaper"
    cp "$square_wallpaper" "$generated_wallpaper_dir/__SQUARE__$selected_wallpaper_name_with_effect"
}

hypr_scripts_dir="{{cookiecutter.HYPR_SCRIPTS_DIR}}"
# shellcheck disable=SC1091
source "$hypr_scripts_dir/generate_wallpaper_effects_dir_icons.sh"

# Source required/util scripts
utils_dir="{{cookiecutter.HYPR_SCRIPTS_DIR}}/utils.sh"
# shellcheck disable=SC1090
source $utils_dir

cache_dir="{{cookiecutter.CACHE_DIR}}"
#blurred_wallpaper="$cache_dir/blurred_wallpaper.png"
#square_wallpaper="$cache_dir/square_wallpaper.png"

generate_icons_required="false"

selected_wallpaper_file="{{cookiecutter.SELECTED_WALLPAPER_FILE}}"
current_wallpaper_file="{{cookiecutter.CURRENT_WALLPAPER_FILE}}"
selected_wallpaper_effect_file="{{cookiecutter.SELECTED_WALLPAPER_EFFECT_FILE}}"
current_wallpaper_effect_file="{{cookiecutter.CURRENT_WALLPAPER_EFFECT_FILE}}"
wal_colors_file="{{cookiecutter.WAL_COLORS_FILE}}"
generated_wallpaper_dir="{{cookiecutter.GENERATED_WALLPAPER_DIR}}"

custom_wallpaper_dir_file="{{cookiecutter.CUSTOM_WALLPAPER_DIR_FILE}}"
export wallpaper_dir; wallpaper_dir="$(_or "$(safe_cat "$custom_wallpaper_dir_file" )" "$(authentic_path  "{{cookiecutter.WALLPAPER_DIR}}")")"

blur_file="{{cookiecutter.SETTINGS_BLUR_FILE}}"
export blur; blur="$(safe_cat $blur_file)"

current_wallpaper_path_prev="$(safe_cat "$current_wallpaper_file")"
# Select wallpaper
rofi -show Wallpaper -i -replace -config "{{cookiecutter.ROFI_CONFIG_WALLPAPER}}"

if [[ -n "$(safe_cat "$selected_wallpaper_file")" ]]; then
    on_selected_wallpaper
    elif [[ -n "$(safe_cat "$selected_wallpaper_effect_file")" ]]; then
        on_selected_wallpaper_effect
    else
        echo "No wallpaper or wallpaper effect selected. Exiting..."
        exit 0
fi


selected_wallpaper_path="$(safe_cat "$current_wallpaper_file")"
selected_wallpaper_name="$(extract_name "$selected_wallpaper_path")"
extension="$(get_extension "$selected_wallpaper_path")"
selected_wallpaper_filename="$(basename "$selected_wallpaper_path")"
selected_wallpaper_name_with_effect="${selected_wallpaper_filename%.*}"
wal_cached_colors="{{cookiecutter.WAL_CACHE_DIR}}/${selected_wallpaper_name_with_effect}__colors.sh"
blurred_wallpaper="$cache_dir/__BLURRED__$selected_wallpaper_name_with_effect"
square_wallpaper="$cache_dir/__SQUARE__$selected_wallpaper_name_with_effect"

if [[ ! -e "$wal_cached_colors" ]]; then
    echo "Generating color scheme for wallpaper $selected_wallpaper_path"
    selected_wallpaper_original_path=$(safe_cat "$cache_dir/selected-wallpaper-original-path")
    wal_status=$(wal -i "$selected_wallpaper_path" -s -t -q; echo $?)
    if [ "$wal_status" -ne 0 ]; then
        echo "Failed to generate color scheme for wallpaper $selected_wallpaper_path"
        echo "Using wallpaper without effect: $selected_wallpaper_original_path"
        wal -i "$selected_wallpaper_original_path" -s -t -q
    fi
    echo "[MOVING $wal_colors_file $wal_cached_colors]"
    mv "$wal_colors_file" "$wal_cached_colors"
fi

if [[ "$selected_wallpaper_path" != "$current_wallpaper_path_prev" ]]; then
    # shellcheck disable=SC1090  
    source "$wal_cached_colors"
    killall -e hyprpaper > /dev/null 2>&1 &
    sleep 1;
    wal_tpl=$(cat "{{cookiecutter.WALLPAPER_SETTINGS_DIR}}/hyprpaper.tpl")
    output="${wal_tpl//WALLPAPER/$selected_wallpaper_path}"
    echo "$output" > "{{cookiecutter.HYPR_DIR}}/hyprpaper.conf"
    hyprpaper --config "{{cookiecutter.HYPR_DIR}}/hyprpaper.conf" > /dev/null 2>&1 &

    if [[ ! -e "$blurred_wallpaper" ]];then
        generate_blurred_version "$blurred_wallpaper"
    fi
    if [[ ! -e "$square_wallpaper" ]];then
        generate_square_version "$square_wallpaper"
    fi
    if [[ $generate_icons_required == "true" ]]; then
        generate_icons "$selected_wallpaper_path" --blur "$blur_file"
    fi

fi

# Reload waybar
