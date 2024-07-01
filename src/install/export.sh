#!/bin/bash

export INSTALL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Path to file containing the pacman packages to install
export PACMAN_PKGS=$INSTALL_DIR/packages.pacman

# Path to file containing the yay packages to install
export YAY_PKGS=$INSTALL_DIR/packages.yay

# Path to pywal installer script
export PYWAL_INSTALLER=$INSTALL_DIR/wal.sh

# Path to wallpaper installer script
export WALLPAPER_INSTALLER=$INSTALL_DIR/wallpaper.sh

#export DOTFILES_TEMPLATE_DIR=$RESOURCES_DIR/dotfiles-template
#export COOKIECUTTER_TEMPLATE=$DOTFILES_TEMPLATE_DIR/cookiecutter.json
#export COOKIECUTTER_CONTEXT=$DOTFILES_TEMPLATE_DIR/cookiecutter-context.json

