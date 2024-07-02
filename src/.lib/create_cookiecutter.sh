#!/bin/bash

# Function to generate context.json for Cookiecutter
generate_cookiecutter_context() {
    # Parse arguments
    local TEMPLATE_PATH=""
    local OUTPUT_PATH=""
    local ENV_FILE=""

    while [[ "$#" -gt 0 ]]; do
        case $1 in
            -t|--template) TEMPLATE_PATH="$2"; shift ;;
            -o|--output) OUTPUT_PATH="$2"; shift ;;
            -e|--env) ENV_FILE="$2"; shift ;;
            -h|--help)
                echo "Usage: generate_cookiecutter_context -t TEMPLATE_PATH -o OUTPUT_PATH -e ENV_FILE"
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
    if [ -z "$TEMPLATE_PATH" ] || [ -z "$OUTPUT_PATH" ] || [ -z "$ENV_FILE" ]; then
        echo "Error: Template path, output path, and environment file are required."
        return 1
    fi

    # Source the vars.sh file to get environment variables
    source "$ENV_FILE"

    # Read the template JSON file
    TEMPLATE_CONTENT=$(cat "$TEMPLATE_PATH")

    # Extract keys from the template JSON file
    TEMPLATE_KEYS=$(echo "$TEMPLATE_CONTENT" | jq -r 'keys[]')

    # Extract environment variable names
    ENV_VARS=$(env | cut -d= -f1)

    # Generate the context.json content
    CONTEXT_CONTENT=$(echo "$TEMPLATE_CONTENT" | jq -r '
      . as $template |
      reduce (keys[] | select(. != "")) as $key (
        $template;
        if $key | in(env) then
          .[$key] = env[$key]
        else
          .
        end
      )
    ')

    # Write the context content to the output file
    touch "$OUTPUT_PATH"
    echo "$CONTEXT_CONTENT" > "$OUTPUT_PATH"
}

#!/bin/bash

parse_cookiecutter_context_to_string() {
    local file_path="$1"
    shift
    local ignore_keys=()

    # Parse arguments for ignore keys
    while [[ "$1" != "" ]]; do
        case $1 in
            -i|--ignore-keys)
                shift
                while [[ "$1" != "" && "$1" != -* ]]; do
                    ignore_keys+=("$1")
                    shift
                done
                ;;
            *)
                echo "Unknown parameter: $1"
                return 1
                ;;
        esac
    done

    # Read the JSON file
    local json_content
    json_content=$(<"$file_path")

    # Parse the JSON and construct the result string
    local result=""
    while IFS= read -r line; do
        if [[ "$line" =~ ^[[:space:]]*\"([^\"]+)\"[[:space:]]*:[[:space:]]*\"?([^\"]*)\"?[[:space:]]*,?[[:space:]]*$ ]]; then
            local key="${BASH_REMATCH[1]}"
            local value="${BASH_REMATCH[2]}"

            # Check if the key should be ignored
            local ignore=false
            for ignore_key in "${ignore_keys[@]}"; do
                if [[ "$key" == "$ignore_key" ]]; then
                    ignore=true
                    break
                fi
            done

            if ! $ignore; then
                result+="$key=$value "
            fi
        fi
    done <<< "$json_content"

    # Trim trailing space and echo the result
    echo "${result% }"
}

get_cookiecutter_context() {
    local env_file=""
    local template_path=""
    local output_path="/tmp/cookiecutter-context.json"
    local ignore_keys=("project_slug" "_copy_without_render")

    while [[ "$#" -gt 0 ]]; do
        case $1 in
            -e|--env) env_file="$2"; shift ;;
            -t|--template) template_path="$2"; shift ;;
            -o|--output) output_path="$2"; shift ;;
            -i|--ignore) ignore_keys+=("$2"); shift ;;
            -h|--help)
                echo "Usage: get_cookiecutter_context -e ENV_FILE -t TEMPLATE_PATH [-o OUTPUT_PATH] [-i IGNORE_KEYS]"
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
    if [ -z "$env_file" ] || [ -z "$template_path" ]; then
        echo "Error: Environment file and template path are required."
        return 1
    fi

    generate_cookiecutter_context -t "$template_path" -o "$output_path" -e "$env_file"
    str="$(parse_cookiecutter_context_to_string "$output_path" -i "${ignore_keys[@]}")"
    rm "$output_path"
    echo "$str"
}


create_cookiecutter_project() {
    local env_file=""
    local template_dir=""
    local install_dir=""
    local dotfiles_name=""

    while [[ "$#" -gt 0 ]]; do
        case $1 in
            -e|--env) env_file="$2"; shift ;;
            -t|--template-dir) template_dir="$2"; shift ;;
            -i|--install-dir) install_dir="$2"; shift ;;
            -n|--name) dotfiles_name="$2"; shift ;;
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
    if [ -z "$env_file" ] || [ -z "$template_dir" ] || [ -z "$install_dir" ] || [ -z "$dotfiles_name" ]; then
        echo "Error: Environment file, template directory, install directory, and dotfiles name are required."
        return 1
    fi

    local cookiecutter_context
    cookiecutter_context=$(get_cookiecutter_context -e "$env_file" -t "$template_dir")
    cookiecutter "$template_dir" --no-input --output-dir=/tmp/ -f $cookiecutter_context
    cp -r "/tmp/$dotfiles_name/." "$install_dir"
    rm -rf "/tmp/$dotfiles_name/"
}

# Function to extract and format environment variables as JSON
get_env_vars() {
    local env_file="$1"
    local output_file="$2"
    local json_content="{"

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

    # Write JSON content to the output file
    echo "$json_content" > "$output_file"
}


