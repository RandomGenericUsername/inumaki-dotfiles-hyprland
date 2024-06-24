: '
     __ __           __              _            __        ____               __ __
  __/ // /_   ____  / /______ _     (_)___  _____/ /_____ _/ / /__  _____   __/ // /_
 /_  _  __/  / __ \/ //_/ __ `/    / / __ \/ ___/ __/ __ `/ / / _ \/ ___/  /_  _  __/
/_  _  __/  / /_/ / ,< / /_/ /    / / / / (__  ) /_/ /_/ / / /  __/ /     /_  _  __/
 /_//_/    / .___/_/|_|\__, /____/_/_/ /_/____/\__/\__,_/_/_/\___/_/       /_//_/
          /_/         /____/_____/
'
#!/bin/bash

# Script dir
script_dir=$(dirname $BASH_SOURCE)

# Access debug function
debug_functions=$script_dir/debug_functions.sh
source $debug_functions #debug_print

# Function to detect the package manager
detect_package_manager() {
    if command -v apt-get >/dev/null; then
        echo "apt-get"
    elif command -v yum >/dev/null; then
        echo "yum"
    elif command -v dnf >/dev/null; then
        echo "dnf"
    elif command -v pacman >/dev/null; then
        echo "pacman"
    elif command -v zypper >/dev/null; then
        echo "zypper"
    else
        echo "UNKNOWN"
    fi
}

# Installation function (callback) that uses a log file path
install_function() {
    local pkg=$1
    local logfile=$2
    local pkg_manager=$(detect_package_manager)

    if ! command -v "$pkg" >/dev/null; then
        echo "Attempting to install $pkg using $pkg_manager..."
        case $pkg_manager in
            apt-get)
                sudo apt-get install -y "$pkg" || echo "Failed to install $pkg" >> "$logfile"
                ;;
            yum)
                sudo yum install -y "$pkg" || echo "Failed to install $pkg" >> "$logfile"
                ;;
            dnf)
                sudo dnf install -y "$pkg" || echo "Failed to install $pkg" >> "$logfile"
                ;;
            pacman)
                sudo pacman -S --noconfirm "$pkg" || echo "Failed to install $pkg" >> "$logfile"
                ;;
            zypper)
                sudo zypper install -y "$pkg" || echo "Failed to install $pkg" >> "$logfile"
                ;;
            *)
                echo "Package manager not supported: $pkg_manager" >> "$logfile"
                ;;
        esac
    else
        echo "$pkg is already installed."
    fi
}


# Function to iterate over a list of packages and handle logging
iterate_pkg_list() {
    local package_file="$1"
    local callback="$2"
    local logfile="$3"
    #local callback=${2:-install_function}
    #local logfile=${3:-"./install_log.txt"}  # Default log file path if not provided

    debug_print "[ Reading package list from $package_file... ]"
    while read -r pkg; do
        if [ -n "$pkg" ] && [ "${pkg:0:1}" != "#" ]; then  # Skip empty lines and comments
            debug_print "Processing $pkg"
            $callback "$pkg" "$logfile"
        fi
    done < "$package_file"
}

install_packages() {
    local package_file="$1"
    local logfile=${2:-"./install_log.txt"}  # Default log file path if not provided
    local callback=${3:-install_function}
    iterate_pkg_list $package_file $callback $logfile
}

