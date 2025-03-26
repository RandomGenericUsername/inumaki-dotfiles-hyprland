# Function to install yay
install_yay() {

    # Check if yay is already installed
    if command -v yay >/dev/null 2>&1 ; then
        $print_debug "'yay' is already installed."
        return 0
    fi

    # Ensure the script is run on Arch Linux
    if [[ ! -e /etc/arch-release ]]; then
        $print_debug "This script is intended for Arch Linux only." -t "error"
        return 1
    fi

    # Temporary directory for cloning yay
    temp_dir=$(mktemp -d -t yay-installation-XXXXXX)

    $print_debug "Cloning yay repository..."
    run "git clone https://aur.archlinux.org/yay.git $temp_dir/yay"
    if [[ $? -ne 0 ]]; then
        $print_debug "Failed to clone 'yay' repository." -t "error"
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
        $print_debug "'yay' installed successfully."
    else
        $print_debug "Failed to install 'yay'."
    fi

    return $result
}
