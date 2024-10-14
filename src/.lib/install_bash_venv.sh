install_bash_venv(){
    if [[ "$ENABLE_DEBUG" == "true" ]]; then
        "$VENV_CLI_UTILITY" check "$BASH_VENV" 
    else
        "$VENV_CLI_UTILITY" check "$BASH_VENV" > /dev/null 2>&1
    fi
    local is_installed=$?
    if [[ $is_installed -ne 0 ]];then
        "$VENV_CLI_UTILITY" install "$BASH_VENV"
    fi
}