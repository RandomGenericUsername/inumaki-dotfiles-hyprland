# File: debug_functions.sh


# Function to handle debug messages
debug_print() {
    if [[ "$DEBUG" == "true" ]]; then
        echo "[DEBUG]: $1"
    fi
}

log(){
    local log_line=$1
    local log_path=$2
    if [[ "$LOG" == "true" ]]; then
        echo "$log_line" >> "$log_path"
    fi
}

print() {
    local message="$1"
    local level_info="$2"
    local log_path="$3"

    # Normalize message if no dashes imply it contains spaces
    if [[ "$message" != *-* ]]; then
        message="$message"
    fi

    # Handle the printing based on the level of information
    case "$level_info" in
        info)
            echo ":: $message"
            log ":: $message" $log_path
            ;;
        alert)
            echo " !! $message !! "
            log "!! $message !!" $log_path
            ;;
        error)
            echo "ERROR: $message"
            log "ERROR: $message" $log_path
            ;;
        debug)
            if [[ "${DEBUG}" == "true" ]]; then
                echo "[DEBUG]: [ $message ]"
                log "[DEBUG]: [ $message ]" $log_path
            fi
            ;;
        udebug)
            if [[ "${DEBUG}" == "true" ]]; then
                # Convert message to upper case for udebug level
                local upper_message=$(echo "$message" | tr '[:lower:]' '[:upper:]')
                echo "[DEBUG]: [ $upper_message ]"
                log "[DEBUG]: [ $upper_message ]" $log_path
            fi
            ;;
        *)
            echo "Unrecognized level_info. Available options: info, alert, error, debug, udebug."
            return 1
            ;;
    esac
}


