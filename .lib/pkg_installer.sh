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
debug_functions=$script_dir/debug.sh
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


# Function to install a package using the specified package manager or detect one if not provided, and log the result
pkg_install() {
    local pkg=$1
    local logfile=$2
    local pkg_manager=$(detect_package_manager)

    echo "Checking if $pkg is installed..." >> "$logfile"
    if ! command -v "$pkg" >/dev/null; then
        print "Attempting to install $pkg using $pkg_manager..." debug
        echo "Attempting to install $pkg using $pkg_manager..." >> "$logfile"
        case $pkg_manager in
            apt-get)
                if sudo apt-get install -y "$pkg"; then
                    echo "Successfully installed $pkg" >> "$logfile"
                else
                    echo "Failed to install $pkg" >> "$logfile"
                fi
                ;;
            yum)
                if sudo yum install -y "$pkg"; then
                    echo "Successfully installed $pkg" >> "$logfile"
                else
                    echo "Failed to install $pkg" >> "$logfile"
                fi
                ;;
            dnf)
                if sudo dnf install -y "$pkg"; then
                    echo "Successfully installed $pkg" >> "$logfile"
                else
                    echo "Failed to install $pkg" >> "$logfile"
                fi
                ;;
            pacman)
                if sudo pacman -S --noconfirm "$pkg"; then
                    echo "Successfully installed $pkg" >> "$logfile"
                else
                    echo "Failed to install $pkg" >> "$logfile"
                fi
                ;;
            zypper)
                if sudo zypper install -y "$pkg"; then
                    echo "Successfully installed $pkg" >> "$logfile"
                else
                    echo "Failed to install $pkg" >> "$logfile"
                fi
                ;;
            yay)
                if sudo yay -S "$pkg" --noconfirm; then
                    echo "Successfully installed $pkg with yay" >> "$logfile"
                else
                    echo "Failed to install $pkg with yay" >> "$logfile"
                fi
                ;;
            *)
                echo "Package manager not supported: $pkg_manager" >> "$logfile"
                ;;
        esac
    else
        print "$pkg is already installed." debug
        echo "$pkg is already installed." >> "$logfile"
    fi
}


# Function to iterate over a list of packages and handle logging
iterate_pkg_list() {
    local callback=""
    local package_file=""
    local logfile=""

    while [[ "$#" -gt 0 ]]; do
        case $1 in
            --callback|-c)
                callback="$2"
                shift 2
                ;;
            --package|-p)
                package_file="$2"
                shift 2
                ;;
            --log|-l)
                logfile="$2"
                shift 2
                ;;
            *)
                echo "Unknown parameter: $1"
                return 1
                ;;
        esac
    done

    if [[ -z "$callback" || -z "$package_file" || -z "$logfile" ]]; then
        echo "Usage: iterate_pkg_list [--callback | -c] <callback> [--package | -p] <path/to/file> [--log | -l] <path/to/log>"
        return 1
    fi

    echo "Reading package list from $package_file..." # Assuming 'print' function defined elsewhere
    while read -r pkg; do
        if [[ -n "$pkg" && "${pkg:0:1}" != "#" ]]; then  # Skip empty lines and comments
            print "Processing $pkg" debug
            $callback "$pkg" "$logfile"
        fi
    done < "$package_file"
}

install_packages() {
    local package_file="$1"
    local logfile="$2"
    local callback=pkg_install
    command="iterate_pkg_list --callback $callback --package $package_file --log $logfile"
    eval $command
}

yay_install() {
    local pkg=$1
    local log=$2
    echo "Attempting to install $pkg..." >> "$log"
    if yay -S "$pkg" --noconfirm; then
        echo "Successfully installed $pkg" >> "$log"
    else
        echo "Failed to install $pkg" >> "$log"
    fi
}


yay_install_packages() {
    local package_file="$1"
    local logfile="$2"
    local callback=yay_install
    command="iterate_pkg_list --callback $callback --package $package_file --log $logfile"
    eval $command
}
