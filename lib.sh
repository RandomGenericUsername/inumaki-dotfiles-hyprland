#!/bin/bash

###################################### Define directories for each component of the setup/installation ########################################
# Path to this script/dir
export RESOURCES_DIR=$(pwd)

# Path to lib dir
export LIB_DIR=$RESOURCES_DIR/src/.lib

# Path to auth script
export AUTH_SCRIPT=$LIB_DIR/auth.sh
# Path to check distro 
export CHECK_DISTRO_SCRIPT=$LIB_DIR/check_distro.sh
# Path to create cookiecutter context
export CREATE_COOKIECUTTER_SCRIPT=$LIB_DIR/create_cookiecutter.sh
# Path to debug script
export DEBUG_SCRIPT=$LIB_DIR/debug.sh
# Path to install yay script
export INSTALL_YAY_SCRIPT=$LIB_DIR/install_yay.sh
# Path to package installer script
export PKG_INSTALLER_SCRIPT=$LIB_DIR/pkg_installer.sh
# Path to previous installation script
export PREVIOUS_INSTALLATION_SCRIPT=$LIB_DIR/previous_installation.sh
# Path to processes and services script
export PROCESSES_AND_SERVICES_SCRIPT=$LIB_DIR/processes_and_services.sh
# Path to utils script
export UTILS_SCRIPT=$LIB_DIR/utils.sh
# Path to colors definitions
export COLORS=$LIB_DIR/colors.sh


source $AUTH_SCRIPT
source $CHECK_DISTRO_SCRIPT
source $CREATE_COOKIECUTTER_SCRIPT
source $DEBUG_SCRIPT
source $INSTALL_YAY_SCRIPT
source $PKG_INSTALLER_SCRIPT
source $PREVIOUS_INSTALLATION_SCRIPT
source $PROCESSES_AND_SERVICES_SCRIPT
source $UTILS_SCRIPT
source $COLORS



