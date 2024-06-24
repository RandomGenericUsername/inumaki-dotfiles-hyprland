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

# Log path
export LOGS_PATH=./logs
install_log="$LOGS_PATH/install.log"

# Get access to the debug functions
debug_functions=.lib/debug_functions.sh
source $debug_functions # debug_print

# Get access to the pkg installer functions
pkg_installer_functions=.lib/pkg_installer.sh
source $pkg_installer_functions # iterate_pkg_list

# Get access to utils
utils=.lib/utils.sh
source $utils

# Get access to auth 
auth_def=.lib/auth.sh
source $auth_def

# Path to the list of packages
pkg_list_path=packages.sh

# Initialize the debug flag
export DEBUG="false"

# Parse the comand line arguments
parse_options "$@"

debug_print "[ Running installation script ]"

# Create the dir for logging
create_dir_for_file $install_log
clean_log $install_log

# Ask for authentication
auth "Please provide root privileges to continue with the installation..."

# Install the packages
install_packages $pkg_list_path $install_log

# Copy the required files

debug_print "[ Installation finished!!! ]"

