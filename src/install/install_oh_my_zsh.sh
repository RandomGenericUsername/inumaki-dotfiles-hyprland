#!/bin/bash

install_oh_my_zsh(){
    # Download and run the Oh My Zsh installation script
    print "Installing Oh My Zsh..." -t "debug" -l "$LOG"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
} 