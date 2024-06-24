: '
     __ __     ___         __  __         __ __ 
  __/ // /_   /   | __  __/ /_/ /_     __/ // /_
 /_  _  __/  / /| |/ / / / __/ __ \   /_  _  __/
/_  _  __/  / ___ / /_/ / /_/ / / /  /_  _  __/ 
 /_//_/    /_/  |_\__,_/\__/_/ /_/    /_//_/    
                                                
'

# Script dir
script_dir=$(dirname $BASH_SOURCE)

# Access debug function
debug_functions=$script_dir/debug_functions.sh
source $debug_functions #debug_print


# Function to check if the script is running as root
auth() {
     if [ "$(id -u)" -ne 0 ]; then
        debug_print "Please provide root privileges."
        sudo -k  # Force sudo to ask for a password again
        if sudo true; then
            debug_print "Privileges acquired, continuing as root..."
        else
            debug_print "Failed to acquire necessary privileges."
            exit 1
        fi
    fi

}


