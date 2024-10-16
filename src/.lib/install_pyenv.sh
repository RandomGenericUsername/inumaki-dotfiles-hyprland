
install_pyenv() {
    local install_path="$1"
    local pyenv="$install_path/bin/pyenv"
    $print_debug "Installing pyenv in '$install_path'"
    # Check if pyenv is already installed and functional
    if [ -d "$install_path" ] && [ -x "$pyenv" ]; then
        if "$pyenv" --version >/dev/null 2>&1; then
            $print_debug "pyenv is already installed."
            return 0
        fi
    fi
    # Clone pyenv repository to the specified path
    run "git clone https://github.com/pyenv/pyenv.git $install_path"
    if [[ $? -ne 0 ]]; then
        $print_debug "Failed to clone pyenv repository."
        exit 1
    fi
    # Verify that pyenv was installed successfully
    if "$pyenv" --version >/dev/null 2>&1; then
        $print_debug "pyenv installed successfully." -t "debug"
    else
        $print_debug "pyenv installation failed. It may not be properly installed." -t "error"
        exit 1
    fi
    # Apply changes to current shell (for the current session)
    #export PATH="$install_path/bin:$PATH"
    #eval "$($pyenv init --path)"
    #eval "$($pyenv init -)"
    #eval "$($pyenv virtualenv-init -)"
}


install_python_version() {
    local install_path="$1"
    local python_version="$2"

    if [[ -z "$python_version" ]]; then
        $print_debug "Error: PYTHON_VERSION environment variable is not set. Please set it to the desired Python version." >&2
        exit 1
    fi
    # Install the specified Python version using pyenv
    $print_debug "Installing Python version $python_version..."
    PYENV_ROOT="$install_path" run "$install_path/bin/pyenv install -s $python_version"

    # Verify that Python was installed successfully
    if [ -x "$install_path/versions/$python_version/bin/python" ]; then
        $print_debug "Python $python_version installed successfully at $install_path/versions/$python_version."
    else
        $print_debug "Error: Failed to install Python $python_version." >&2
        exit 1
    fi
}
