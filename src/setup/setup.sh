
setup(){

    # Prompt for starting the installation
    prompt_install

    if [[ "$ENABLE_DEBUG" == "true" ]];then
        echo -e "${COLOR_BLUE}[DEBUG]: [ Running setup script ]${COLOR_NONE}"
    else 
        echo "Setup is running in the background. You can continue using the shell."
    fi

    # Download utilities: venv, argument parser, print debug, etc.
    # See https://github.com/RandomGenericUsername/bash-utils
    install_utils 
    # source the print-debug utility
    source "$PRINT_DEBUG_UTILITY"

    # If logging is enable, create the file for it
    create_log

    # Install vcpkg -> required for installing date.h 
    install_vcpkg

    # Install required packages for begining installation process
    install_pacman_packages "$PREREQUISITES"

    # Setup the python venv
    create_python_venv "$PYTHON_VENV"
    # Install the required packages into the python venv
    install_packages_in_venv "$PYTHON_PIP_DEPS" "$PYTHON_VENV"

    print_debug "Finished setup successfuly"

    return 0
}
