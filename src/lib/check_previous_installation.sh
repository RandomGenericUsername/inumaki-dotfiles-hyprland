#!/bin/bash

# Define the IGNORE variable as an array of files or directories to exclude from the backup.
IGNORE=$IGNORE_FROM_BACKUP


# Function to generate a list of files and directories for backup, excluding IGNORE
generate_backup_list() {
    local install_path="$1"
    backup_list=()
    for item in "$install_path"/*; do
        local skip=false
        for ignore_item in "${IGNORE[@]}"; do
            if [[ "$item" == "$install_path/$ignore_item" ]]; then
                skip=true
                break
            fi
        done
        if [[ "$skip" == false ]]; then
            backup_list+=("$item")
        fi
    done
}


prompt_create_backup() {
    local install_path="$1"
    $print_debug "Do you want to create a backup of the directory $install_path before deleting? (Y/N):" -t "warn"
    while true; do
        printf "%b" "${WARN_COLOR}"
        read -e -p "> " yn
        printf "%b" "${NO_COLOR}"
        case "$yn" in
            [Yy]* )
                return 0  # User wants to create a backup, return success
                ;;
            [Nn]* )
                return 1  # User does not want a backup, return failure
                ;;
            * )
                $print_debug "Please answer Y or N." -t "error"
                ;;
        esac
    done
}

prompt_existing_installation(){
    
    # Menu options
    local options=(
        "Default: Deletes dependencies and updates the dotfiles." 
        "Update: Updates both dependencies and dotfiles." 
        "Clean: Deletes everything and installs again."
        "Abort."
    )

    $print_debug "Please select how you would like to keep going with the installation:" -t :"warn"

    # Display options using a select loop
    select choice in "${options[@]}"; do
        case "$choice" in
            "Default: Deletes dependencies and updates the dotfiles.")
                export INSTALL_TYPE="default"
                if [[ -d "$DEPENDENCIES_INSTALL_PATH" ]];then
                    delete_directory "$DEPENDENCIES_INSTALL_PATH" --yes
                fi
                break
                ;;
            "Update: Updates both dependencies and dotfiles.")
                export INSTALL_TYPE="update"
                break
                ;;
            "Clean: Deletes everything and installs again.")
                export INSTALL_TYPE="clean"
                delete_directory "$INSTALL_PATH" --yes
                break
                ;;
            "Abort.")
                $print_debug "Installation aborted" -t "error"
                exit 1
                ;;
            *)
                $print_debug "Invalid choice. Please enter a number between 1 and ${#options[@]}." -t "error"
                ;;
        esac
    done
    return 0
}



# Handle existing installation case
handle_existing_installation() {
    local install_path="$1"

    $print_debug "Previous installation detected in $install_path." -t "warn"
    prompt_existing_installation

    if [[ $? -ne 0 ]]; then
        return 1  # User chose to abort or encountered an error in prompt
    fi

    return 0  # Proceed to handle the existing installation
}

# Handle directory deletion with optional backup
handle_directory_deletion() {
    local install_path="$1"

    $print_debug "Directory $install_path is not empty but lacks a valid configuration file." -t "warn"
    prompt_create_backup "$install_path"

    if [[ $? -eq 0 ]]; then
        generate_backup_list "$install_path"
        create_backup "${backup_list[@]}" "$BACKUP_DIRECTORY" || exit 1
    else
        $print_debug "Backup skipped." -t "warn"
    fi

    delete_directory "$install_path" --yes
}


# Function to check for previous installations
check_previous_installation() {
    local install_path="$INSTALL_PATH"

    if [[ ! -d "$install_path" || -z "$(ls -A "$install_path")" ]]; then
        $print_debug "No valid installation found at $install_path. The directory does not exist or is empty."
        return 0  
    fi

    if is_valid_config; then
        generate_backup_list "$install_path"
        handle_existing_installation "$install_path"
        return $?
    else
        handle_directory_deletion "$install_path"
        return 0
    fi
}
