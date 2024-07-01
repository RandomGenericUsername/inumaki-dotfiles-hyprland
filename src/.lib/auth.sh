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
        print "$message" "info" "$log"
        sudo -k  # Force sudo to ask for a password again
        if sudo true; then
            print "Privileges acquired, continuing as root..." "info" "$log"
        else
            print "Failed to acquire necessary privileges" "error" "$log"
            exit 1
        fi
    fi
}



# Function to drop root privileges

# Function to drop root privileges and switch to the original invoking user
drop_root_privileges() {
    if [[ $EUID -ne 0 ]]; then
        print "Not running as root. No need to drop privileges." "debug" "$log"
        return 0  # Exit the function successfully if not running as root
    fi

    if [[ -z "$SUDO_USER" ]]; then
        print "Error: SUDO_USER is not set. Cannot drop root privileges." "debug" "$log"
        return 1  # Exit the function with an error status if SUDO_USER is not set
    fi

    print "Dropping root privileges, switching to user: $SUDO_USER" "debug" "$log"
    exec sudo -u "$SUDO_USER" -- "$SHELL"
    # This will start a new shell as SUDO_USER, replacing the current shell
}

