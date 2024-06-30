
setup(){
    print "Seting up the installer..." "debug" "$log"
    install_pacman_packages $prerequisites
    sudo pacman -Sy python-cookiecutter
    print "Finished setup" "debug" "$log"
}
