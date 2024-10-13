
print_debug="$PRINT_DEBUG_UTILITY"

is_valid_config() {
    if [[ -f $CONFIG_FILE ]]; then
        $print_debug "Config file is valid" 
        return 0
    fi
    $print_debug "Config file is not valid" 
    return 1
}
