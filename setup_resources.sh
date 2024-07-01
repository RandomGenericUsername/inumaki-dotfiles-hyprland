#!/bin/bash

###################################### Define directories for each component of the setup/installation ########################################
# Path to this script/dir
export RESOURCES_DIR=$(pwd)

# Path to setup dir
export SETUP_DIR=$RESOURCES_DIR/src/setup

# Path to setup script
export SETUP_SCRIPT=$SETUP_DIR/setup.sh

# Path to supported distro
export SUPPORTED_DISTRO=$SETUP_DIR/supported_distro.sh

# Path to prerequisite packages
export PREREQUISITES=$SETUP_DIR/prerequisites.pacman

source $SETUP_SCRIPT