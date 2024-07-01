
setup(){
    print "Seting up the installer..." -t "debug" -l "$LOG"
    install_pacman_packages $PREREQUISITES
    print "Finished setup" -t "debug" -l "$LOG"
}
