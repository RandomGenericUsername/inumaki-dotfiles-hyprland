#!/bin/bash

# Function to extract the repo name from a git URL
get_repo_name() {
    local repo_url="$1"
    # Extract the last part of the repo URL (removing the ".git" at the end)
    echo "$(basename "$repo_url" .git)"
}

# Function to print debug messages only if ENABLE_DEBUG is true
debug_print() {
    if [[ "$ENABLE_DEBUG" == "true" ]]; then
        echo -e "${DEBUG_COLOR}$@${NO_COLOR}"
    fi
}

# Function to check and install missing utilities
check_and_install_utilities() {
    for util in "$@"; do
        local util_bin_var="${util}_UTILITY"
        local util_repo_var="${util}_UTILITY_REPO"
        local util_path_var="${util}_UTILITY_PATH"

        local util_bin="${!util_bin_var}"
        local util_repo="${!util_repo_var}"
        local util_path="${!util_path_var}"

        # Get the pretty repo name
        local repo_name
        repo_name=$(get_repo_name "$util_repo")

        # Check if the utility exists
        if [[ ! -x "$util_bin" ]]; then
            debug_print "Utility '$repo_name' not found at $util_bin. Installing..."
            # Clone the repository to the specified path
            run "git clone $util_repo $util_path"

            # Check if the utility was successfully installed
            if [[ ! -x "$util_bin" ]]; then
                debug_print "ERROR: Failed to install '$repo_name' from $util_repo. Exiting."
                exit 1
            else
                debug_print "'$repo_name' installed successfully at $util_bin."
            fi
        else
            debug_print "Utility '$repo_name' is already installed at $util_bin."
        fi
    done
}
