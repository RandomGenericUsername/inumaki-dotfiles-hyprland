#!/bin/bash

prompt_existing_installation(){

    print "Do you wish to: " "info"
    print "Abort [Aa]" "info"
    print "Overwrite [Oo]" "info"
    print "Update [Uu]" "info"
    read -p "" confirmation
    case "$confirmation" in
        [Aa])
            print "Aborted installation" "alert"
            return 1
            ;;
        [Oo])
            print "Overwriting installation" "alert"
            return 0
            ;;
        [Uu])
            print "Updating installation" "alert"
            return 0
            ;;
        *)
            print "Unknown option used: $confirmation." "alert"
            print "Exiting the installation script now" "alert"
            exit 1
            ;;
        esac
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
