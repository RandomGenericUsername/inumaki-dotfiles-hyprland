#!/bin/bash

# Path to variables handler script
variables_handler="{{cookiecutter.VARIABLES_HANDLER_SCRIPT}}"
# Source the variables handler script
source "$variables_handler"


# Function to process a theme directory (root or subdirectory)
process_theme_dir() {
    local dir="$1"
    local theme_base="$2"
    local result; result=$(echo "$dir" | sed "s#${themes_path}/#/#g")

    # Process and add the theme
    if [[ -f "${dir}/config.sh" ]]; then
        source "${dir}/config.sh"
        theme_base="/$(basename "$theme_base")"
        listThemes+=("$theme_base;$result")
        listNames+=("$theme_name")
        listNames2+=("$theme_name~")
    fi
}

themes_path="{{cookiecutter.WAYBAR_THEMES_DIR}}"
listThemes=()
listNames=()
listNames2=()

# Generate the list of themes
options=$(find "$themes_path" -maxdepth 1 -type d)
for value in $options; do
    if [[ "$value" != "${themes_path}/assets" && "$value" != "$themes_path" ]]; then
        # Process the root theme directory
        process_theme_dir "$value" "$value"

        # Process subdirectories for variants
        subdirs=$(find "$value" -maxdepth 1 -type d)
        for subdir in $subdirs; do
            if [[ "$subdir" != "$value" ]]; then
                process_theme_dir "$subdir" "$value"
            fi
        done
    fi
done


# Show themes for Rofi
show_themes() {
    set_variable "waybar.theme.selected" "" 
    for name in "${listNames[@]}"; do
        echo "$name"
    done
}

# Handle selected theme
on_selected_theme() {
    selected="$1"
    for i in "${!listNames[@]}"; do
        if [[ "${listNames[$i]}" == "$selected" ]]; then
            selected_index=$i
            break
        fi
    done
    set_variable "waybar.theme.selected" "${listThemes[$selected_index]}"
}

# Main script logic for Rofi
if [ "$ROFI_RETV" -eq 0 ]; then
    show_themes "$@"
elif [ "$ROFI_RETV" -eq 1 ]; then
    on_selected_theme "$@"
fi
