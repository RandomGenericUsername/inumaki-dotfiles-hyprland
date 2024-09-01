#!/bin/bash

install(){

    gum spin --spinner dot --title "Starting $DOTFILES_NAME_RAW dotfiles installation now..." -- sleep 1

    # Show the installation type: Update || Clean
    show_install_type

    if [[ "$ENABLE_DEBUG" != "true" ]]; then
        echo "Installation is running in the background. You can continue using the shell."
    fi

    # Install yay
    install_yay

    # Install the required packages using pacman
    install_pacman_packages "$PACMAN_PACKAGES"

    # Since yay doesn't need to be run as root, drop the root privileges
    drop_root_privileges
    # Install the required packages using yay
    install_yay_packages "$YAY_PACKAGES"

    # Install date.h using vcpkg
    install_date_h

    # Install nvm and node
    install_nvm
    install_node "$NODE_VERSION"

    # Install Oh my zsh
    install_oh_my_zsh

    # Setup the bash venv
    install_bash_venv

    # Create required directories for installation
    create_dirs "$HOST_WALLPAPER_DIR" "$HOST_CACHE_DIR" 

    # Generate the json for cookicutter
    create_cookiecutter_project -e "$INSTALL_SETTINGS" -t "$DOTFILES_VENV_TEMPLATE_DIR" -i /tmp

}


#install(){
#    check_previous_installation "$DOTFILES_INSTALL_PATH" || exit $?
#    show_install_type
#    (
#        # Background task execution
#        install_pacman_packages "$PACMAN_PACKAGES"
#        install_yay
#    ) &
#
#    # Run the spinner if debugging is not enabled
#    if [[ "$ENABLE_DEBUG" != "true" ]]; then
#        echo "Installation is running in the background. You can continue using the shell."
#        #while kill -0 $! 2>/dev/null; do
#        #    echo -n "."   # Print a dot to indicate progress
#        #    sleep 0.001
#        #done
#        #echo ""
#    fi
#
#
#}