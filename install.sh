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

# Function to display pretty installer in terminal 
show_pretty_messsage() {
    figlet -f slant -t "# Installer #" | lolcat -t 
}

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

prompt_install(){
    while true; do
    read -p ":: Do you want to start the installation now? (Yy/Nn): " yn
    case $yn in
        [Yy]* )
            echo ":: Installation started."
        break;;
        [Nn]* ) 
            echo ":: Installation canceled."
            exit;
        break;;
        * ) echo ":: Please answer yes or no.";;
    esac
done


}

#######################################################################################################################

export DEBUG="false"

#######################################################################################################################

script_dir=$(pwd)
vars=$script_dir/vars.sh
source $vars

#######################################################################################################################

parse_options "$@" || exit $?
check_distro_support $supported_distro || exit $?
show_pretty_messsage || exit $?
prompt_install 

#######################################################################################################################

create_file $installed_pkg_logs

#######################################################################################################################

detect_previous_install $dotfiles_install_path || exit $?

#######################################################################################################################

auth "Please provide root privileges to install packages"
install_packages $packages
drop_root_privileges

#######################################################################################################################

# Copy required files




