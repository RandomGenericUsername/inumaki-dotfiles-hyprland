#!/bin/bash

create_cookiecutter_project() {
    local env_file=""
    local template_dir=""
    local install_dir=""

    while [[ "$#" -gt 0 ]]; do
        case $1 in
            -e|--env) env_file="$2"; shift ;;
            -t|--template-dir) template_dir="$2"; shift ;;
            -i|--install-dir) install_dir="$2"; shift ;;
            -h|--help)
                echo "Usage: create_cookiecutter_project -e ENV_FILE -t TEMPLATE_DIR -i INSTALL_DIR -n DOTFILES_NAME"
                return 0
                ;;
            *)
                echo "Unknown parameter passed: $1"
                return 1
                ;;
        esac
        shift
    done

    # Ensure required parameters are provided
    if [ -z "$env_file" ] || [ -z "$template_dir" ] || [ -z "$install_dir" ]; then
        echo "Error: Environment file, template directory, install directory, and dotfiles name are required."
        return 1
    fi

    #cookiecutter "$template_dir" --no-input --output-dir=/tmp/ -f $cookiecutter_context
    generate_cookiecutter_json "$env_file" "$template_dir/cookiecutter.json" 
    print "Creating cookiecutter project from $template_dir" -t "debug" -l "$LOG"
    cookiecutter --no-input -f --output-dir=$install_dir $template_dir
    print "Done copying the filesystem to $install_dir/$ENV_NAME" -t "info" -l "$LOG"
}

# Function to extract and format environment variables as JSON
generate_cookiecutter_json() {
    local env_file="$1"
    local output_file="$2"
    local json_content="{"

    print "Generating cookiecutter.json from $env_file" -t "debug" -l "$LOG"
    
    # Source the environment variables from the given file
    source "$env_file"

    # Extract all exported variables from the environment file
    local vars=$(grep -E '^export ' "$env_file" | sed 's/^export //')

    # Build JSON content
    for var in $vars; do
        key=$(echo "$var" | cut -d'=' -f1)

        # Check if the variable is an array
        if [[ $(declare -p "$key" 2>/dev/null) =~ "declare -a" ]]; then
            # Get the array values
            eval "array_values=(\"\${$key[@]}\")"
            formatted_array="["
            for value in "${array_values[@]}"; do
                formatted_array+="\"$value\", "
            done
            # Remove the trailing comma and space, then close the bracket
            formatted_array=${formatted_array%, }
            formatted_array+="]"
            json_content+="\"$key\": $formatted_array, "
        else
            value=$(eval echo \$$key)
            json_content+="\"$key\": \"$value\", "
        fi
    done

    # Remove the trailing comma and space, then close the JSON object
    json_content=${json_content%, }
    json_content+="}"

    print "Generated cookiecutter.json: $output_file" -t "debug" -l "$LOG"
    # Write JSON content to the output file
    echo "$json_content" > "$output_file"
}


