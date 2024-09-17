#!/bin/bash

# Path to setup dir
export INSTALL_DIR; INSTALL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Path to setup script
export INSTALL_SCRIPT="$INSTALL_DIR/install.sh"

export PACMAN_PACKAGES="$INSTALL_DIR/packages.pacman"

export YAY_PACKAGES="$INSTALL_DIR/packages.yay"

source "$INSTALL_SCRIPT"