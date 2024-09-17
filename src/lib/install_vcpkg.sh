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

    if [[ "$ENABLE_DEBUG" == "true" ]];then
        echo -e "${COLOR_BLUE}"
        git clone "$VCPKG_REPO" "$VCPKG_INSTALL_DIR"
        echo -e "${COLOR_NONE}"
    else
        git clone "$VCPKG_REPO" "$VCPKG_INSTALL_DIR" > /dev/null 2>&1
    fi


        
    print_debug "Bootstrapping vcpkg..." -t "debug"
    cd "$VCPKG_INSTALL_DIR" || exit 1

    if [[ "$ENABLE_DEBUG" == "true" ]];then
        echo -e "${COLOR_BLUE}"
        ./bootstrap-vcpkg.sh -disableMetrics
        echo -e "${COLOR_NONE}"
    else
        ./bootstrap-vcpkg.sh -disableMetrics > /dev/null 2>&1
    fi

    print_debug "Finished installing vcpkg..." -t "debug"
}
