: '
     __ __     ___         __  __         __ __ 
  __/ // /_   /   | __  __/ /_/ /_     __/ // /_
 /_  _  __/  / /| |/ / / / __/ __ \   /_  _  __/
/_  _  __/  / ___ / /_/ / /_/ / / /  /_  _  __/ 
 /_//_/    /_/  |_\__,_/\__/_/ /_/    /_//_/    
                                                
'

# Function to check if the script is running as root
auth() {
    local message=$1
    if [ "$(id -u)" -ne 0 ]; then
        print_debug "$message" -t "info"
        sudo -k  # Force sudo to ask for a password again
        if sudo true; then
            print_debug "Privileges acquired, continuing as root..." -t "info"
        else
            print_debug "Failed to acquire necessary privileges" -t "error"
            exit 1
        fi
    fi
}



# Function to drop root privileges

# Function to drop root privileges and switch to the original invoking user
drop_root_privileges() {
    if [[ $EUID -ne 0 ]]; then
        print_debug "Not running as root. No need to drop privileges."
        return 0  # Exit the function successfully if not running as root
    fi

    if [[ -z "$SUDO_USER" ]]; then
        print_debug "Error: SUDO_USER is not set. Cannot drop root privileges."
        return 1  # Exit the function with an error status if SUDO_USER is not set
    fi

    print_debug "Dropping root privileges, switching to user: $SUDO_USER"
    exec sudo -u "$SUDO_USER" -- "$SHELL"
    # This will start a new shell as SUDO_USER, replacing the current shell
}

