#!/bin/bash
#  _____                 _       __        __          _                
# |_   _|__   __ _  __ _| | ___  \ \      / /_ _ _   _| |__   __ _ _ __ 
#   | |/ _ \ / _` |/ _` | |/ _ \  \ \ /\ / / _` | | | | '_ \ / _` | '__|
#   | | (_) | (_| | (_| | |  __/   \ V  V / (_| | |_| | |_) | (_| | |   
#   |_|\___/ \__, |\__, |_|\___|    \_/\_/ \__,_|\__, |_.__/ \__,_|_|   
#            |___/ |___/                         |___/                  
#
# By Stephan Raabe. Thanks!

waybar_cached_status={{cookiecutter.CACHE_DIR}}/waybar-disabled

if [ -f $waybar_cached_status ] ;then
    echo "Waybar is disabled..."
    echo "Enabling Waybar..."
    rm $waybar_cached_status
else
    echo "Waybar is enabled..."
    echo "Disabling Waybar..."
    touch $waybar_cached_status
fi
{{cookiecutter.HYPR_SCRIPTS_DIR}}/apply_waybar_theme.sh &

