#!/bin/bash


###################################### Define global variables for the setup and installation ########################################
# Variable for enabling installation with debug printing 
DEBUG="false"

# Variable for enabling installation with log creation
LOG="false"

# Installation type: clean | update
INSTALLATION_TYPE="clean"

# Name for the directory to copy the dotfiles under /home/$USER/dotfiles/<DOTFILES_NAME>
DOTFILES_NAME=inumaki-dotfiles-hyprland

###################################### Define directories for each component of the setup/installation ########################################
# Path to this script
__script_dir=$(pwd)

# Path to log
log=/home/$USER/.logs/$DOTFILES_NAME/log

# Path to lib dir
lib=$__script_dir/.lib

# Path to install dir
install=$__script_dir/.install

# Path to dotfiles source
dotfiles_source=$__script_dir/dotfiles

# Path where to intall the dotfiles
# Replace by this -> dotfiles_target=/home/$USER/dotfiles/$DOTFILES_ID
dotfiles_target=/home/$USER/dotfiles/dev 

# Path of the file containing the packages required to install using pacman
pacman_packages=$install/packages/packages.pacman

# Path of the file containing the packages required to install using yay 
yay_packages=$install/packages/packages.yay

# Path of the file containing the packages required to run the installation 
prerequisites=$install/packages/prerequisites.pacman

# Path to file containing the supported distributions
supported_distro=$install/setup/supported_distro.sh

# Include this to provide colors for the terminal
colors=$install/setup/colors.sh

# Path to setup script
setup=$install/setup.sh

# Path to several files providing the required functionalities for the setup/installation
auth=$lib/auth.sh
utils=$lib/utils.sh
debug=$lib/debug.sh
pkg_installer=$lib/pkg_installer.sh
previous_installation=$lib/previous_installation.sh
check_distro=$lib/check_distro.sh
install_yay=$lib/install_yay.sh
processes_and_services=$lib/processes_and_services.sh
install_wal=$install/wal.sh

# Source all files/scripts
source $setup
source $auth
source $utils
source $debug
source $pkg_installer
source $previous_installation
source $check_distro
source $install_yay
source $processes_and_services
source $install_wal
source $colors


