#!/bin/bash


###################################### Define global variables for the setup and installation ########################################

export ENV_NAME_RAW="inumaki-dotfiles-env"
export ENV_NAME=".$ENV_NAME_RAW"
export ENV_INSTALL_PATH="$HOME"
export ENV_DIR="$ENV_INSTALL_PATH/$ENV_NAME"
export CACHE_DIR="$ENV_DIR/.cache"
export CONFIG_DIR="$ENV_DIR/.config"
export SETTINGS_DIR="$ENV_DIR/.settings"
export WALLPAPER_DIR="$ENV_DIR/wallpapers"


###################################### YYY ########################################

export HOST_WALLPAPER_DIR="$HOME/wallpapers"
export HOST_CACHE_DIR="$HOME/.cache"




###################################### YYY ########################################
#export HYPRPAPER_CACHE_DIR="$CACHE_DIR/hyprpaper"
#export HYPRPAPER_CACHED_USED_WALLPAPER="$HYPRPAPER_CACHE_DIR/used-wallpaper"
#export HYPRPAPER_CACHED_CURRENT_WALLPAPER="$HYPRPAPER_CACHE_DIR/current-wallpaper"
#export HYPRPAPER_CACHED_BLURRED_WALLPAPER="$HYPRPAPER_CACHE_DIR/blurred_wallpaper.png"
#export HYPRPAPER_CACHED_SQUARE_WALLPAPER="$HYPRPAPER_CACHE_DIR/square_wallpaper.png"
#export HYPRPAPER_CACHED_CURRENT_WALLPAPER_RASI_CONFIG="$HYPRPAPER_CACHE_DIR/current_wallpaper.rasi"
#export HYPRPAPER_CACHED_BLUR_FILE="$SETTINGS_DIR/blur.sh"
#export HYPRPAPER_DEFAULT_SPLASH='false'
#
#export WAL_CACHE_DIR="$CACHE_DIR/wal"
#export WAL_CURRENT_COLORS="$WAL_CACHE_DIR/colors.sh"


###################################### YYY ########################################
#export USER_SETTINGS_DIR="$HOME/$ENV_NAME_RAW"
#export USER_SETTINGS="$HOME/$ENV_NAME_RAW/settings.sh"
###################################### YYY ########################################
# This are the directories that will be copied to the $ENV_INSTALL_PATH
export project_slug="$ENV_NAME"
export _copy_without_render=(
    ".settings/*"
    ".config/wal/templates/*" # wal templates 
    ".cache/*"
)