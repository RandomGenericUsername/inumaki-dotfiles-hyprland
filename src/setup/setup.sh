
setup(){
    echo "fails here"
    print "Seting up the installer..." "debug" "$LOG"
    install_pacman_packages $prerequisites
    print "Finished setup" "debug" "$log"
}
