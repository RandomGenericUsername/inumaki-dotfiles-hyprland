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
    create_dirs "$HOST_WALLPAPERS_DIR" "$HOST_CACHE_DIR" 

    # Generate the json for cookicutter
    create_cookiecutter_project -e "$INSTALL_SETTINGS" -t "$DOTFILES_VENV_TEMPLATE_DIR" -i "$HOME" || exit $?

    # Create required symlinks
    create_symbolic_link "$CACHE_DIR" --source "$HOST_CACHE_DIR" --target "$DOTFILES_INSTALL_PATH"
    create_symbolic_link "$WALLPAPERS_DIR" --source "$HOST_WALLPAPERS_DIR" --target "$DOTFILES_INSTALL_PATH"
    create_symbolic_link "$HOME/.zshrc" --source "$DOTFILES_INSTALL_PATH/.zshrc" --target "$HOME"
    create_symbolic_link "$HOME/.config/nvim" --source "$CONFIG_DIR/nvim" --target "$HOME/.config"
    create_symbolic_link "$HOME/.config/wal" --source "$CONFIG_DIR/wal" --target "$HOME/.config"

    install_wallpaper_selector

    #sudo systemctl disable sddm
    #sudo systemctl enable lightdm

}

