#!/bin/bash

download_nvm(){

    if [[ "$ENABLE_DEBUG" == "true" ]]; then
        # Download and install NVM
        echo -e "${COLOR_BLUE}"
        curl https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh -o /tmp/nvm_install.sh
        echo -e "${COLOR_NONE}"

    else
        curl https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh -o /tmp/nvm_install.sh > /dev/null 2>&1
    fi

}

# Function to install NVM
install_nvm() {
    print_debug "Installing NVM (Node Version Manager)..."
    # Reload NVM to ensure it's available in the session
    export NVM_DIR; NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    # Check if NVM is already installed
    if  check_nvm_installed; then
        return 0
    fi
    download_nvm
    if [[ "$ENABLE_DEBUG" == "true" ]]; then
        echo -e "${COLOR_BLUE}"
        bash /tmp/nvm_install.sh
        echo -e "${COLOR_NONE}"
    else
        bash /tmp/nvm_install.sh > /dev/null 2>&1
    fi

    # Add NVM to the current shell session
    export NVM_DIR; NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

    print_debug "NVM installed successfully!"
}

# Function to install Node.js and npm
__install_node() {
    local node_version=$1
    if [[ "$ENABLE_DEBUG" == "true" ]]; then
        echo -e "${COLOR_BLUE}"
        nvm install "$node_version"
        nvm use "$node_version"
        nvm alias default "$node_version"
        echo -e "${COLOR_NONE}"
    else
        nvm install "$node_version" > /dev/null 2>&1
        nvm use "$node_version" > /dev/null 2>&1
        nvm alias default "$node_version" > /dev/null 2>&1
    fi
    print_debug "Node $node_version installed successfully: $(node --version)" 
}

# Function to check if NVM is already installed
check_nvm_installed() {
    if command -v nvm &> /dev/null; then
        print_debug "NVM is already installed."
        return 0
    else
        print_debug "NVM is not installed." 
        return 1
    fi
}

check_node_installed() {
    local node_version="$1"

    # Check if node command exists
    if ! command -v node > /dev/null 2>&1; then
        return 1
    fi

    # Check if the installed node version matches the required version
    if node -v | grep -q "v$node_version"; then
        return 0
    else
        return 1
    fi
}

# Main Script Execution
install_node() {
    local node_version="$1"
    print_debug "Installing Node version $node_version"

    if check_node_installed "$node_version"; then
        print_debug "Node $node_version is already installed"
        return 0
    fi

    # Reload NVM to ensure it's available in the session
    export NVM_DIR; NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    # Check if NVM is already installed
    if ! check_nvm_installed; then
        exit 1
    fi

    # Install a specific Node.js version (e.g., 18)
    __install_node "$node_version"
}

