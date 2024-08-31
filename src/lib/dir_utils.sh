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
        print_debug "No directory path provided." -t "error"
        return 1  # Exit the function with an error status
    fi

    # Check if the directory exists
    if [[ ! -d "$dir_path" ]]; then
        print_debug "Directory does not exist at path: $dir_path"  -t "error"
        return 0 
    fi

    if [[ "$skip_confirmation" = false ]]; then
        local gum_options=("Yes" "No")
        local msg="Do you want to delete the directory at $dir_path?"
        choice=$(gum choose "${gum_options[@]}" --header="$msg")
        case "$choice" in
            "Yes")
                print_debug "Deleting directory at $dir_path"  -t "info"
                ;;
            "No")
                print_debug "Deletion aborted."  -t "info"
                return 2  # Aborted
                ;;
        esac
    fi

    # Proceed with deleting the directory
    rm -rf "$dir_path"
    if [[ $? -eq 0 ]]; then
        print_debug "Directory deleted successfully."
        return 0  # Success
    else
        print_debug "Failed to delete directory." -t "error"
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
            print "Creating directory: $dir" -t "debug" -l "$LOG"
            mkdir -p "$dir"
            else 
                print "Directory already exists: $dir" -t "debug" -l "$LOG"
        fi
    done
}