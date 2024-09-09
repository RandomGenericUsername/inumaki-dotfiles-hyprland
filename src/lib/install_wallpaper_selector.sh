#!/bin/bash

install_wallpaper_selector(){

    print_debug "Installing wallpaper selector" -t "debug"

    local default_wallpaper_path="$WALLPAPERS_DIR/default"
    local default_wallpaper="$ASSETS/default_wallpaper/default"

    generate_wallpapers="$HYPR_SCRIPTS_DIR/generate_wallpapers_with_effect.sh"
    change_wallpaper="$HYPR_SCRIPTS_DIR/change_wallpaper.sh"
    venv="$VENV_CLI_UTILITY"

    if [ ! -f "$default_wallpaper_path" ]; then
        print_debug "Copying $default_wallpaper into $default_wallpaper_path" -t "debug"
        cp "$default_wallpaper" "$HOST_WALLPAPERS_DIR/"
    fi

    #create_dirs "$GENERATED_WALLPAPERS_WITH_EFFECTS_DIR"

    # 0. Change the wallpaper
    "$change_wallpaper" "$default_wallpaper_path"
    # 1. Update the current wallpaper path
    "$venv" set "$ROFI_CURRENT_WALLPAPER_VAR" "$default_wallpaper_path" --env "$BASH_VENV"
    # 2. Write the current wallpaper to rofi config
    echo "* { current-image: url(\"$default_wallpaper_path\", height); }" > "$ROFI_CURRENT_WALLPAPER_RASI"

    # Update the current wallpaper name
    "$venv" set "$ROFI_CURRENT_WALLPAPER_NAME_VAR" "default" --env "$BASH_VENV"
    # Add to cache
    "$venv" update "$CACHED_WALLPAPER_EFFECTS_VAR" "default" --env "{{cookiecutter.BASH_VENV}}" --variable-type array
    # Update the current effect
    "$venv" set "$ROFI_CURRENT_WALLPAPER_EFFECT_VAR" "off" --env "$BASH_VENV"

    source "$PYTHON_VENV/bin/activate"
    wal -i "$default_wallpaper_path" -q
    deactivate

    # Generate the wallpapers
    "$generate_wallpapers" "$default_wallpaper_path"
}