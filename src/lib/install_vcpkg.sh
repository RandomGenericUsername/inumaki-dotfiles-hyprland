install_vcpkg(){
    # Check if vcpkg is already installed
    if [ -d "$VCPKG_INSTALL_DIR" ];then
        if [ -f "$VCPKG_INSTALL_DIR/vcpkg" ]; then
            print_debug "vcpkg is already installed at $VCPKG_INSTALL_DIR" -t "debug"
            return 0
        fi
        rm -rf "$VCPKG_INSTALL_DIR"
    fi
    print_debug "Cloning vcpkg repository... on $VCPKG_INSTALL_DIR" -t "debug"
    git clone https://github.com/microsoft/vcpkg.git "$VCPKG_INSTALL_DIR"
        
    print_debug "Bootstrapping vcpkg..." -t "debug"
    cd "$VCPKG_INSTALL_DIR" || exit 1
    ./bootstrap-vcpkg.sh -disableMetrics
    print_debug "Finished installing vcpkg..." -t "debug"
}
