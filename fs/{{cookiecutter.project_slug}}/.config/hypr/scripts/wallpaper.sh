#!/bin/bash
#                _ _                              
# __      ____ _| | |_ __   __ _ _ __   ___ _ __  
# \ \ /\ / / _` | | | '_ \ / _` | '_ \ / _ \ '__| 
#  \ V  V / (_| | | | |_) | (_| | |_) |  __/ |    
#   \_/\_/ \__,_|_|_| .__/ \__,_| .__/ \___|_|    
#                   |_|         |_|               
#  
# by Stephan Raabe (2024) 
# ----------------------------------------------------- 

# Cache file for holding the current wallpaper
wallpaper_folder="$(readlink -f {{cookiecutter.WALLPAPER_DIR}})"
echo "[Wallpaper dir: $wallpaper_folder]"

# Load the wallpaper directory path from settings
#if [ -f ~/dotfiles/inumaki/.settings/wallpaper-folder.sh ] ;then
#	echo "Sourcing wallpaper settings from ~/dotfiles/inumaki/.settings/wallpaper-folder.sh"
#    source ~/dotfiles/inumaki/.settings/wallpaper-folder.sh
#fi

used_wallpaper="{{cookiecutter.CACHE_DIR}}/used_wallpaper"
cache_file="{{cookiecutter.CACHE_DIR}}/current_wallpaper"
blurred="{{cookiecutter.CACHE_DIR}}/blurred_wallpaper.png"
square="{{cookiecutter.CACHE_DIR}}/square_wallpaper.png"
rasi_file="{{cookiecutter.CACHE_DIR}}/current_wallpaper.rasi"
blur_file="{{cookiecutter.SETTINGS_DIR}}/blur.sh"

blur="50x30"
blur=$(cat $blur_file)

# Create cache file if not exists
if [ ! -f $cache_file ] ;then
    touch $cache_file
    echo "$wallpaper_folder/default.png" > "$cache_file"
fi

# Create rasi file if not exists
if [ ! -f $rasi_file ] ;then
    touch $rasi_file
    echo "* { current-image: url(\"$wallpaper_folder/default.png\", height); }" > "$rasi_file"
fi

current_wallpaper=$(cat "$cache_file")

case $1 in
    # Load wallpaper from .cache of last session 
    "init")
        sleep 1
        if [ -f $cache_file ]; then
            wal -q -i "$current_wallpaper"
        else
            wal -q -i "$wallpaper_folder/"
        fi
    ;;

    # Select wallpaper with rofi
    "select")
        sleep 0.2
        selected=$( find "$wallpaper_folder" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -exec basename {} \; | sort -R | while read rfile
        do
            echo -en "$rfile\x00icon\x1f$wallpaper_folder/${rfile}\n"
        done | rofi -dmenu -i -replace -config {{cookiecutter.CONFIG_DIR}}/rofi/config-wallpaper.rasi)

		echo "Selected: $selected"
        if [ ! "$selected" ]; then
            echo "No wallpaper selected"
            exit
        fi

		echo "Generating wal out of $wallpaper_folder/$selected"
        wal -q -i "$wallpaper_folder/$selected"
    ;;

    # Randomly select wallpaper 
    *)
		echo "Generating wall from wallpaper dir randomly"
        wal -q -i $wallpaper_folder/
    ;;

esac

# ----------------------------------------------------- 
# Load current pywal color scheme
# ----------------------------------------------------- 
source "{{cookiecutter.CACHE_DIR}}/wal/colors.sh"

# ----------------------------------------------------- 
# get wallpaper image name
# ----------------------------------------------------- 
newwall=$(echo $wallpaper | sed "s|$wallpaper_folder/||g")
echo "New wallpaper image name is: $newwall"

# ----------------------------------------------------- 
# Reload waybar with new colors
# -----------------------------------------------------
#{{cookiecutter.CONFIG_DIR}}/waybar/themes/scripts/launch.sh

# ----------------------------------------------------- 
# Set the new wallpaper
# -----------------------------------------------------
transition_type="wipe"
# transition_type="outer"
# transition_type="random"

cp "$wallpaper" "{{cookiecutter.CACHE_DIR}}/"
echo "Copying $wallpaper into {{cookiecutter.CACHE_DIR}}/"
mv "{{cookiecutter.CACHE_DIR}}/$newwall" $used_wallpaper
echo "Moving {{cookiecutter.CACHE_DIR}}/$newwall into $used_wallpaper"

# Load Wallpaper Effect
if [ -f {{cookiecutter.SETTINGS_DIR}}/wallpaper-effect.sh ] ;then
    effect=$(cat {{cookiecutter.SETTINGS_DIR}}/wallpaper-effect.sh)
    if [ ! "$effect" == "off" ] ;then
        if [ "$1" == "init" ] ;then
            echo ":: Init"
        else
            dunstify "Using wallpaper effect $effect..." "with image $newwall" -h int:value:10 -h string:x-dunst-stack-tag:wallpaper
        fi
        source {{cookiecutter.CONFIG_DIR}}/hypr/effects/wallpaper/$effect
    fi
fi


wallpaper_engine=$(cat {{cookiecutter.SETTINGS_DIR}}/wallpaper-engine.sh)
if [ "$wallpaper_engine" == "swww" ] ;then
    # swww
    echo ":: Using swww"
    swww img $used_wallpaper \
        --transition-bezier .43,1.19,1,.4 \
        --transition-fps=60 \
        --transition-type=$transition_type \
        --transition-duration=0.7 \
        --transition-pos "$( hyprctl cursorpos )"

elif [ "$wallpaper_engine" == "hyprpaper" ] ;then
    # hyprpaper
    echo ":: Using hyprpaper"
    killall hyprpaper
    wal_tpl="$(cat {{cookiecutter.SETTINGS_DIR}}/hyprpaper.tpl)"
    output="${wal_tpl//WALLPAPER/$used_wallpaper}"
    echo "$output" > {{cookiecutter.CONFIG_DIR}}/hypr/hyprpaper.conf
    hyprpaper --config {{cookiecutter.CONFIG_DIR}}/hypr/hyprpaper.conf &
else
    echo ":: Wallpaper Engine disabled"
fi


if [ "$1" == "init" ] ;then
    echo ":: Init"
else
    sleep 1
    dunstify "Changing wallpaper ..." "with image $newwall" -h int:value:25 -h string:x-dunst-stack-tag:wallpaper
    
    # ----------------------------------------------------- 
    # Reload Hyprctl.sh
    # -----------------------------------------------------
	echo "Reloading hyper..."
    #{{cookiecutter.CONFIG_DIR}}/hypr/scripts/reload.sh 
fi

# ----------------------------------------------------- 
# Created blurred wallpaper
# -----------------------------------------------------
if [ "$1" == "init" ] ;then
    echo ":: Init"
else
    dunstify "Creating blurred version ..." "with image $newwall" -h int:value:50 -h string:x-dunst-stack-tag:wallpaper
fi

magick "$used_wallpaper" -resize 75% $blurred
echo ":: Resized to 75%"
if [ ! "$blur" == "0x0" ] ;then
    magick $blurred -blur $blur $blurred
    echo ":: Blurred"
fi

# ----------------------------------------------------- 
# Created quare wallpaper
# -----------------------------------------------------
if [ "$1" == "init" ] ;then
    echo ":: Init"
else
    dunstify "Creating square version ..." "with image $newwall" -h int:value:75 -h string:x-dunst-stack-tag:wallpaper
fi
magick $wallpaper -gravity Center -extent 1:1 $square
echo ":: Square version created"

# ----------------------------------------------------- 
# Write selected wallpaper into .cache files
# ----------------------------------------------------- 
echo "$wallpaper" > "$cache_file"
echo "* { current-image: url(\"$blurred\", height); }" > "$rasi_file"

# ----------------------------------------------------- 
# Send notification
# ----------------------------------------------------- 

if [ "$1" == "init" ] ;then
    echo ":: Init"
else
    dunstify "Wallpaper procedure complete!" "with image $newwall" -h int:value:100 -h string:x-dunst-stack-tag:wallpaper
fi

echo "DONE!"

