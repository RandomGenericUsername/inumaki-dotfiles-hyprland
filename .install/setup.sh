
setup(){
    print "Seting up the installer..." "debug" "$log"
    install_pacman_packages $prerequisites
    print "Finished setup" "debug" "$log"
}
