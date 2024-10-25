#!/bin/bash

# Function to collect environment variables from input files and write to the output file
get_env_vars() {
    # Get the number of input arguments
    local num_args=$#

    # The last argument is the output file
    local output_file=${!num_args}

    # Create or clear the output file
    > "$output_file"

    # Loop through all arguments except the last one (files)
    for ((i=1; i<num_args; i++)); do
        local file_path=${!i}

        # Check if the file exists
        if [[ -f "$file_path" ]]; then
            $print_debug "Extracting environment variables from $file_path"
            inside_array=false
            array_content=""

            # Read file line by line
            while IFS= read -r line || [[ -n "$line" ]]; do
                # If inside an array, keep appending lines until the closing parenthesis is found
                if [[ "$inside_array" == true ]]; then
                    array_content="${array_content}\n${line}"
                    if [[ $line =~ \) ]]; then
                        # Array completed, write it to the output
                        $print_debug "Multi-line array completed: $array_content"
                        echo -e "$array_content" >> "$output_file"
                        inside_array=false
                        array_content=""
                    fi
                    continue
                fi

                # Detect the start of an array
                if [[ $line =~ ^[[:space:]]*export[[:space:]]+[a-zA-Z_][a-zA-Z0-9_]*=\( ]]; then
                    array_content="$line"
                    $print_debug "Multi-line array detected: $line"
                    inside_array=true
                    continue
                fi

                # If not an array, handle regular export statements
                if [[ $line =~ ^[[:space:]]*export[[:space:]]+[a-zA-Z_][a-zA-Z0-9_]*=.*$ ]]; then
                    $print_debug "Regular variable detected: $line"
                    echo "$line" >> "$output_file"
                fi
            done < "$file_path"
        else
            $print_debug "$file_path does not exist or is not a file. Skipping..." -t "warn"
        fi
    done
    $print_debug "Environment variables extracted to $output_file"
}

