#!/bin/bash

# Path to setup dir
export SETUP_DIR; SETUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Path to setup script
export SETUP_SCRIPT="$SETUP_DIR/setup.sh"

# Path to supported distro
export SUPPORTED_DISTROS="$SETUP_DIR/supported_distros.sh"

# Path to prerequisite packages
export PREREQUISITES="$SETUP_DIR/packages.pacman"

# Path to packages.pip
export PYTHON_PIP_DEPS="$SETUP_DIR/packages.pip"

# Source the setup script
source "$SETUP_SCRIPT"