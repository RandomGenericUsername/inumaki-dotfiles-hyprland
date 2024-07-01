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
source "$(pwd)/lib.sh"
source "$(pwd)/setup_resources.sh"
source "$(pwd)/installation_resources.sh"
install_settings="$(pwd)/installation_settings.sh"
source $install_settings

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

check_previous_installation $DOTFILES_INSTALL_DIR || exit $?

################################################ Print installation type ################################################

show_install_type

################################################ install required packages ################################################

#auth "Please provide root privileges to install packages"
install_pacman_packages $PACMAN_PKGS
install_yay 
drop_root_privileges
install_yay_packages $YAY_PKGS 

############################################ Dotfiles ################################################

generate_cookiecutter_context -t $COOKIECUTTER_TEMPLATE -o $COOKIECUTTER_CONTEXT -e $install_settings
cookiecutter $DOTFILES_TEMPLATE_DIR --no-input --config-file=$COOKIECUTTER_CONTEXT --output-dir=/tmp/ -f --verbose
#mv /tmp/temp-dotfiles/ /tmp/$DOTFILES_NAME/
#cp -r /tmp/$DOTFILES_NAME/. $DOTFILES_INSTALL_DIR 
#rm -rf /tmp/$DOTFILES_NAME/

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

