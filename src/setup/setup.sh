
setup(){

    # Prompt for starting the installation
    prompt_install
 
    # Download utilities: venv, argument parser, print debug, etc.
    # https://github.com/RandomGenericUsername/Print-debug-CLI.git
    # https://github.com/RandomGenericUsername/Bash-scripting-argument-parser.git
    # https://github.com/RandomGenericUsername/Bash-variables-CLI.git
    download_utils 
    # If logging is enable, create the file for it
    create_log

    # Check for previous installation
    check_previous_installation "$DOTFILES_INSTALL_PATH" || exit $?
    
    if [[ "$ENABLE_DEBUG" == "true" ]];then
        echo -e "${COLOR_BLUE}[DEBUG]: [Running setup script]${COLOR_NONE}"
    else 
        echo "Setup is running in the background. You can continue using the shell."
    fi

    # Install vcpkg -> required for installing date.h 
    install_vcpkg

    # Install required packages for begining installation process
    install_pacman_packages "$PREREQUISITES"

    exit 0
    # Setup the python venv
    create_python_venv "$PYTHON_VENV"

    # Install the required packages into the python venv
    install_packages_in_venv "$PYTHON_PIP_DEPS" "$PYTHON_VENV"

    print_debug "Finished setup successfuly"

    return 0
}
