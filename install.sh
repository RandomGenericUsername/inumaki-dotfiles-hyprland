: '
     __ __     ____           __        ____               __ __
  __/ // /_   /  _/___  _____/ /_____ _/ / /__  _____   __/ // /_
 /_  _  __/   / // __ \/ ___/ __/ __ `/ / / _ \/ ___/  /_  _  __/
/_  _  __/  _/ // / / (__  ) /_/ /_/ / / /  __/ /     /_  _  __/
 /_//_/    /___/_/ /_/____/\__/\__,_/_/_/\___/_/       /_//_/

'

#!/bin/bash
# File: install.sh

# Get the script name
script_name=$(basename "$0")

# Function to display help information
show_help() {
    echo "Usage: $script_name [-d|--debug]"
    echo -e "\nOptions:"
    echo "  -d, --debug      Enable debug mode for verbose output."
    echo -e "\nExample:"
    echo "  $0 --debug"
}

# Function to parse command-line options
parse_options() {
    while [ $# -gt 0 ]; do
        case $1 in
            -d|--debug)
                export DEBUG="true"
                shift # Move past the processed argument
                ;;
            *)
                show_help
                exit 1
                ;;
        esac
    done
}

# Load other scripts
setup=.install/setup.sh
install=.install/install.sh
debug_functions=.lib/debug_functions.sh

# Get access to the debug functions
source $debug_functions # debug_print

# Initialize the debug flag
export DEBUG="false"

# Parse the comand line arguments
parse_options "$@"

# Parse the comand line arguments
parse_options "$@"

debug_print "[ Running installation script ]"

#$setup
#$install

debug_print "[ Installation finished!!! ]"

