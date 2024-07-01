#!/bin/bash

prompt_existing_installation(){

    local gum_options=("Update" "Overwrite (clean install)" "Abort")
    local msg="Please select how would you like to keep going with the installation:"
    choice=$(gum choose "${gum_options[@]}" --header="$msg")
    case "$choice" in
        "Update")
            INSTALLATION_TYPE="update"
            ;;
        "Overwrite (clean install)")
            INSTALLATION_TYPE="clean"
            ;;
        "Abort")
            print "Installation aborted" "alert" "$log"
            exit 1
            ;;
    esac
    return 0
}

# Function to check for previous installations
check_previous_installation() {

    local install_path="$1"
    dir_exists "$install_path"
    folder_exists=$?
    if [ $folder_exists -eq 1 ]; then
        is_dir_empty "$install_path"
        folder_empty=$?

        if [ $folder_empty -eq 1 ]; then
            print "Previous installation detected in $install_path." "alert" "$log"
            prompt_existing_installation
            return $?
        else
            print "Installation folder exists but is empty." "debug" "$log"
            return 0
        fi
    else
        print "No previous installation found." "debug" "$log"
        return 0
    fi
}

detect_previous_install(){
    local dotfiles_install_path=$1
    # Remove previous installation
    if [ -d $dotfiles_install_path ]; then
        print "Previous installation detected at $dotfiles_install_path" "alert" 
        prompt_existing_installation
        return $?
    fi
    print "No previous installation detected at $dotfies_install_path" debug
    return 0
}
