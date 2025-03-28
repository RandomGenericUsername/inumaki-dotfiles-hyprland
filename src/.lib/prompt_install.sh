prompt_install(){
    while true; do
        # Output the prompt message and input in the specified color
        printf "%b" "${ERROR_COLOR}" 
        echo -e "This script will install '$DOTFILES_NAME_RAW' at '$INSTALL_PATH'."
        echo -e "Do you want to start the installation now? (Y/n):"
        # Use read -p with the color code, making the input match the prompt color
        read -e -p "> " yn
        printf "%b" "${NO_COLOR}" 
        
        case ${yn:-Y} in
            [Yy]|[Yes]|[yes]* )
                #echo "Installation started."
                return 0
                break;;
            [Nn]|[No]|[no]* ) 
                echo -e "Installation canceled."
                exit
                break;;
            * ) echo -e "${ERROR_COLOR}Please answer yes or no.${NO_COLOR}";;
        esac
    done
}
