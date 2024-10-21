#!/bin/bash

# Path to setup dir
export CONF_DIR; CONF_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

export PREREQUISITES="$CONF_DIR/prerequisites.pacman"
export PIP_PACKAGES="$CONF_DIR/packages.pip"
export YAY_PACKAGES="$CONF_DIR/packages.yay"

export COLORS="$CONF_DIR/colors.sh"
export VARS="$CONF_DIR/vars.sh"
export INSTALLATION_DEFAULTS="$CONF_DIR/defaults.sh"
export INSTALLATION_ENVIRONMENT_VARIABLES="$CONF_DIR/environment-variables.sh"
export INSTALLATION_FILESYSTEM_MAPPING="$CONF_DIR/filesystem-mapping.sh"
export INSTALLATION_SETTINGS="$CONF_DIR/install-settings.sh"
export SUPPORTED_DISTROS="$CONF_DIR/supported-distros.sh"

source "$COLORS"
source "$INSTALLATION_SETTINGS"
source "$VARS"
source "$INSTALLATION_DEFAULTS"
source "$INSTALLATION_ENVIRONMENT_VARIABLES"
source "$INSTALLATION_FILESYSTEM_MAPPING"