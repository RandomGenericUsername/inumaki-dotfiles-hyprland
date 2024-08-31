#!/bin/bash

#install(){
#    gum spin --spinner dot --title "Starting $DOTFILES_NAME_RAW dotfiles installation now..." -- sleep 1
#    #if [[ ! "$ENABLE_DEBUG" == "true" ]]; then
#    #fi
#    #TODO improve clean and existing installation handling
#    check_previous_installation "$DOTFILES_INSTALL_PATH" || exit $?
#    show_install_type
#    install_pacman_packages "$PACMAN_PACKAGES"
#    install_yay
#}


install(){
    check_previous_installation "$DOTFILES_INSTALL_PATH" || exit $?
    show_install_type
    (
        # Background task execution
        install_pacman_packages "$PACMAN_PACKAGES"
        install_yay
    ) &

    # Run the spinner if debugging is not enabled
    if [[ "$ENABLE_DEBUG" != "true" ]]; then
        echo "Installation is running in the background. You can continue using the shell."
        #while kill -0 $! 2>/dev/null; do
        #    echo -n "."   # Print a dot to indicate progress
        #    sleep 0.001
        #done
        #echo ""
    fi


}