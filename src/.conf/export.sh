#!/bin/bash

# Path to setup dir
export CONF_DIR; CONF_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

export SUPPORTED_DISTROS="$CONF_DIR/supported_distros.sh"

export COLORS="$CONF_DIR/colors.sh"
source "$COLORS"
# Path to setup script
#export INSTALL_SCRIPT="$INSTALL_DIR/install.sh"
#
#export PACMAN_PACKAGES="$INSTALL_DIR/packages.pacman"
#
#export YAY_PACKAGES="$INSTALL_DIR/packages.yay"

#source "$INSTALL_SCRIPT"