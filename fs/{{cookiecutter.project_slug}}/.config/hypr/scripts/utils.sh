#!/bin/bash

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


#!/bin/bash
get_var() {
    local file_path="$1"
    local key="$2"

    # Check if the file exists
    if [ ! -f "$file_path" ]; then
        echo ""
        return 1
    fi

    # Source the file to load variables
    source "$file_path"

    # Use indirect expansion to get the value of the variable
    local value="${!key}"

    # Check if the variable is set
    if [ -z "${value+x}" ]; then
        echo ""
        return 1
    else
        echo "$value"
        return 0
    fi
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

_or() {
    if [ -z "$1" ]; then
        echo "$2"
    else
        echo "$1"
    fi
}

