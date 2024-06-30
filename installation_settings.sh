#!/bin/bash


###################################### Define global variables for the setup and installation ########################################
# Variable for enabling installation with debug printing 
export DEBUG="false"

# Variable for enabling installation with log creation
export LOG="false"

# Installation type: clean | update
export INSTALLATION_TYPE="clean"

# Name for the directory to copy the dotfiles under /home/$USER/dotfiles/<DOTFILES_NAME>
export DOTFILES_NAME=inumaki-dotfiles-hyprland

# Directory to copy the dotfiles 
export INSTALL_DIR=/home/$USER/dotfiles/$DOTFILES_NAME
