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

###################################### Source relevant variables/constants and functions ########################################

clear

this_dir="$(pwd)"

setup_scripts=$this_dir/src/setup/export.sh
lib_scripts=$this_dir/src/.lib/export.sh
install_scripts=$this_dir/src/install/export.sh
installation_settings=$this_dir/installation_settings.sh

source $setup_scripts
source $lib_scripts
source $install_scripts
source $installation_settings


############################################## Validate command line arguments ##############################################

parse_options "$@" || exit $?

################################################ Pretty print installer message ################################################

pretty_print_installer_msg

################################################### Create log files ################################################

create_log

################################################ Prompt for installation ################################################

prompt_install 

############################################# Validate if the distro is suppored ############################################

check_distro_support $SUPPORTED_DISTRO || exit $?

################################################ Execute the setup for pre-installing ################################################

setup

################################################ Pretty print installer message ################################################

gum spin --spinner dot --title "Starting the installation now..." -- sleep 1

################################################ Check for previous installation ################################################

check_previous_installation $ENV_DIR || exit $?

################################################ Print installation type ################################################

show_install_type

################################################ install required packages ################################################

#auth "Please provide root privileges to install packages"
install_pacman_packages $PACMAN_PKGS
install_yay 
drop_root_privileges
install_yay_packages $YAY_PKGS 

############################################ Dotfiles ################################################

get_env_vars $COOKIECUTTER_CONTEXT $COOKIECUTTER_JSON
#create_cookiecutter_project $install_settings

############################################ Print installation is finished ################################################

print "Installation finished!" -t "info" -l "$LOG"
if [ "$ENABLE_LOG" == "true" ] && [ "$ENABLE_DEBUG" == "true" ]; then
    print "Installation log generated at $LOG" -t "debug" -l "$LOG"
fi

exit 0

############################################ Install each corresponding component ################################################

install_wal

#####################################################################################################################################

# List of display managers to check
#display_managers="sddm waybar swaync hyprland hyprpaper wpaperd polkit NetworkManager bolt bluetooth"
#output="$(detect_enabled_services $display_managers)"
#output2="$(detect_running_processes $display_managers)"
#echo "services: $output"
#echo "processes: $output2"

