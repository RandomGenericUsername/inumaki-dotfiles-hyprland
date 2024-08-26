# File: debug_functions.sh

# Function to log messages
log_message() {
    local log_line="$1"
    local log_path="$2"
    if [[ "$ENABLE_LOG" == "true" ]] && [[ -f "$log_path" ]]; then
        echo "$log_line" >> "$log_path"
    fi
}

# Function to print messages with color
print_with_color() {
    local message="$1"
    local type="$2"
    
    case "$type" in
        "info") echo "$message" ;;  # No color
        "warn") echo -e "\e[33m$message\e[0m" ;;  # Yellow
        "success") echo -e "\e[32m$message\e[0m" ;;  # Green
        "error") echo -e "\e[31m$message\e[0m" ;;  # Red
        "debug") echo -e "\e[34m$message\e[0m" ;;  # Blue
        *) echo "$message" ;;  # Default
    esac
}

# Main print function
print() {
    local message="$1"
    local type="info"
    local log_path=""
    local upper="false"
    local double_line="false"
    
    shift
    # Parse arguments
    while [[ "$#" -gt 0 ]]; do
        case $1 in
            --type|-t) type="$2"; shift ;;
            --log|-l) log_path="$2"; shift ;;
            --upper|-u) upper="$2"; shift ;;
            --double-line|-d) double_line="true" ;;
            *) echo "Unknown parameter passed: $1"; return 1 ;;
        esac
        shift
    done
    
    # Convert message to uppercase if needed
    if [ "$upper" == "true" ]; then
        message=$(echo "$message" | tr '[:lower:]' '[:upper:]')
    fi
    
    # Format message based on type
    case "$type" in
        "info") formatted_message=":: $message" ;;
        "warn") formatted_message=" !! $message !! " ;;
        "success") formatted_message="SUCCESS: $message" ;;
        "error") formatted_message="ERROR: $message" ;;
        "debug")
            if [ "$ENABLE_DEBUG" == "true" ]; then
                formatted_message="[DEBUG]: [ $message ]"
            else
                return 0  # Do not print debug messages if debugging is disabled
            fi
            ;;
        *) echo "Unrecognized type. Available options: info, warn, success, error, debug."; return 1 ;;
    esac
    
    # Print the message
    print_with_color "$formatted_message" "$type"
    
    # Log the message if logging is enabled and path is valid
    log_message "$formatted_message" "$log_path"
    
    # Print an additional empty line if double_line is true
    if [ "$double_line" == "true" ]; then
        echo ""
    fi
}
