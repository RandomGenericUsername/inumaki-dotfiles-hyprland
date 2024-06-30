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

    echo "Sourcing $ENV_FILE"
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
    echo "context.json has been generated at $OUTPUT_PATH"
}
