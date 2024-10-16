install_nvm() {
    local install_path="$1"
    local nvm_dir="$install_path"
    $print_debug "Installing nvm in '$nvm_dir'"

    # Check if nvm is already installed and functional
    if [ -d "$nvm_dir" ] && [ -s "$nvm_dir/nvm.sh" ]; then
        $print_debug "nvm is already installed."
        return 0
    fi

    # Clone nvm repository to the specified path
    run "git clone https://github.com/nvm-sh/nvm.git $nvm_dir"
    if [[ $? -ne 0 ]]; then
        $print_debug "Failed to clone nvm repository." -t "error"
        exit 1
    fi

    # Apply nvm to the current shell session
    export NVM_DIR="$nvm_dir"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    # Verify that nvm was installed successfully
    if command -v nvm >/dev/null 2>&1; then
        $print_debug "nvm installed successfully." -t "debug"
    else
        $print_debug "nvm installation failed. It may not be properly installed." -t "error"
        exit 1
    fi
}