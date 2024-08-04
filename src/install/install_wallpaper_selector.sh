#!/bin/bash



install_wallpaper_selector(){
    print "Installing wallpaper selector" -t "info" -l "$LOG"
    source "$HYPR_SCRIPTS_DIR/generate_wallpaper_effects_dir_icons.sh"
    if [ ! -f "$WALLPAPER_DIR/default.png" ]; then
        print "Copying default wallpaper" -t "info" -l "$LOG"
        cp "$ASSETS_WALLPAPER_DIR/default.png" "$HOST_WALLPAPER_DIR/"
    fi
    echo "$HOST_WALLPAPER_DIR/default.png" > "$SELECTED_WALLPAPER_FILE" 
    echo "$HOST_WALLPAPER_DIR/default.png" > "$CURRENT_WALLPAPER_FILE" 
    echo "$HOST_WALLPAPER_DIR/default.png" > "$CACHE_DIR/selected-wallpaper-original-path" 
    echo "off" > "$SELECTED_WALLPAPER_EFFECT_FILE"
    print "Setting default wallpaper: $HOST_WALLPAPER_DIR/default.png on $SELECTED_WALLPAPER_FILE and $CURRENT_WALLPAPER_FILE" -t "debug" -l "$LOG"
    echo "* { current-image: url(\"$HOST_WALLPAPER_DIR/default.png\", height); }" > "$ROFI_CURRENT_WALLPAPER_RASI"
    wal -i "$HOST_WALLPAPER_DIR/default.png" -s -t -q
    create_dirs "$GENERATED_WALLPAPER_DIR"
    generate_icons "$HOST_WALLPAPER_DIR/default.png" 
}