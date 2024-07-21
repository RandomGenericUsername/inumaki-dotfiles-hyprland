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

# Function to initialize the wallpaper
init_wallpaper() {
    sleep 1
    if [ -f "$cache_file" ]; then
        wal -q -i "$current_wallpaper"
    else
        wal -q -i "$wallpaper_folder/"
    fi
}

# Function to select wallpaper using rofi
select_wallpaper() {

    # Get selected wallpaper from rofi
    selected=$(find -L "$wallpaper_folder" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -exec basename {} \; | sort -R | while read -r rfile
    do
        echo -en "$rfile\x00icon\x1f$wallpaper_folder/${rfile}\n"
    done | rofi -dmenu -window-title {{cookiecutter.ROFI_WALLPAPER_SELECTOR_WINDOW_NAME}} -i -replace -config {{cookiecutter.ROFI_CONFIG_WALLPAPER}})

    echo "Selected: $selected"
    if [ -z "$selected" ]; then
        echo "No wallpaper selected"
        exit 1
    fi

    echo "Generating wal out of $wallpaper_folder/$selected"
    wal -q -i "$wallpaper_folder/$selected"
}



random_wallpaper() {
    echo "Generating wall from wallpaper dir randomly"
    wal -q -i "$wallpaper_folder/"
}

load_wallpaper_effect(){
    # Load Wallpaper Effect
    if [ -f $wallpaper_effect_f ] ;then
        effect=$(cat $wallpaper_effect_f)
        if [ ! "$effect" == "off" ] ;then
            if [ "$1" == "init" ] ;then
                echo ":: Init"
            else
                dunstify "Using wallpaper effect $effect..." "with image $newwall" -h int:value:10 -h string:x-dunst-stack-tag:wallpaper
            fi
            source {{cookiecutter.HYPR_WALLPAPER_EFFECTS_DIR}}/$effect
        fi
    fi
}

# Source required scripts
utils_dir={{cookiecutter.HYPR_SCRIPTS_DIR}}/utils.sh
source $utils_dir
# Settings file
settings={{cookiecutter.WALLPAPER_SETTINGS_DIR}}
wallpaper_effect_f=$settings/wallpaper-effect.sh
wallpaper_engine_f=$settings/wallpaper-engine.sh

cache={{cookiecutter.CACHE_DIR}}
used_wallpaper=$cache/used_wallpaper
cache_file="$cache/current_wallpaper"
blurred="$cache/blurred_wallpaper.png"
square="$cache/square_wallpaper.png"
rasi_file="$cache/current_wallpaper.rasi"

wal_colors="$cache/wal/colors.sh"

# Get blur from settings
blur=$(_or "$(safe_cat $settings/blur.sh )" '50x30')
wallpaper_folder=$(_or "$(safe_cat $settings/wallpaper-dir.sh )" "$(authentic_path  {{cookiecutter.WALLPAPER_DIR}})")

if_not_exists_create_file $cache_file "$wallpaper_folder/default.png"
if_not_exists_create_file $rasi_file "* { current-image: url(\"$wallpaper_folder/default.png\", height); }"

current_wallpaper=$(cat "$cache_file")

# Main script execution
case $1 in
    "init")
        init_wallpaper
        ;;
    "select")
        select_wallpaper
        ;;
    *)
        random_wallpaper
        ;;
esac

echo "DONE!"

# ----------------------------------------------------- 
# Load current pywal color scheme
# ----------------------------------------------------- 
source $wal_colors

# ----------------------------------------------------- 
# get wallpaper image name
# ----------------------------------------------------- 
newwall=$(echo $wallpaper | sed "s|$wallpaper_folder/||g")
echo "New wallpaper image name is: $newwall"

# ----------------------------------------------------- 
# Reload waybar with new colors
# -----------------------------------------------------
{{cookiecutter.HYPR_SCRIPTS_DIR}}/apply_waybar_theme.sh

# ----------------------------------------------------- 
# Set the new wallpaper
# -----------------------------------------------------
transition_type="wipe"
# transition_type="outer"
# transition_type="random"

cp "$wallpaper" "$cache/"
echo "Copying $wallpaper into $cache/"
mv "$cache/$newwall" $used_wallpaper
echo "Moving $cache/$newwall into $used_wallpaper"

load_wallpaper_effect

killall hyprpaper
wal_tpl="$(cat {{cookiecutter.WALLPAPER_SETTINGS_DIR}}/hyprpaper.tpl)"
output="${wal_tpl//WALLPAPER/$used_wallpaper}"
echo "$output" > {{cookiecutter.HYPR_DIR}}/hyprpaper.conf
hyprpaper --config {{cookiecutter.HYPR_DIR}}/hyprpaper.conf &


if [ "$1" == "init" ] ;then
    echo ":: Init"
else
    sleep 1
    dunstify "Changing wallpaper ..." "with image $newwall" -h int:value:25 -h string:x-dunst-stack-tag:wallpaper
    
    # ----------------------------------------------------- 
    # Reload Hyprctl.sh
    # -----------------------------------------------------
	echo "Reloading hypr..."
    #{{cookiecutter.HYPR_SCRIPTS_DIR}}/reload.sh 
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



