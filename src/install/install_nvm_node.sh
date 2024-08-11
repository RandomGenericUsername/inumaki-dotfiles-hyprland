#!/bin/bash

# Function to install NVM
install_nvm() {
    print "Installing NVM (Node Version Manager)..." -t "debug" -l "$LOG"

    # Download and install NVM
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash

    # Add NVM to the current shell session
    export NVM_DIR; NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

    print "NVM installed successfully!" -t "debug" -l "$LOG"
}

# Function to install Node.js and npm
__install_node() {
    local node_version=$1
    print "Installing Node.js version $node_version..."  -t "debug" -l "$LOG"
    nvm install "$node_version"
    nvm use "$node_version"
    nvm alias default "$node_version"

    print "Node.js version $node_version and npm installed successfully!" -t "debug" -l "$LOG"
}

# Function to check if NVM is already installed
check_nvm_installed() {
    if command -v nvm &> /dev/null; then
        print "NVM is already installed." -t "debug" -l "$LOG"
        return 0
    else
        print "NVM is not installed." -t "debug" -l "$LOG"
        return 1
    fi
}

# Main Script Execution
install_node() {
    # Check if NVM is already installed
    if ! check_nvm_installed; then
        install_nvm
    fi

    # Reload NVM to ensure it's available in the session
    export NVM_DIR; NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    # Install a specific Node.js version (e.g., 18)
    __install_node 20

    # Verify installations
    print "Verifying installations..." -t "debug" -l "$LOG"
    print "Node.js version: $(node --version)" -t "debug" -l "$LOG"
    print "npm version: $(npm --version)" -t "debug" -l "$LOG"
}

