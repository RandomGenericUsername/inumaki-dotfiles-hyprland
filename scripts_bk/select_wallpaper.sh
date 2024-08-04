#!/bin/bash

# Source required/util scripts
utils_dir={{cookiecutter.HYPR_SCRIPTS_DIR}}/utils.sh
source $utils_dir

# Settings file
settings={{cookiecutter.WALLPAPER_SETTINGS_DIR}}
custom_wallpaper_dir=$settings/wallpaper-dir.sh

# Cache directory
cache_dir={{cookiecutter.CACHE_DIR}}
used_wallpaper="$cache_dir/used_wallpaper"
wal_colors="$cache_dir/wal/colors.sh"
current_wallpaper="$cache_dir/current_wallpaper"

# Get the path to the wallpaper folder
wallpaper_dir=$(_or "$(safe_cat $custom_wallpaper_dir )" "$(authentic_path  {{cookiecutter.WALLPAPER_DIR}})")

# Select wallpaper
rofi -show Wallpaper  -i -replace -config {{cookiecutter.ROFI_CONFIG_WALLPAPER}}

# Load the selected wallpaper.
selected_wallpaper_path=$(cat "$used_wallpaper")
wallpaper_name=$(basename "$selected_wallpaper_path")

# Write the selected wallpaper path to the current wallpaper cache file
echo "$selected_wallpaper_path" > "$current_wallpaper"

# Generate the color scheme using pywal
#wal -q -i "$used_wallpaper_path"

# Source the wal colors file
#source $wal_colors
# 'wallpaper' var comes from sourcing wal colors file
# Create the path to the new selected wallpaper
#newwall=$(echo $wallpaper | sed "s|$wallpaper_dir/||g")


