#!/bin/bash

source ./filesystem_settings.sh

# Variable for enabling installation with debug printing 
export ENABLE_DEBUG="false"
# Variable for enabling installation with log creation
export ENABLE_LOG="false"
# Installation type: clean | update
export INSTALL_TYPE="clean"

# Path to logging dir
export LOG_DIR=$ENV_INSTALL_PATH/.logs
# Path to log
export LOG=$LOG_DIR/install.log


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