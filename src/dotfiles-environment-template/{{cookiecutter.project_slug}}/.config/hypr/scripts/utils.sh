#!/bin/bash

is_image() {
    local file_path="$1"
    if identify "$file_path" > /dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

check_valid_wallpaper_path(){
    # 0: wallpaper path was provided and is valid
    # 1: no arguments were passed to the function
    # 2: invalid or no wallpaper path passed
    local wallpaper_path="$1"
    if [ -z "$wallpaper_path" ]; then
        echo ""
        return 2
    else
        if [ -e "$wallpaper_path" ]; then
            if is_image "$wallpaper_path"; then
                echo "$wallpaper_path"
                return 0
            else
                echo ""
                return 2
            fi
        else
            echo ""
            return 2
        fi
    fi
}

# Function to check if a path is authentic or a symbolic link and return the resolved path
authentic_path() {
    local path="$1"

    # Check if the path is a symbolic link
    if [ -L "$path" ]; then
        # If it is a symbolic link, resolve and return the final target
        echo "$(readlink -f "$path")"
    else
        # If it is not a symbolic link, return the original path
        echo "$path"
    fi
}

# Create file if not exists
if_not_exists_create_file(){
    if [ -z $1 ]; then
        echo "No file path provided"
        return 1
    fi
    if [ ! -f $1 ] ;then
        touch $1
        if [ ! -z $2 ]; then
            echo "$2" > $1
        fi
    fi
    return 0
}

# Function to safely cat a file
safe_cat() {
    local file_path="$1"

    # Check if the file exists
    if [ -f "$file_path" ]; then
        cat "$file_path"
    else
        echo ""
    fi
}

###################
_or() {
    if [ -z "$1" ] || [ "$1" == "null" ] || [ "$1" == "none" ]; then
        echo "$2"
    else
        echo "$1"
    fi
}

get_file_name() {
    local file_path="$1"
    
    # Extract the base name (filename with all extensions)
    local filename_with_ext
    filename_with_ext="$(basename "$file_path")"
    
    # Remove all extensions (everything after the first dot)
    local filename
    filename="${filename_with_ext%%.*}"
    
    # Output the result
    echo "$filename"
}

is_in_array() {
    local element="$1"
    shift
    local array=("$@")
    for item in "${array[@]}"; do
        if [[ "$item" == "$element" ]]; then
            return 0  # Found, return success
        fi
    done

    return 1  # Not found, return failure
}
