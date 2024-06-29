#!/bin/bash

__script_dir=$(pwd)

dotfiles_id=inumaki-dotfiles-hyprland
#dotfiles_install_path=/home/$USER/dotfiles/$dotfiles_id
dotfiles_install_path=/home/$USER/dotfiles/dev
log=/home/$USER/.logs/$dotfiles_id/log

lib=$__script_dir/.lib
install_files_dir=.install
dotfiles_dir=$__script_dir/dotfiles
supported_distro=$__script_dir/$install_files_dir/supported_distro.sh
pacman_packages=$__script_dir/$install_files_dir/packages/packages.pacman
yay_packages=$__script_dir/$install_files_dir/packages/packages.yay

auth=$lib/auth.sh
utils=$lib/utils.sh
debug=$lib/debug.sh
pkg_installer=$lib/pkg_installer.sh
previous_installation=$lib/previous_installation.sh
check_distro=$lib/check_distro.sh

source $auth
source $utils
source $debug
source $pkg_installer
source $previous_installation
source $check_distro
