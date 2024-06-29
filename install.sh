: '
     __ __     ____           __        ____               __ __
  __/ // /_   /  _/___  _____/ /_____ _/ / /__  _____   __/ // /_
 /_  _  __/   / // __ \/ ___/ __/ __ `/ / / _ \/ ___/  /_  _  __/
/_  _  __/  _/ // / / (__  ) /_/ /_/ / / /  __/ /     /_  _  __/
 /_//_/    /___/_/ /_/____/\__/\__,_/_/_/\___/_/       /_//_/

'
#######################################################################################################################

#!/bin/bash

#######################################################################################################################


# Function to display help information
show_help() {
    echo "Usage: $0 [--debug]"
    echo -e "\nOptions:"
    echo "  --debug      Enable debug mode for verbose output."
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

############################################## Define and export global variables ##############################################

export DEBUG="false"

###################################### Source relevant variables/constants and functions ########################################

script_dir=$(pwd)
vars=$script_dir/vars.sh
source $vars

############################################## Validate command line arguments ##############################################

parse_options "$@" || exit $?

############################################# Validate if the distro is suppored ############################################

check_distro_support $supported_distro || exit $?

################################################ Prompt for installation ################################################

show_pretty_message "Installer"
prompt_install 

################################################ Create log files ################################################

create_file $log

################################################ Install required packages ################################################

auth "Please provide root privileges to install packages"
install_pacman_packages $pacman_packages
install_yay
drop_root_privileges
install_yay_packages $yay_packages

#######################################################################################################################

# Copy required files
