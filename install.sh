#!/bin/bash
: '
     __ __     ____           __        ____               __ __
  __/ // /_   /  _/___  _____/ /_____ _/ / /__  _____   __/ // /_
 /_  _  __/   / // __ \/ ___/ __/ __ `/ / / _ \/ ___/  /_  _  __/
/_  _  __/  _/ // / / (__  ) /_/ /_/ / / /  __/ /     /_  _  __/
 /_//_/    /___/_/ /_/____/\__/\__,_/_/_/\___/_/       /_//_/

'
#######################################################################################################################


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

# ================================================================================#
                # Source relevant variables/constants and functions #
# ================================================================================#
this_dir="$(pwd)"
setup_scripts=$this_dir/src/setup/export.sh
lib_scripts=$this_dir/src/.lib/export.sh
install_scripts=$this_dir/src/install/export.sh
installation_settings=$this_dir/installation_settings.sh
source $setup_scripts
source $lib_scripts
source $install_scripts
source $installation_settings
# ================================================================================#

# ================================================================================#
                # Initialize the installation process #
# ================================================================================#
clear
parse_options "$@" || exit $?
pretty_print_installer_msg
create_log
prompt_install 
check_distro_support "$SUPPORTED_DISTRO" || exit $?
setup
gum spin --spinner dot --title "Starting the installation now..." -- sleep 1
check_previous_installation "$ENV_DIR" || exit $?
show_install_type
auth "Please provide root privileges to install packages"
# ================================================================================#

# ================================================================================#
                        # Install the filesystem #
# ================================================================================#
create_dirs "$HOST_WALLPAPER_DIR" "$HOST_CACHE_DIR" 
create_cookiecutter_project -e "$COOKIECUTTER_CONTEXT" -t "$FS" -i "$ENV_INSTALL_PATH"
create_ln "$CACHE_DIR" --source "$HOST_CACHE_DIR" --target "$ENV_DIR"
create_ln "$WALLPAPER_DIR" --source "$HOST_WALLPAPER_DIR" --target "$ENV_DIR"
create_ln "$HOME/.config/wal" --source "$CONFIG_DIR/wal" --target "$HOME/.config"
create_ln "$HOME/.zshrc" --source "$ENV_DIR/.zshrc" --target "$HOME"
# ================================================================================#

# ================================================================================#
                # Install the required packages #
# ================================================================================#
install_pacman_packages "$PACMAN_PKGS"
install_yay 
drop_root_privileges
install_yay_packages "$YAY_PKGS"
install_venv
install_date_h
install_node
install_oh_my_zsh
exit 0
# ================================================================================#

# ================================================================================#
                        # Install the components #
# ================================================================================#
install_wallpaper_selector 
# ================================================================================#


############################################ Set default browser ################################################

#xdg-mime default "$DEFAULT_BROWSER.desktop" x-scheme-handler/http
#xdg-mime default "$DEFAULT_BROWSER.desktop" x-scheme-handler/https

############################################ Print installation is finished ################################################
############################################ Print installation is finished ################################################

print "Installation finished!" -t "info" -l "$LOG"
if [ "$ENABLE_LOG" == "true" ] && [ "$ENABLE_DEBUG" == "true" ]; then
    print "Installation log generated at $LOG" -t "debug" -l "$LOG"
fi

exit 0


#####################################################################################################################################

# List of display managers to check
#display_managers="sddm waybar swaync hyprland hyprpaper wpaperd polkit NetworkManager bolt bluetooth"
#output="$(detect_enabled_services $display_managers)"
#output2="$(detect_running_processes $display_managers)"
#echo "services: $output"
#echo "processes: $output2"

