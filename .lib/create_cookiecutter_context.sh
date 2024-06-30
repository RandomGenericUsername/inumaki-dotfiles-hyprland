#!/bin/bash

# Function to display help
show_help() {
    echo "Usage: $0 -t TEMPLATE_PATH -e ENV_FILE"
    echo ""
    echo "  -t, --template  Path to the cookiecutter template"
    echo "  -e, --env       Path to the environment variables file"
}

# Parse command line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -t|--template) TEMPLATE_PATH="$2"; shift ;;
        -o|--output) OUTPUT_PATH="$2"; shift ;;
        -e|--env) ENV_FILE="$2"; shift ;;
        -h|--help) show_help; exit 0 ;;
        *) echo "Unknown parameter passed: $1"; show_help; exit 1 ;;
    esac
    shift
done

# Ensure required parameters are provided
if [ -z "$TEMPLATE_PATH" ] || [ -z "$ENV_FILE" ]; then
    echo "Error: Template path and environment file are required."
    show_help
    exit 1
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

# Print the context content before writing to the output file for debugging
echo "Context Content: $CONTEXT_CONTENT"

# Write the context content to the output file
echo "$CONTEXT_CONTENT" > "$OUTPUT_PATH"

echo "context.json has been generated at $OUTPUT_PATH"