    #!/bin/bash

    # Open rofi to select the Hyprshade filter for toggle
    options="$(ls {{ cookiecutter.HYPR_WALLPAPER_EFFECTS_DIR }})\noff"
    
    # Open rofi
    choice=$(echo -e "$options" | rofi -dmenu -replace -config {{ cookiecutter.ROFI_CONFIG_THEMES }} -i -no-show-icons -l 5 -width 30 -p "Hyprshade") 
    if [ ! -z $choice ] ;then
        echo "$choice" > {{cookiecutter.WALLPAPER_EFFECT}}
        dunstify "Changing Wallpaper Effect to " "$choice"
        {{cookiecutter.HYPR_SCRIPTS_DIR}}/wallpaper.sh init
    fi
