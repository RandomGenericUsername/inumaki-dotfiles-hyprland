install_node_version() {
    local nvm_dir="$1"
    local node_version="$2"

    # Apply nvm to the current shell session
    export NVM_DIR="$nvm_dir"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    # Check if node version is provided
    if [ -z "$node_version" ]; then
        $print_debug "Error: NODE_VERSION environment variable is not set. Please set it to the desired Node.js version." -t "error"
        exit 1
    fi

    # Install the specified Node.js version using nvm
    $print_debug "Installing Node.js version $node_version..."
    run "nvm install $node_version"
    if [[ $? -ne 0 ]]; then
        $print_debug "Error: Failed to install Node.js version $node_version." -t "error"
        exit 1
    fi

    $print_debug "Node.js version $node_version installed successfully." -t "debug"
}