#!/bin/bash

# Set to true if the environment directory should be hidden, false otherwise
export ENV_HIDDEN=true
# Variable for enabling installation with debug printing 
export ENABLE_DEBUG="false"
# Variable for enabling installation with log creation
export ENABLE_LOG="false"
# Installation type: clean | update
export INSTALL_TYPE="update"

# Path to this script/dir
export RESOURCES_DIR=$(pwd)
# Path to filesystem settings
export FS_SETTINGS=$RESOURCES_DIR/filesystem_settings.sh
# Required to be sourced for paths below
source $FS_SETTINGS
# Path to logging dir
export LOG_DIR=$ENV_DIR/.logs
# Path to log
export LOG=$LOG_DIR/install.log

export FS=$RESOURCES_DIR/fs
export COOKIECUTTER_JSON=$FS/cookiecutter.json
export COOKIECUTTER_CONTEXT=$FS_SETTINGS









# Path to filesystem src files
#export FS=$RESOURCES_DIR/fs

#export DOTFILES_TEMPLATE_DIR=$RESOURCES_DIR/dotfiles-template
#export COOKIECUTTER_TEMPLATE=$DOTFILES_TEMPLATE_DIR/cookiecutter.json
#export COOKIECUTTER_CONTEXT=$DOTFILES_TEMPLATE_DIR/cookiecutter-context.json


###################################### Define global variables for the setup and installation ########################################
#
#
## Name for the directory to copy the dotfiles under /home/$USER/dotfiles/<DOTFILES_NAME>
##export DOTFILES_NAME=inumaki-dotfiles-hyprland
#export FS_NAME="inumaki-dotfiles-env"
#
## Path to install the fylesystem
#export FS_INSTALL_PATH="\$HOME/.$FS_NAME/"
#
## Directory to copy the dotfiles 
#export DOTFILES_INSTALL_DIR=/home/$USER/dotfiles/$DOTFILES_NAME
#
## cookiecutter variables
#export hyprpaper_default_splash='false'
#export hyprpaper_cache_dir='/$HOME/.cache/hyprpaper'
#export hyprpaper_cached_used_wallpaper="$hyprpaper_cache_dir/used-wallpaper"
#export hyprpaper_cached_current_wallpaper="$hyprpaper_cache_dir/current-wallpaper"
#export hyprpaper_blurred_wallpaper="$hyprpaper_cache_dir/blurred_wallpaper.png"
#export hyprpaper_square_wallpaper="$hyprpaper_cache_dir/square_wallpaper.png"
#export hyprpaper_current_wallpaper_rasi_config="$hyprpaper_cache_dir/current_wallpaper.rasi"
#
#
#export settings_dir='/$HOME'
#export hyprpaper_blur_setting_file="$"
#
#