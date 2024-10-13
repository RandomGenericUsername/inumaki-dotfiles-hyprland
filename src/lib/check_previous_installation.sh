#!/bin/bash

print_debug="$PRINT_DEBUG_UTILITY"

prompt_existing_installation(){
    
    local gum_options=(
        "Default: Deletes dependencies and updates the dotfiles." 
        "Update: Updates both dependencies and dotfiles." 
        "Clean: Deletes everyting and install again."
        "Abort."
    )
    local msg="Please select how would you like to keep going with the installation:"

    choice=$(gum choose "${gum_options[@]}" --header="$msg")
    case "$choice" in
        "Default: Deletes dependencies and updates the dotfiles.")
            export INSTALL_TYPE="default"
            delete_directory "$DEPENDENCIES_INSTALL_PATH" --yes
            ;;
        "Update: Updates both dependencies and dotfiles.")
            export INSTALL_TYPE="update"
            ;;
        "Clean: Deletes everyting and install again.")
            export INSTALL_TYPE="clean"
            delete_directory "$INSTALL_PATH" --yes
            ;;
        "Abort.")
            $print_debug "Installation aborted" -t "error"
            exit 1
            ;;
    esac
    return 0
}

# Function to check for previous installations
check_previous_installation() {

    if [[ -d "$INSTALL_PATH" && -n "$(ls -A "$INSTALL_PATH")" ]]; then
        if is_valid_config; then
            $print_debug "Previous installation detected in $INSTALL_PATH." -t "warn"
            prompt_existing_installation 
            return $?
        else
            $print_debug "Directory $INSTALL_PATH is not empty but lacks a valid configuration file."  -t "warn"
            $print_debug "It will be deleted. Do you want to create a backup?"  -t "warn"
            delete_directory "$INSTALL_PATH" --yes
            return 0
        fi
    else
        $print_debug "No previous installation found at $INSTALL_PATH."
        return 0
    fi
}
