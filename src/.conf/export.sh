#!/bin/bash

# Path to setup dir
export CONF_DIR; CONF_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

export BOOTSTRAP_DEPENDENCIES="$CONF_DIR/bootstrap_dependencies.deps"
export INSTALLATION_DEPENDENCIES="$CONF_DIR/installation_dependencies.deps"
export PIP_PACKAGES="$CONF_DIR/packages.pip"

export COLORS="$CONF_DIR/colors.sh"
export INSTALLATION_DEFAULTS="$CONF_DIR/defaults.sh"
export INSTALLATION_ENVIRONMENT_VARIABLES="$CONF_DIR/environment-variables.sh"
export INSTALLATION_FILESYSTEM_MAPPING="$CONF_DIR/filesystem-mapping.sh"
export INSTALLATION_SETTINGS="$CONF_DIR/install-settings.sh"
export SUPPORTED_DISTROS="$CONF_DIR/supported-distros.sh"

source "$COLORS"
source "$INSTALLATION_SETTINGS"
source "$INSTALLATION_DEFAULTS"
source "$INSTALLATION_ENVIRONMENT_VARIABLES"
source "$INSTALLATION_FILESYSTEM_MAPPING"
source "$SUPPORTED_DISTROS"