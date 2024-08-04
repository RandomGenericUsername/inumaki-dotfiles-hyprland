#!/bin/bash

export INSTALL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Path to file containing the pacman packages to install
export PACMAN_PKGS=$INSTALL_DIR/packages.pacman

# Path to file containing the yay packages to install
export YAY_PKGS=$INSTALL_DIR/packages.yay

# Path to assets directory
export ASSETS_DIR=$INSTALL_DIR/assets

# Path to wallpaper directory
export ASSETS_WALLPAPER_DIR=$ASSETS_DIR/wallpapers

# Path to wallpaper selector installer script
export WALLPAPER_SELECTOR_INSTALLER=$INSTALL_DIR/install_wallpaper_selector.sh
source $WALLPAPER_SELECTOR_INSTALLER

# Path to create_required_dirs script
export CREATE_REQUIRED_DIRS=$INSTALL_DIR/create_required_dirs.sh
source $CREATE_REQUIRED_DIRS