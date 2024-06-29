#!/bin/bash

prompt_existing_installation(){

    print "Do you wish to: " "info" "$log"
    print "Abort [Aa]" "info" "$log"
    print "Overwrite [Oo]" "info" "$log"
    print "Update [Uu]" "info" "$log"
    read -p "" confirmation
    case "$confirmation" in
        [Aa])
            print "Aborted installation" "alert" "$log"
            return 1
            ;;
        [Oo])
            print "Overwriting installation" "alert" "$log"
            return 0
            ;;
        [Uu])
            print "Updating installation" "alert" "$log"
            return 0
            ;;
        *)
            print "Unknown option used: $confirmation." "alert" "$log"
            print "Exiting the installation script now" "alert" "$log"
            exit 1
            ;;
        esac
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
