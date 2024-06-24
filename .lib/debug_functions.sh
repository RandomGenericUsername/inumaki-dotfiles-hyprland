# File: debug_functions.sh

# Function to handle debug messages
debug_print() {
    if [[ "$DEBUG" == "true" ]]; then
        echo "[DEBUG]: $1"
    fi
}
