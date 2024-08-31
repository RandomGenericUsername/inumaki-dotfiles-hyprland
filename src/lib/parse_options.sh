pretty_print_installer_msg(){
    echo -e "${RED}"
    cat <<"EOF"
        ____           __        ____         
       /  _/___  _____/ /_____ _/ / /__  _____
       / // __ \/ ___/ __/ __ `/ / / _ \/ ___/
     _/ // / / (__  ) /_/ /_/ / / /  __/ /    
    /___/_/ /_/____/\__/\__,_/_/_/\___/_/     
EOF
    echo -e "${NONE}"
}

# Function to display help information
show_help() {

    pretty_print_installer_msg
    echo -e "${RED}"
    echo "Usage: $0 [--debug|-d] [--log|-l]"
    echo -e "\nOptions:"
    echo "  --debug      Enable debug mode for verbose output."
    echo "  --log        Enable log mode for loggin output."
    echo -e "\nExample:"
    echo "  $0 --debug --log"
    echo -e "${NONE}"
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
