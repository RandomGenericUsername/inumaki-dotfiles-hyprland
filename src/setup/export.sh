#!/bin/bash

# Path to setup dir
export SETUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Path to setup script
export SETUP_SCRIPT=$SETUP_DIR/setup.sh

# Path to supported distro
export SUPPORTED_DISTRO=$SETUP_DIR/supported_distro.sh

# Path to prerequisite packages
export PREREQUISITES=$SETUP_DIR/prerequisites.pacman

source $SETUP_SCRIPT