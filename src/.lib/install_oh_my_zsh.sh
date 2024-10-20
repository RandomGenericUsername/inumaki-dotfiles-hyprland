#!/bin/bash


install_oh_my_zsh() {
    local install_path="$1"

    # Check if oh-my-zsh is already installed and functional
    if [ -d "$install_path" ];then
        if [ -f "$install_path/tools/install.sh" ]; then
            $print_debug "oh-my-zsh is already installed."
        else
            $print_debug "$install_path already exists but is not functional. Removing it..." 
            rm -r "$install_path"
        fi
        return 0
    fi
    # Clone oh-my-zsh repository to the specified path
    run "git clone $OH_MY_ZSH_REPO $install_path"
    if [[ $? -ne 0 ]]; then
        $print_debug "Failed to clone oh-my-zsh repository." -t "error"
        exit 1
    fi

    # Set ZSH environment variable
    export ZSH="$install_path"
    $print_debug "Installing oh-my-zsh in '$install_path'"

    # Install oh-my-zsh
    run "sh $ZSH/tools/install.sh --unattended"
    if [[ $? -ne 0 ]]; then
        $print_debug "Failed to install oh-my-zsh." -t "error"
        exit 1
    fi

    $print_debug "oh-my-zsh installed successfully." -t "debug"
}