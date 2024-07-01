: '
     __ __     __  ____  _ __          __ __
  __/ // /_   / / / / /_(_) /____   __/ // /_
 /_  _  __/  / / / / __/ / / ___/  /_  _  __/
/_  _  __/  / /_/ / /_/ / (__  )  /_  _  __/
 /_//_/     \____/\__/_/_/____/    /_//_/

'
#!/bin/bash


show_pretty_message() {
    figlet -f slant -t "$1" | lolcat -t
}

prompt_install(){
    while true; do
        print "Do you want to start the installation now? (Yy/Nn):" -t "info" -l "$LOG"
        read -p "" yn
        case $yn in
            [Yy]|[Yes]|[yes]* )
                print "Installation started." -t "info" -l "$LOG"
            break;;
            [Nn]|[No]|[no]* ) 
                print "Installation canceled." -t "error" -l "$LOG"
                exit;
            break;;
            * ) print "Please answer yes or no." -t "warn";;
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

create_log() {
    if [ "$ENABLE_LOG" == "true" ]; then
        if [ -d "$LOG_DIR" ]; then
            # Directory exists
            if [ -f "$LOG" ]; then
                print "Log file exists, cleaning it. Check $LOG" -t "debug"
                # Log file exists, clean it
                : > "$LOG"
            else
                print "Log file doesn't exist, creating it at $LOG" -t "debug"
                # Log file doesn't exist, create it
                touch "$LOG"
            fi
        else
            print "Log file doesn't exist, creating it at $LOG" -t "debug"
            # Directory doesn't exist, create it and then the log file
            mkdir -p "$LOG_DIR"
            touch "$LOG"
        fi
    fi
}


# ------------------------------------------------------
# System check
# ------------------------------------------------------

dir_exists() {
    local dir="$1";
    if [ -d $dir ]; then
        return 1
    fi
    return 0
}

is_dir_empty() {
    local dir="$1"
    if [ -d $dir ] ;then
        if [ -z "$(ls -A $dir)" ]; then
            return 0
        else
            return 1
        fi
    else
        return 1
    fi
}

pretty_print_installer_msg(){
    echo -e "${RED}"
    cat <<"EOF"
        ____           __        ____         
       /  _/___  _____/ /_____ _/ / /__  _____
       / // __ \/ ___/ __/ __ `/ / / _ \/ ___/
     _/ // / / (__  ) /_/ /_/ / / /  __/ /    
    /___/_/ /_/____/\__/\__,_/_/_/\___/_/     
EOF
    echo -e "${NONE}"
}

# Function to display help information
show_help() {

    pretty_print_installer_msg
    echo -e "${RED}"
    echo "Usage: $0 [--debug|-d] [--log|-l]"
    echo -e "\nOptions:"
    echo "  --debug      Enable debug mode for verbose output."
    echo "  --log        Enable log mode for loggin output."
    echo -e "\nExample:"
    echo "  $0 --debug --log"
    echo -e "${NONE}"
}

show_install_type(){
    print "Performing: $INSTALL_TYPE installation" -t "info" -l "$LOG"
}
