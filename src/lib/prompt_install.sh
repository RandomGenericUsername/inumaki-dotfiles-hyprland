prompt_install(){
    while true; do
        # Output the prompt message and input in the specified color
        printf "%b" "${ERROR_COLOR}" 
        #echo -e "${ERROR_COLOR}Do you want to start the installation now? (Yy/Nn):${NO_COLOR}"
        echo -e "Do you want to start the installation now? (Yy/Nn):"
        # Use read -p with the color code, making the input match the prompt color
        read -e -p "> " yn
        printf "%b" "${NO_COLOR}" 
        
        case $yn in
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
