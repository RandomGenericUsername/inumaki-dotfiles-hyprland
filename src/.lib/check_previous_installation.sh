#!/bin/bash

create_backup() {
    local sources=("${@:1:$#-1}")  # All arguments except the last one are source files/directories
    local backup_path="${!#}"  # The last argument is the backup directory or file
    local failed_items=()
    local all_failed=true

    # Check if the backup path is a file or directory
    if [[ -e "$backup_path" && -f "$backup_path" ]]; then
        # Case: Backup a single file
        if [[ "${#sources[@]}" -eq 1 && -f "${sources[0]}" ]]; then
            cp "${sources[0]}" "$backup_path"
            if [[ $? -ne 0 ]]; then
                failed_items+=("${sources[0]}")
            else
                all_failed=false
                $print_debug "File '${sources[0]}' successfully backed up to '$backup_path'." -t "success"
            fi
        else
            $print_debug "Error: Backup path provided as file, but multiple sources given." -t "error"
            return 2
        fi
    else
        # Ensure backup path exists as a directory
        if [[ ! -d "$backup_path" ]]; then
            mkdir -p "$backup_path"
            if [[ $? -ne 0 ]]; then
                $print_debug "Error: Could not create backup directory: $backup_path" -t "error"
                return 2
            else
                $print_debug "Backup directory '$backup_path' created successfully." -t "success"
            fi
        fi

        # Iterate through all source files/directories and back them up
        for source in "${sources[@]}"; do
            if [[ -e "$source" ]]; then
                cp -r "$source" "$backup_path"
                if [[ $? -ne 0 ]]; then
                    failed_items+=("$source")
                else
                    all_failed=false
                    $print_debug "'$source' successfully backed up to '$backup_path'." -t "success"
                fi
            else
                failed_items+=("$source")
            fi
        done
    fi

    # Determine return status based on failure information
    if [[ "$all_failed" == true ]]; then
        $print_debug "All files and directories failed to be backed up:" -t "error"
        for item in "${failed_items[@]}"; do
            $print_debug "$item" -t "error"
        done
        return 2
    elif [[ "${#failed_items[@]}" -gt 0 ]]; then
        $print_debug "The following files and directories failed to be backed up:" -t "warn"
        for item in "${failed_items[@]}"; do
            $print_debug "$item" -t "warn"
        done
        return 1
    else
        $print_debug "Backup completed successfully." -t "success"
        return 0
    fi
}

# Function to generate a list of files and directories for backup, excluding IGNORE
generate_backup_list() {
    local install_path="$1"
    backup_list=()
    local IGNORE=("${IGNORE_FROM_BACKUP[@]}")

    # Debug output to verify the install path
    $print_debug "Generating backup list for install path at: '$install_path'"

    # Use a for loop with proper wildcard expansion
    for item in "$install_path"/*; do
        # Skip if no files are found (when wildcard does not match anything)
        if [[ ! -e "$item" ]]; then
            $print_debug "No items found in '$install_path'" -t "debug"
            return 0
        fi

        local skip=false

        # Debug output for current item
        $print_debug "Processing item: '$item'" -t "debug"

        for ignore_item in "${IGNORE[@]}"; do
            # Debug output for ignore comparison
            $print_debug "Comparing item '$(basename "$item")' with ignore pattern '$ignore_item'" -t "debug"

            if [[ "$(basename "$item")" == "$ignore_item" ]]; then
                skip=true
                $print_debug "Skipping '$item' as it matches '$ignore_item'" -t "debug"
                break
            fi
        done

        if [[ "$skip" == false ]]; then
            backup_list+=("$item")
            $print_debug "Adding '$item' to backup list" -t "debug"
        fi
    done
    #$print_debug "The following files/directories were found:"
    print_existing_files "${backup_list[@]}"
}

prompt_create_backup() {
    local install_path="$1"
    $print_debug "Do you want to create a backup of '$install_path' (Y/N):" -t "warn"
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
    return $return_code
}



# Handle existing installation case
handle_existing_installation() {
    local install_path="$1"
    $print_debug "Previous installation detected in '$install_path'." -t "warn"
    prompt_existing_installation
}

# Handle directory deletion
handle_directory_deletion() {
    local install_path="$1"

    delete_directory "$install_path"
    return $?
}

# Function to print the list of existing files with their types
print_existing_files() {
    local files=("$@")
    $print_debug "The following files/directories were found at '$INSTALL_PATH':"
    for item in "${files[@]}"; do
        if [[ -d "$item" ]]; then
            item_type="Directory"
        elif [[ -f "$item" ]]; then
            item_type="File"
        elif [[ -L "$item" ]]; then
            item_type="Symlink"
        elif [[ -p "$item" ]]; then
            item_type="Named pipe"
        elif [[ -S "$item" ]]; then
            item_type="Socket"
        elif [[ -b "$item" ]]; then
            item_type="Block device"
        elif [[ -c "$item" ]]; then
            item_type="Character device"
        else
            item_type="Unknown"
        fi
        $print_debug "- '$(basename "$item")' | ($item_type)"
    done
}



# Function to check for previous installations
check_previous_installation() {
    local install_path="$INSTALL_PATH"

    # Check if the directory does not exist or is empty
    if [[ ! -d "$install_path" || -z "$(ls -A "$install_path")" ]]; then
        $print_debug "No valid installation found at '$install_path'. The directory does not exist or is empty." 
        return;
    fi

    # Generate backup list excluding IGNORE items
    generate_backup_list "$install_path"

    # Check if the directory is not empty after excluding ignored files
    if [[ "${#backup_list[@]}" -gt 0 ]]; then
        $print_debug "Directory '$install_path' is not empty. It is required to delete all its contents in order to install '$DOTFILES_NAME_RAW'." -t "warn"
        prompt_create_backup "$install_path"
        if [[ $? -eq 0 ]]; then
            timestamp=$(date +"%Y-%m-%dT%H-%M-%S")
            backup_dir="${BACKUP_DIRECTORY}/backup_${timestamp}"
            create_backup "${backup_list[@]}" "$backup_dir" || exit 1
        else
            $print_debug "Backup skipped." -t "warn"
        fi
    else
        $print_debug "No valid files to backup after excluding ignored files." -t "debug"
    fi

    # After handling backup, check if there's a valid configuration file
    if is_valid_config; then
        handle_existing_installation "$install_path"
    else
        $print_debug "Setup will delete everything in '$install_path' and proceed to install '$DOTFILES_NAME_RAW'." -t "warn"
        handle_directory_deletion "$install_path"
        was_deleted="$?"
        if [[ $was_deleted -ne 0 ]]; then
            $print_debug "Please provide another installation path or delete the contents of '$install_path' in order to proceed. Exiting..." -t "error"
            exit 1
        fi
    fi
}
