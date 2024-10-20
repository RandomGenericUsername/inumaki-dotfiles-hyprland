#!/bin/bash

# Function to collect environment variables from input files and write to the output file
get_env_vars() {
    # Get the number of input arguments
    local num_args=$#

    # The last argument is the output file
    local output_file=${!num_args}

    # Create or clear the output file
    > "$output_file"

    $print_debug "Generating environment variables from input files: $*"
    # Loop through all arguments except the last one (files)
    for ((i=1; i < num_args; i++)); do
        local file_path=${!i}

        # Check if the file exists
        if [[ -f "$file_path" ]]; then
            # Append the content of each file to the output file if it exports variables
            $print_debug "Extracting environment variables from $file_path"
            grep -E '^[[:space:]]*export[[:space:]]+[a-zA-Z_][a-zA-Z0-9_]*=' "$file_path" >> "$output_file"
        else
            $print_debug "$file_path does not exist or is not a file. Skipping..." -t "warn"
        fi
    done

    # Remove duplicate lines in the output file (in case variables overlap across files)
    sort -u -o "$output_file" "$output_file"
}

