create_log() {
    print_debug="$PRINT_DEBUG_UTILITY"
    if [ "$ENABLE_LOG" == "true" ]; then
        LOG_DIR=$(dirname "$LOG")
        
        if [ -d "$LOG_DIR" ]; then
            # Directory exists
            if [ -f "$LOG" ]; then
                $print_debug "Log file exists, cleaning it. Check $LOG" -t "debug"
                # Log file exists, clean it
                : > "$LOG"
            else
                $print_debug "Log file doesn't exist, creating it at $LOG" -t "debug"
                # Log file doesn't exist, create it
                touch "$LOG"
            fi
        else
            $print_debug "Log file doesn't exist, creating it at $LOG" -t "debug"
            # Directory doesn't exist, create it and then the log file
            mkdir -p "$LOG_DIR"
            touch "$LOG"
        fi
    else
        $print_debug "Log is not enabled"
    fi
}
