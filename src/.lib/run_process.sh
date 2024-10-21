#!/bin/bash

# Function to execute a command based on ENABLE_DEBUG
# Function to execute a command based on ENABLE_DEBUG
run() {
    local command="$*"
    local status

    # Check if ENABLE_DEBUG is set to true
    if [[ "$ENABLE_DEBUG" == "true" ]]; then
        # Print in DEBUG_COLOR without adding an extra newline
        printf "%b" "${DEBUG_COLOR}"

        # Capture command output and print it in color
        eval "$command" 2>&1 | while IFS= read -r line; do
            printf "%b%s%b\n" "${DEBUG_COLOR}" "$line" "${NO_COLOR}"
        done
        status=${PIPESTATUS[0]}

        printf "%b" "${NO_COLOR}"
    else
        # Redirect output to /dev/null
        eval "$command" > /dev/null 2>&1
        status=$?
    fi

    return "$status"
}

