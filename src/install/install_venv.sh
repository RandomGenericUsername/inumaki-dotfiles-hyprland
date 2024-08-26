#!/bin/bash

install_venv(){
    print "Installing venv manager..." -t "debug" -l "$LOG"
    if [[ ! -f "$VENV_SRC_DIR" ]] && ! command -v "$VENV_MANAGER" > /dev/null 2>&1 ; then
        git clone https://github.com/RandomGenericUsername/venv.git "$VENV_SRC_DIR"
    fi

    $VENV_MANAGER check "$VENV_DIR/config.sh"
    is_venv_installed=$?
    if [[ $is_venv_installed -eq 0 ]]; then
        print "Venv manager is alredy installed" -t "info" -l "$LOG"
        exit 0
    fi
    exit 0

    $VENV_MANAGER install "$VENV_DIR"
    $VENV_MANAGER check "$VENV_DIR/config.sh"
    is_venv_installed=$?
    return $is_venv_installed
}