#!/bin/bash

# Function to sanitize the utility name
sanitize_name() {
    local name="$1"
    # Replace invalid characters (dots and hyphens) with underscores
    echo "${name//./_}" | tr '-' '_'
}

# Function to extract the repo name from the URL
get_repo_name() {
    local repo_url="$1"
    echo "${repo_url##*/}" | sed 's/\.git$//'
}

debug_print(){
    local msg="$@"
    if [[ "$ENABLE_DEBUG" == "true" ]];then
        printf "%b" "${DEBUG_COLOR}" 
        echo "DEBUG: [$msg]"
        printf "%b" "${NO_COLOR}" 
    fi
}

check_and_install_utilities() {
    local install_path="$1"
    shift # Remove the first argument so we can loop through the utilities

    for util_repo in "$@"; do
        # Generate utility names from the repo URL
        local util_name
        util_name=$(get_repo_name "$util_repo")   # Extracts the repo name
        local sanitized_util_name
        sanitized_util_name=$(sanitize_name "$util_name") # Sanitize the name

        local util_bin_var="${sanitized_util_name}_UTILITY"
        local util_path_var="${sanitized_util_name}_UTILITY_PATH"

        # Set the utility path
        export "${util_path_var}=${install_path}/${util_name}"

        # Get the utility binary path
        local util_bin="${!util_bin_var:-$install_path/$util_name}"

        # Check if the utility exists
        if [[ ! -x "$util_bin" ]]; then
            debug_print "Utility '$util_name' not found at $util_bin. Installing..."
            # Clone the repository to the specified path
            run "git clone $util_repo ${!util_path_var}"

            # Check if the utility was successfully installed
            if [[ ! -x "$util_bin" ]]; then
                debug_print "ERROR: Failed to install '$util_name' from $util_repo. Exiting."
                exit 1
            else
                debug_print "'$util_name' installed successfully at $util_bin."
            fi
        else
            debug_print "Utility '$util_name' is already installed at $util_bin."
        fi
    done
}