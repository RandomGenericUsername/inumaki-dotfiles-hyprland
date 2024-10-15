
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
        $print_debug "No directory path provided." -t "error"
        return 1  # Exit the function with an error status
    fi

    # Check if the directory exists
    if [[ ! -d "$dir_path" ]]; then
        $print_debug "Directory does not exist at path: $dir_path"  -t "error"
        return 1
    fi

    if [[ "$skip_confirmation" = false ]]; then
        $print_debug "Do you want to delete the directory at $dir_path? (Y/N):" -t "warn"
        while true; do
            printf "%b" "${WARN_COLOR}"
            read -e -p "> " yn
            printf "%b" "${NO_COLOR}"
            case "$yn" in
                [Yy]* )
                    $print_debug "Deleting directory at $dir_path"
                    break
                    ;;
                [Nn]* )
                    $print_debug "Deletion aborted." -t "warn"
                    return 2  # Aborted
                    ;;
                * )
                    $print_debug "Please answer Y or N." -t "error"
                    ;;
            esac
        done
    fi


    # Proceed with deleting the directory
    rm -rf "$dir_path"
    if [[ $? -eq 0 ]]; then
        $print_debug "Directory $dir_path deleted successfully."
        return 0  # Success
    else
        $print_debug "Failed to delete $dir_path directory." -t "error"
        return 3  # Failure in deletion
    fi
}

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

create_dirs() {
    for dir in "$@"; do
        if [ ! -d "$dir" ]; then
            $print_debug "Creating directory: $dir" 
            mkdir -p "$dir"
        else 
            $print_debug "Directory already exists: $dir"
        fi
    done
}