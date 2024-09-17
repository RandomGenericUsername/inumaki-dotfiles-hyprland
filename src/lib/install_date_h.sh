install_date_h(){
    print_debug "Installing date.h using vcpkg..."
    if [[ "$ENABLE_DEBUG" == "true" ]];then
        echo -e "${COLOR_BLUE}"
        "$VCPKG_INSTALL_DIR/vcpkg" install date
        echo -e "${COLOR_NONE}"
    else
        "$VCPKG_INSTALL_DIR/vcpkg" install date > /dev/null 2>&1
    fi
    return $?
}