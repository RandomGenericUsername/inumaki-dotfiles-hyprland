#!/bin/bash

export INSTALL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Path to file containing the pacman packages to install
export PACMAN_PKGS=$INSTALL_DIR/packages.pacman

# Path to file containing the yay packages to install
export YAY_PKGS=$INSTALL_DIR/packages.yay

