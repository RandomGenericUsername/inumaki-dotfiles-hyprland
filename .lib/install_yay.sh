#!/bin/bash


# Function to check if a command is available
command_exists() {
    command -v "$1" >/dev/null 2>&1
}


# Function to install yay
install_yay() {
    # Check if yay is already installed
    if command_exists yay; then
        print "yay is already installed." debug
        return 0
    fi

    # Ensure the script is run on Arch Linux
    if [[ ! -e /etc/arch-release ]]; then
        print "This script is intended for Arch Linux only." error
        return 1
    fi

    # Temporary directory for cloning yay
    temp_dir=$(mktemp -d -t yay-installation-XXXXXX)

    print "Cloning yay repository..." debug
    git clone https://aur.archlinux.org/yay.git "$temp_dir/yay"
    if [[ $? -ne 0 ]]; then
        print "Failed to clone yay repository." error
        return 1
    fi

    # Change to the directory and build yay
    pushd "$temp_dir/yay"
    makepkg -si
    local result=$?
    popd

    # Clean up the temporary directory
    rm -rf "$temp_dir"

    # Check if the installation was successful
    if [[ $result -eq 0 ]]; then
        echo "yay installed successfully."
    else
        echo "Failed to install yay."
    fi

    return $result
}
