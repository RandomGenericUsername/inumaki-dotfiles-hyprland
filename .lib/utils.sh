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
        read -p ":: Do you want to start the installation now? (Yy/Nn): " yn
        case $yn in
            [Yy]* )
                echo ":: Installation started."
            break;;
            [Nn]* ) 
                echo ":: Installation canceled."
                exit;
            break;;
            * ) echo ":: Please answer yes or no.";;
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



# Function to create a new file or clear it if it already exists
create_file() {
    local file_path="$1"

    if [[ -z "$file_path" ]]; then
        print "No file path provided." "error" "$log"
        return 1  # Exit the function with an error status
    fi

    # Extract the directory path from the file path
    local dir_path="$(dirname "$file_path")"

    # Check if the directory exists, create it if it doesn't
    if [[ ! -d "$dir_path" ]]; then
        print "Directory does not exist, creating directory: $dir_path" "debug" "$log"
        mkdir -p "$dir_path"
        if [[ $? -ne 0 ]]; then
            print "Failed to create directory at $dir_path" "error" "$log"
            return 2  # Exit the function with an error status if directory creation fails
        fi
    fi


    # Check if the file exists
    if [[ -f "$file_path" ]]; then
        print "File exists, clearing contents: $file_path" "debug" "$log"
        # Clear the file if it exists
        > "$file_path"
    else
        print "File does not exist, creating file: $file_path" "debug" "$log"
        # Create the file if it does not exist
        touch "$file_path"
        if [[ $? -ne 0 ]]; then
            print "Failed to create file at $file_path" "error" "$log"
            return 2  # Exit the function with an error status if file creation fails
        fi
    fi
    return 0  # Exit the function successfully
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

# Function to check for previous installations
check_previous_installation() {
    local install_path="$1"

    dir_exists "$install_path"
    folder_exists=$?

    if [ $folder_exists -eq 1 ]; then
        is_dir_empty "$install_path"
        folder_empty=$?

        if [ $folder_empty -eq 1 ]; then
            print "Previous installation detected in $install_path." "debug" "$log"
            return 1
        else
            print "Installation folder exists but is empty." "debug" "$log"
            return 0
        fi
    else
        print "No previous installation found." "debug" "$log"
        return 0
    fi
}


