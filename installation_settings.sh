#!/bin/bash


###################################### Define global variables for the setup and installation ########################################
# Variable for enabling installation with debug printing 
export ENABLE_DEBUG="false"

# Variable for enabling installation with log creation
export ENABLE_LOG="false"

# Installation type: clean | update
export INSTALL_TYPE="clean"

# Name for the directory to copy the dotfiles under /home/$USER/dotfiles/<DOTFILES_NAME>
#export DOTFILES_NAME=inumaki-dotfiles-hyprland
export DOTFILES_NAME=devel

# Directory to copy the dotfiles 
export DOTFILES_INSTALL_DIR=/home/$USER/dotfiles/$DOTFILES_NAME

# Path to logging dir
export LOG_DIR=$DOTFILES_INSTALL_DIR/.logs

# Path to log
export LOG=$LOG_DIR/log


# cookiecutter variables
export hyprpaper_wallpaper_cache='/home/$USER/.cache/hyprpaper/used-wallpaper'
export hyprpaper_wallpaper_splash='false'