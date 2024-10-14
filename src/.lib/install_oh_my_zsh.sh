#!/bin/bash

install_oh_my_zsh(){
    # Download and run the Oh My Zsh installation script
    print_debug "Installing Oh My Zsh..."

    if [[ "$ENABLE_DEBUG" == "true" ]]; then
        echo -e "${COLOR_BLUE}"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        echo -e "${COLOR_NONE}" 
    else
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" > /dev/null 2>&1
    fi
} 