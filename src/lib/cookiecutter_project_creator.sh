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
        print_debug "Error: Environment file, template directory, install directory, and dotfiles name are required." -t "error"
        return 1
    fi

    generate_cookiecutter_json "$env_file" "$template_dir/cookiecutter.json" || return $?

    if [[ ! -f "$template_dir/cookiecutter.json" ]];then
        print_debug "No cookiecutter.json found at $template_dir"
        return 1
    fi

    #cookiecutter "$template_dir" --no-input --output-dir=/tmp/ -f $cookiecutter_context
    print_debug "Creating cookiecutter project from $template_dir"
    # Source the python venv to use cookiecutter
    source "$PYTHON_VENV/bin/activate"
    cookiecutter --no-input -f --output-dir=$install_dir $template_dir
    deactivate
    print_debug "Done copying the filesystem to $install_dir/$DOTFILES_NAME"
    return 0
}

generate_cookiecutter_json() {
    local env_file="$1"
    local output_file="$2"
    local json_content="{"

    print_debug "Generating cookiecutter.json file from $env_file"

    # Source the environment variables from the given file
    source "$env_file"

    # Read each line of the file to correctly capture variables with spaces
    while IFS= read -r line; do
        # Extract only exported variables
        if [[ $line =~ ^export ]]; then
            # Strip 'export' and separate key and value
            line="${line#export }"
            key="${line%%=*}"
            value="${line#*=}"

            # Ensure the key is valid
            if [[ ! "$key" =~ [^a-zA-Z0-9_] ]]; then
                # Check if the variable is an array
                if [[ $(declare -p "$key" 2>/dev/null) =~ "declare -a" ]]; then
                    eval "array_values=(\"\${$key[@]}\")"
                    formatted_array="["
                    for item in "${array_values[@]}"; do
                        formatted_array+="\"$item\", "
                    done
                    formatted_array=${formatted_array%, }
                    formatted_array+="]"
                    json_content+="\"$key\": $formatted_array, "
                else
                    # Safely retrieve the value using indirect expansion
                    value="${!key}"
                    json_content+="\"$key\": \"$value\", "
                fi
            else
                print_debug "Skipping invalid key: $key"
            fi
        fi
    done < "$env_file"

    # Remove the trailing comma and space, then close the JSON object
    json_content=${json_content%, }
    json_content+="}"

    # Write JSON content to the output file
    echo "$json_content" > "$output_file"
}
