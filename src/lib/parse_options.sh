# Function to display help information
show_help() {

    pretty_print_installer_msg
    echo -e "${ERROR_COLOR}"
    echo "Usage: $0 [--debug|-d] [--log|-l]"
    echo -e "\nOptions:"
    echo "  --debug      Enable debug mode for verbose output."
    echo "  --log        Enable log mode for loggin output."
    echo -e "\nExample:"
    echo "  $0 --debug --log"
    echo -e "${NO_COLOR}"
}

# Function to parse command-line options
parse_options() {
    while [ $# -gt 0 ]; do
        case $1 in
            -d|--debug)
                export ENABLE_DEBUG="true"
                shift # Move past the processed argument
                ;;
            -l|--log)
                export ENABLE_LOG="true"
                shift # Move past the processed argument
                ;;
            *)
                show_help
                exit 1
                ;;
        esac
    done
}
