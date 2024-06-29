: '
     __ __     __  ____  _ __          __ __
  __/ // /_   / / / / /_(_) /____   __/ // /_
 /_  _  __/  / / / / __/ / / ___/  /_  _  __/
/_  _  __/  / /_/ / /_/ / (__  )  /_  _  __/
 /_//_/     \____/\__/_/_/____/    /_//_/

'
#!/bin/bash

# Script dir
script_dir=$(dirname $BASH_SOURCE)

# Access debug function
debug_functions=$script_dir/debug.sh
source $debug_functions 

show_pretty_message() {
    figlet -f slant -t "$1" | lolcat -t
}

prompt_install(){
    while true; do
        read -p ":: Do you want to start the installation now? (Yy/Nn): " yn
        case $yn in
            [Yy]* )
                echo ":: Installation started."
            break;;
            [Nn]* ) 
                echo ":: Installation canceled."
                exit;
            break;;
            * ) echo ":: Please answer yes or no.";;
        esac
    done
}

# Function to safely delete a directory with confirmation
delete_directory() {
    local dir_path="$1"
    local skip_confirmation=false

    # Parse arguments
    while [[ "$#" -gt 0 ]]; do
        case "$1" in
            -y|--yes) skip_confirmation=true ;;
            *) dir_path="$1" ;;  # Assume the first non-option argument is the directory path
        esac
        shift
    done

    # Check if the directory path is provided
    if [[ -z "$dir_path" ]]; then
        print "No directory path provided." error
        return 1  # Exit the function with an error status
    fi

    # Check if the directory exists
    if [[ ! -d "$dir_path" ]]; then
        print "Directory does not exist at path: $dir_path" debug 
        return 0 
    fi

    if [[ "$skip_confirmation" = false ]]; then
        print "Are you sure you want to delete the directory at '$dir_path'? [y/N]: " "alert"
        read -p "" confirmation
        case "$confirmation" in
            [yY][eE][sS]|[yY])
                ;;
            *)
                print "Deletion aborted by user." "alert"
                return 4  # User aborted
                ;;
        esac
    fi

    # Proceed with deleting the directory
    rm -rf "$dir_path"
    if [[ $? -eq 0 ]]; then
        print "Directory deleted successfully." "debug"
        return 0  # Success
    else
        print "Failed to delete directory." "error"
        return 3  # Failure in deletion
    fi
}



# Function to create a new file or clear it if it already exists
create_file() {
    local file_path="$1"

    if [[ -z "$file_path" ]]; then
        print "No file path provided." error
        return 1  # Exit the function with an error status
    fi

    # Extract the directory path from the file path
    local dir_path="$(dirname "$file_path")"

    # Check if the directory exists, create it if it doesn't
    if [[ ! -d "$dir_path" ]]; then
        print "Directory does not exist, creating directory: $dir_path" debug
        mkdir -p "$dir_path"
        if [[ $? -ne 0 ]]; then
            print "Failed to create directory at $dir_path" error
            return 2  # Exit the function with an error status if directory creation fails
        fi
    fi


    # Check if the file exists
    if [[ -f "$file_path" ]]; then
        print "File exists, clearing contents: $file_path" debug
        # Clear the file if it exists
        > "$file_path"
    else
        print "File does not exist, creating file: $file_path" debug
        # Create the file if it does not exist
        touch "$file_path"
        if [[ $? -ne 0 ]]; then
            print "Failed to create file at $file_path" error
            return 2  # Exit the function with an error status if file creation fails
        fi
    fi
    return 0  # Exit the function successfully
}

# Detects running processes based on a list of names
detect_running_processes() {
    local names=("$@")  # Accept an array of process names as arguments
    local running_processes=()

    for name in "${names[@]}"; do
        if pgrep -x "$name" > /dev/null; then
            running_processes+=("$name")
        fi
    done

    echo "${running_processes[@]}"
}

# Detects enabled services based on a list of service names
detect_enabled_services() {
    local services=("$@")  # Accept an array of service names as arguments
    local enabled_services=()

    for service in "${services[@]}"; do
        if systemctl --user is-enabled "${service}.service" 2>/dev/null | grep -q "enabled"; then
            enabled_services+=("$service")
        fi
    done

    echo "${enabled_services[@]}"
}

# Kills running processes based on a list of names
kill_running_processes() {
    local processes=("$@")  # Accept an array of process names as arguments

    for process in "${processes[@]}"; do
        pkill -x "$process"
        echo "Killed running process: $process"
    done
}

# Disables services based on a list of service names
disable_services() {
    local services=("$@")  # Accept an array of service names as arguments

    for service in "${services[@]}"; do
        systemctl --user disable "${service}.service"
        echo "Disabled service: ${service}.service"
    done
}

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


