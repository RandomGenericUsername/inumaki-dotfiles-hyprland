#!/bin/bash


# Function to generate a list of files and directories for backup, excluding IGNORE
generate_backup_list() {
    local install_path="$1"
    backup_list=()
    #local IGNORE=("${IGNORE_FROM_BACKUP[*]}")
    local IGNORE=("${IGNORE_FROM_BACKUP[@]}")


    # Debug output to verify the install path
    $print_debug "Generating backup list for install path: $install_path" -t "debug"

    # Use a for loop with proper wildcard expansion
    for item in "$install_path"/*; do
        # Skip if no files are found (when wildcard does not match anything)
        if [[ ! -e "$item" ]]; then
            $print_debug "No items found in $install_path" -t "debug"
            return 0
        fi

        local skip=false

        # Debug output for current item
        $print_debug "Processing item: $item" -t "debug"

        for ignore_item in "${IGNORE[@]}"; do
            # Debug output for ignore comparison
            $print_debug "Comparing item $(basename "$item") with ignore pattern $ignore_item" -t "debug"

            if [[ "$(basename "$item")" == "$ignore_item" ]]; then
                skip=true
                $print_debug "Skipping $item as it matches $ignore_item" -t "debug"
                break
            fi
        done

        if [[ "$skip" == false ]]; then
            backup_list+=("$item")
            $print_debug "Adding $item to backup list" -t "debug"
        fi
    done

    # Debug output to verify the generated backup list
    $print_debug "Backup list generated: ${backup_list[@]}" -t "debug"
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

    # Print the prompt
    $print_debug "Please select how you would like to keep going with the installation:" -t "warn"

    while true; do
        printf "%b" "${WARN_COLOR}" 
        # Display options using a select loop
        select choice in "${options[@]}"; do
            printf "%b" "${WARN_COLOR}" 
            case "$choice" in
                "Default: Deletes dependencies and updates the dotfiles.")
                    export INSTALL_TYPE="default"
                    if [[ -d "$DEPENDENCIES_INSTALL_PATH" ]];then
                        delete_directory "$DEPENDENCIES_INSTALL_PATH" 
                        was_deleted="$?"
                        if [[ $was_deleted -ne 0 ]];then
                            $print_debug "Since dependencies directory wasn't deleted, the installation will be performed as update."
                            export INSTALL_TYPE="update"
                        fi
                    fi
                    break 2
                    ;;
                "Update: Updates both dependencies and dotfiles.")
                    export INSTALL_TYPE="update"
                    break 2
                    ;;
                "Clean: Deletes everything and installs again.")
                    export INSTALL_TYPE="clean"
                    delete_directory "$INSTALL_PATH"
                    break 2
                    ;;
                "Abort.")
                    $print_debug "Installation aborted" -t "error"
                    exit 1
                    ;;
                *)
                    $print_debug "Invalid choice. Please enter a number between 1 and ${#options[@]}." -t "error"
                    # Show the options again after an invalid input
                    break
                    ;;
            esac
        done
    done
    printf "%b" "${NO_COLOR}"
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
        if [[ "${#backup_list[@]}" -gt 0 ]]; then
            timestamp=$(date +"%Y-%m-%dT%H-%M-%S")
            backup_dir="${BACKUP_DIRECTORY}/backup_${timestamp}"
            create_backup "${backup_list[@]}" "$backup_dir" || exit 1
        else
            $print_debug "Nothing to backup." -t "warn"
        fi
    else
        $print_debug "Backup skipped." -t "warn"
    fi

    delete_directory "$install_path" 
    was_deleted="$?"
    if [[ $was_deleted -ne 0 ]];then
        $print_debug "Please provide another installation path or delete the contents of $install_path in order to proceed. Exiting..." -t "error"
        exit 1
    fi
}

# Function to check for previous installations
check_previous_installation() {
    local install_path="$INSTALL_PATH"

    # Check if the directory does not exist or is empty
    if [[ ! -d "$install_path" || -z "$(ls -A "$install_path")" ]]; then
        $print_debug "No valid installation found at $install_path. The directory does not exist or is empty."
        return 0  
    fi

    if is_valid_config; then
        handle_existing_installation "$install_path"
        return $?
    else
        handle_directory_deletion "$install_path"
        return 0
    fi
}
