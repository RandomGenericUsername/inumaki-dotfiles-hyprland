#!/bin/bash

# Oh my zsh repo
export OH_MY_ZSH_REPO="https://github.com/ohmyzsh/ohmyzsh.git"

install_oh_my_zsh() {
    local install_path="$1"

    # Check if oh-my-zsh is already installed and functional
    $print_debug "Checking previous oh-my-zsh installation at '$install_path'"
    if [ -d "$install_path" ];then
        if [ -f "$install_path/tools/install.sh" ]; then
            $print_debug "oh-my-zsh is already installed."
            return 0
        else
            $print_debug "$install_path already exists but is not functional. Removing it..." 
            rm -rf "$install_path"
        fi
    fi

    # Clone oh-my-zsh repository to the specified path
    if [[ ! -f "/tmp/.oh-my-zsh/tools/install.sh" ]]; then
        rm -rf /tmp/.oh-my-zsh
        if ! run "git clone $OH_MY_ZSH_REPO /tmp/.oh-my-zsh";then
            $print_debug "Failed to clone oh-my-zsh repository." -t "error"
            exit 1
        fi
    fi

    # Set ZSH environment variable
    export ZSH="$install_path"

    $print_debug "Oh-mh-zsh is not installed. Installing in '$install_path'"
    # Install oh-my-zsh
    if ! run "sh /tmp/.oh-my-zsh/tools/install.sh --unattended";then
        $print_debug "Failed to install oh-my-zsh." -t "error"
        exit 1
    fi
    echo "export ZSH=$DOTFILES_INSTALL_PATH" >> "$HOME/.zshrc"
    $print_debug "oh-my-zsh installed successfully." -t "debug"
}