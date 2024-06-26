# File: debug_functions.sh

__dir=$(dirname "$BASH_SOURCE")
__name=$(basename "$0")

# Function to handle debug messages
debug_print() {
    if [[ "$DEBUG" == "true" ]]; then
        echo "[DEBUG]: $1"
    fi
}

print() {
    local message="$1"
    local level_info="$2"

    # Normalize message if no dashes imply it contains spaces
    if [[ "$message" != *-* ]]; then
        message="$message"
    fi

    # Handle the printing based on the level of information
    case "$level_info" in
        info)
            echo ":: $message"
            ;;
        alert)
            echo " !! $message !! "
            ;;
        error)
            echo "ERROR: $message"
            ;;
        debug)
            if [[ "${DEBUG}" == "true" ]]; then
                echo "[DEBUG]: [ $message ]"
            fi
            ;;
        udebug)
            if [[ "${DEBUG}" == "true" ]]; then
                # Convert message to upper case for udebug level
                local upper_message=$(echo "$message" | tr '[:lower:]' '[:upper:]')
                echo "[DEBUG]: [ $upper_message ]"
            fi
            ;;
        *)
            echo "Unrecognized level_info. Available options: info, alert, error, debug, udebug."
            return 1
            ;;
    esac
}


