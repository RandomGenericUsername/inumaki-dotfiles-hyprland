    #!/bin/bash

    # Open rofi to select the Hyprshade filter for toggle
    options="$(ls {{cookiecutter.CONFIG_DIR}}/hypr/effects/wallpaper/)\noff"
    
    # Open rofi
    choice=$(echo -e "$options" | rofi -dmenu -replace -config {{cookiecutter.CONFIG_DIR}}/rofi/config-themes.rasi -i -no-show-icons -l 5 -width 30 -p "Hyprshade") 
    if [ ! -z $choice ] ;then
        echo "$choice" > {{cookiecutter.SETTINGS_DIR}}/wallpaper-effect.sh
        dunstify "Changing Wallpaper Effect to " "$choice"
        {{cookiecutter.CONFIG_DIR}}/hypr/scripts/wallpaper.sh init
    fi
