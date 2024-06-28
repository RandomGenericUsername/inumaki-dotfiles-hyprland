#!/bin/bash

__script_dir=$(pwd)

dotfiles_id=inumaki-dotfiles-hyprland
dotfiles_install_path=/home/$USER/dotfiles/dev
#dotfiles_install_path=/home/$USER/dotfiles/$dotfiles_id


supported_distro=$__script_dir/supported_distro.sh
packages=$__script_dir/packages.sh
yay_packages=$__script_dir/packages.yay
dotfiles=$__script_dir/dotfiles
lib=$__script_dir/.lib


logs=/home/$USER/.logs/$dotfiles_id
installed_pkg_logs=$logs/installed_pkg.log
yay_installed_pkg_logs=$logs/yay_installed_pkg.log


auth=$lib/auth.sh
utils=$lib/utils.sh
debug=$lib/debug.sh
pkg_installer=$lib/pkg_installer.sh

source $auth
source $utils
source $debug
source $pkg_installer
