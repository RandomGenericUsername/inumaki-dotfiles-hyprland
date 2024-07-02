#!/bin/bash


###################################### Define global variables for the setup and installation ########################################

export ENV_NAME=".inumaki-dotfiles-env"
export ENV_DIR="$HOME/$ENV_NAME"
export CACHE_DIR="$ENV_DIR/.cache"
export CONFIG_DIR="$ENV_DIR/.config"
export SETTINGS_DIR="$ENV_DIR/.settings"
export WALLPAPER_DIR="$ENV_DIR/wallpapers"



###################################### YYY ########################################

export HYPRLAND_DIR="$CONFIG_DIR/hypr"
export HYPRLAND_SCRIPTS_DIR="$HYPRLAND_DIR/scripts"


###################################### YYY ########################################
export HYPRPAPER_CACHE_DIR="$CACHE_DIR/hyprpaper"



###################################### YYY ########################################
# This are the directories that will be copied to the $ENV_INSTALL_PATH
export project_slug="$ENV_NAME"
export _copy_without_render=(
    ".settings/*"
    ".config/wal/templates/*" # wal templates 
    ".cache/*"
)