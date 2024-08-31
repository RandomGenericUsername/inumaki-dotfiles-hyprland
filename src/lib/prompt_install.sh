prompt_install(){
    while true; do
        echo -e "${COLOR_RED}Do you want to start the installation now? (Yy/Nn):${COLOR_NONE}" 
        read -p "" yn
        case $yn in
            [Yy]|[Yes]|[yes]* )
                #echo "Installation started."
                return 0
            break;;
            [Nn]|[No]|[no]* ) 
                echo "Installation canceled."
                exit;
            break;;
            * ) echo -e "${COLOR_RED}Please answer yes or no.${COLOR_NONE}";;
        esac
    done
}