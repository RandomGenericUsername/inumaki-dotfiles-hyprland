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
