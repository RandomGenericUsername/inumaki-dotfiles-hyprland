generate_icons() {
    # Check if the required arguments are provided
    if [[ $# -lt 1 ]]; then
        echo "Usage: generate_icons <selected_wallpaper_path> [--blur <blur_file_path>]"
        return 1
    fi

    # Assign arguments to variables
    selected_wallpaper_path="$1"
    blur="50x30"

    # Parse optional arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --blur|-b)
                if [[ -n "$2" ]]; then
                    blur=$(cat "$2")
                    shift 2
                else
                    echo "Error: --blur|-b option requires an argument."
                    return 1
                fi
                ;;
            *)
                shift
                ;;
        esac
    done

    # Export selected_wallpaper_path and blur
    export selected_wallpaper_path
    export blur

    effects_path="{{cookiecutter.HYPR_WALLPAPER_EFFECTS_DIR}}"

    # Iterate through each subdirectory in the effects directory
    find "$effects_path" -mindepth 1 -maxdepth 1 -type d | while read -r subdir; do
        effect_name=$(basename "$subdir")
        effect_script="$subdir/$effect_name"
        
        if [[ -f "$effect_script" ]]; then
            used_wallpaper_path="$subdir/icon"
            export used_wallpaper_path

            # Source the effect script
            source "$effect_script"
        fi
    done

    # Handle the "off" effect
    off_dir="$effects_path/off"
    mkdir -p "$off_dir"
    cp "$selected_wallpaper_path" "$off_dir/icon"

    echo "All effects have been processed and icons generated."
}

# Example of how to source and invoke this function from another script:
# source path/to/this_script.sh
# generate_icons /path/to/source/image.png --blur /path/to/blur_file
