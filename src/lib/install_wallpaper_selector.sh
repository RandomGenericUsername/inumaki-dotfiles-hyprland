#!/bin/bash

install_wallpaper_selector(){

    print_debug "Installing wallpaper selector" -t "debug"
    set_current_wallpaper_script="$WALLPAPER_SELECTOR_SCRIPTS_DIR/set_current_wallpaper.sh"
    generate_wallpapers="$WALLPAPER_SELECTOR_SCRIPTS_DIR/generate_wallpapers_with_effect.sh"
    change_wallpaper="$WALLPAPER_SELECTOR_SCRIPTS_DIR/change_wallpaper.sh"
    venv="$VENV_CLI_UTILITY"
    toggle_waybar="$HYPR_SCRIPTS_DIR/waybar/toggle.sh"
    source "$set_current_wallpaper_script"

    if [ ! -f "$DEFAULT_WALLPAPER_PATH" ]; then
        print_debug "Copying $DEFAULT_WALLPAPER_PATH_SRC into $DEFAULT_WALLPAPER_PATH" -t "debug"
        cp "$DEFAULT_WALLPAPER_PATH_SRC" "$HOST_WALLPAPERS_DIR/"
    fi

    create_dirs "$GENERATED_WALLPAPERS_WITH_EFFECTS_DIR" 
    # 0. Change the wallpaper
    "$change_wallpaper" "$DEFAULT_WALLPAPER_PATH"
    # 1. Update the current wallpaper path
    "$venv" set "$ROFI_CURRENT_WALLPAPER_VAR" "$DEFAULT_WALLPAPER_PATH" --env "$BASH_VENV"
    # 2. Write the current wallpaper to rofi config
    echo "* { current-image: url(\"$DEFAULT_WALLPAPER_PATH\", height); }" > "$ROFI_CURRENT_WALLPAPER_RASI"

    # Update the current wallpaper name
    "$venv" set "$ROFI_CURRENT_WALLPAPER_NAME_VAR" "default" --env "$BASH_VENV"
    # Add to cache
    "$venv" update "$CACHED_WALLPAPER_EFFECTS_VAR" "default" --env "$BASH_VENV" --variable-type array
    # Update the current effect
    "$venv" set "$ROFI_CURRENT_WALLPAPER_EFFECT_VAR" "off" --env "$BASH_VENV"

    source "$PYTHON_VENV/bin/activate"
    wal -i "$DEFAULT_WALLPAPER_PATH" -q
    deactivate

    "$toggle_waybar"
    "$toggle_waybar"

    # Generate the wallpapers
    "$generate_wallpapers" "$DEFAULT_WALLPAPER_PATH"
}