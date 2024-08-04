#!/bin/bash

prompt_existing_installation(){
    
    install_path="$1"
    local gum_options=("Update" "Overwrite (clean install)" "Abort")
    local msg="Please select how would you like to keep going with the installation:"

    delete_directory "$install_path"

    choice=$(gum choose "${gum_options[@]}" --header="$msg")
    case "$choice" in
        "Update")
            export INSTALL_TYPE="update"
            ;;
        "Overwrite (clean install)")
            export INSTALL_TYPE="clean"
            ;;
        "Abort")
            print "Installation aborted" -t "error" -l "$LOG"
            exit 1
            ;;
    esac
    return 0
}

# Function to check for previous installations
check_previous_installation() {

    local install_path="$1"
    dir_exists "$install_path"
    folder_exists=$?
    if [ $folder_exists -eq 1 ]; then
        is_dir_empty "$install_path"
        folder_empty=$?

        if [ $folder_empty -eq 1 ]; then
            print "Previous installation detected in $install_path." -t "warn" -l "$LOG"
            prompt_existing_installation $install_path
            return $?
        else
            print "Installation folder exists but is empty." -t "debug" -l "$LOG"
            return 0
        fi
    else
        print "No previous installation found." -t "debug" -l "$LOG"
        return 0
    fi
}
