
# Function to execute a command based on ENABLE_DEBUG
run() {
    local command="$@"

    # Check if ENABLE_DEBUG is set to true
    if [[ "$ENABLE_DEBUG" == "true" ]]; then
        # Execute the command normally
        eval "$command"
    else
        # Redirect output to /dev/null
        eval "$command" > /dev/null 2>&1
    fi
}