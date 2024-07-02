#!/bin/bash


###################################### Define global variables for the setup and installation ########################################

export ENV_NAME=".inumaki-dotfiles-env"
export ENV_INSTALL_PATH="$HOME"
export ENV_DIR="$ENV_INSTALL_PATH/$ENV_NAME"
export CACHE_DIR="$ENV_DIR/.cache"
export CONFIG_DIR="$ENV_DIR/.config"
export SETTINGS_DIR="$ENV_DIR/.settings"
export WALLPAPER_DIR="$ENV_DIR/wallpapers"



###################################### YYY ########################################

export HYPRLAND_DIR="$CONFIG_DIR/hypr"
export HYPRLAND_SCRIPTS_DIR="$HYPRLAND_DIR/scripts"


###################################### YYY ########################################
export HYPRPAPER_CACHE_DIR="$CACHE_DIR/hyprpaper"
export HYPRPAPER_CACHED_USED_WALLPAPER="$HYPRPAPER_CACHE_DIR/used-wallpaper"
export HYPRPAPER_CACHED_CURRENT_WALLPAPER="$HYPRPAPER_CACHE_DIR/current-wallpaper"
export HYPRPAPER_DEFAULT_SPLASH='false'



###################################### YYY ########################################
# This are the directories that will be copied to the $ENV_INSTALL_PATH
export project_slug="$ENV_NAME"
export _copy_without_render=(
    ".settings/*"
    ".config/wal/templates/*" # wal templates 
    ".cache/*"
)