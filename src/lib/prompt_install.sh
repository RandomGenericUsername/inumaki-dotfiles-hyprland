prompt_install(){
    while true; do
        # Output the prompt message and input in the specified color
        echo -e "${ERROR_COLOR}Do you want to start the installation now? (Yy/Nn):${NO_COLOR}"
        
        # Use read -p with the color code, making the input match the prompt color
        read -p "$(echo -e $ERROR_COLOR)" yn 
        
        # Reset color after input is received
        echo -e "${NO_COLOR}"

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
