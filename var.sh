#!/bin/bash


###################################### Define global variables for the setup and installation ########################################
# Variable for enabling installation with debug printing 
export DEBUG="false"

# Variable for enabling installation with log creation
export LOG="false"

# Installation type: clean | update
export INSTALLATION_TYPE="clean"

# Name for the directory to copy the dotfiles under /home/$USER/dotfiles/<DOTFILES_NAME>
export DOTFILES_NAME=inumaki-dotfiles-hyprland

###################################### Define directories for each component of the setup/installation ########################################
# Path to this script
__script_dir=$(pwd)

# Path to log
export log=/home/$USER/.logs/$DOTFILES_NAME/log

# Path to lib dir
export lib=$__script_dir/.lib

# Path to install dir
export install=$__script_dir/.install

# Path to dotfiles source
export dotfiles_source=$__script_dir/dotfiles

# Path where to intall the dotfiles
# Replace by this -> dotfiles_target=/home/$USER/dotfiles/$DOTFILES_NAME
export dotfiles_target=/home/$USER/dotfiles/dev 

# Path of the file containing the packages required to install using pacman
export pacman_packages=$install/packages/packages.pacman

# Path of the file containing the packages required to install using yay 
export yay_packages=$install/packages/packages.yay

# Path of the file containing the packages required to run the installation 
export prerequisites=$install/packages/prerequisites.pacman

# Path to file containing the supported distributions
export supported_distro=$install/setup/supported_distro.sh

# Include this to provide colors for the terminal
export colors=$install/setup/colors.sh

# Path to setup script
export setup=$install/setup.sh

# Path to several files providing the required functionalities for the setup/installation
export auth=$lib/auth.sh
export utils=$lib/utils.sh
export debug=$lib/debug.sh
export pkg_installer=$lib/pkg_installer.sh
export previous_installation=$lib/previous_installation.sh
export check_distro=$lib/check_distro.sh
export install_yay=$lib/install_yay.sh
export processes_and_services=$lib/processes_and_services.sh
export install_wal=$install/wal.sh
