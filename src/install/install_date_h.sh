#!/bin/bash

install_date_h() {
    # Check if vcpkg is already installed
    if [ -d "$VCPKG_INSTALL_DIR" ] && [ -f "$VCPKG_INSTALL_DIR/vcpkg" ]; then
        print "vcpkg is already installed at $VCPKG_INSTALL_DIR" -t "debug" -l "$LOG"
    else
        print "Cloning vcpkg repository..." -t "debug" -l "$LOG"
        git clone https://github.com/microsoft/vcpkg.git "$VCPKG_INSTALL_DIR"
        
        prit "Bootstrapping vcpkg..." -t "debug" -l "$LOG"
        cd "$VCPKG_INSTALL_DIR" || exit 1
        ./bootstrap-vcpkg.sh
    fi
    # Install date.h using vcpkg
    print "Installing date.h using vcpkg..." -t "debug" -l "$LOG"
    "$VCPKG_INSTALL_DIR/vcpkg" install date
    
    # Add vcpkg to PATH (if not already added)
    #if ! grep -q "VCPKG_ROOT" "$ENV_DIR/.bashrc"; then
    #    print "Adding vcpkg to PATH..." -t "info" -l "$LOG"
    #    #echo 'export PATH=$PATH:'"$VCPKG_INSTALL_DIR" >> "$ENV_DIR/.bashrc"
    #    #echo 'export VCPKG_ROOT='"$VCPKG_INSTALL_DIR" >> "$ENV_DIR/.bashrc"
    #    #source "$ENV_DIR/.bashrc"
    #fi
}