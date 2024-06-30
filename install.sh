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
                export DEBUG="true"
                shift # Move past the processed argument
                ;;
            -l|--log)
                export LOG="true"
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
script_dir=$(pwd)
vars=$script_dir/vars.sh
source $vars

############################################## Validate command line arguments ##############################################

show_pretty_message "Installer"
parse_options "$@" || exit $?

################################################### Create log files ################################################

if [ "$LOG" == "true" ]; then
    create_file $log
fi

exit 0

############################################# Validate if the distro is suppored ############################################

check_distro_support $supported_distro || exit $?

################################################ Prompt for installation ################################################

prompt_install 

################################################ Execute the setup for pre-installing ################################################

setup

################################################ Pretty print installer message ################################################

gum spin --spinner dot --title "Starting the installation now..." -- sleep 1

################################################ Check for previous installation ################################################

check_previous_installation $dotfiles_install_path || exit $?

################################################ Install required packages ################################################

exit 0
auth "Please provide root privileges to install packages"
install_pacman_packages $pacman_packages
install_yay
drop_root_privileges
install_yay_packages $yay_packages

exit 0

############################################ Install each corresponding component ################################################

install_wal

#####################################################################################################################################

print "Installation finished!" "info" "$log"
if [ "$LOG" == "true" ] && [ "$DEBUG" == "true" ]; then
    print "Installation log generated at $log" debug $log
fi

exit 0


# List of display managers to check
#display_managers="sddm waybar swaync hyprland hyprpaper wpaperd polkit NetworkManager bolt bluetooth"
#output="$(detect_enabled_services $display_managers)"
#output2="$(detect_running_processes $display_managers)"
#echo "services: $output"
#echo "processes: $output2"

