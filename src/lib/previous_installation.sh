#!/bin/bash

prompt_existing_installation(){
    
    install_path="$1"
    local gum_options=("Update" "Clean" "Abort")
    local msg="Please select how would you like to keep going with the installation:"

    delete_directory "$install_path"

    choice=$(gum choose "${gum_options[@]}" --header="$msg")
    case "$choice" in
        "Update")
            export INSTALL_TYPE="update"
            ;;
        "Clean")
            export INSTALL_TYPE="clean"
            ;;
        "Abort")
            print_debug "Installation aborted" -t "error"
            exit 1
            ;;
    esac
    return 0
}

# Function to check for previous installations
check_previous_installation() {

    #TODO improve clean and existing installation handling
    local install_path="$1"
    dir_exists "$install_path"
    folder_exists=$?
    if [ $folder_exists -eq 1 ]; then
        is_dir_empty "$install_path"
        folder_empty=$?

        if [ $folder_empty -eq 1 ]; then
            print_debug "Previous installation detected in $install_path." -t "warn"
            prompt_existing_installation $install_path
            return $?
        else
            print_debug "Installation folder exists but is empty."
            return 0
        fi
    else
        print_debug "No previous installation found."
        return 0
    fi
}

show_install_type(){
    print_debug "Performing $INSTALL_TYPE installation" -t "info"
}