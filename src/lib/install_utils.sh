download_utils() {
    if [[ -d "$UTILS_INSTALL_DIR" ]]; then
        missing_utilities=()
        [[ ! -f "$PRINT_DEBUG_UTILITY" ]] && missing_utilities+=("$(basename "$PRINT_DEBUG_UTILITY")")
        [[ ! -f "$ARGUMENT_PARSER_UTILITY" ]] && missing_utilities+=("$(basename "$ARGUMENT_PARSER_UTILITY")")
        [[ ! -f "$VENV_CLI_UTILITY" ]] && missing_utilities+=("$(basename "$VENV_CLI_UTILITY")")
        
        if [[ ${#missing_utilities[@]} -eq 0 ]]; then
            [[ "$ENABLE_DEBUG" == "true" ]] && echo -e "${COLOR_BLUE}[DEBUG]: [ All utils are already installed ]${COLOR_NONE}"
            return 0
        else
            [[ "$ENABLE_DEBUG" == "true" ]] && echo -e "${COLOR_BLUE}[DEBUG]: [ Missing utilities ${missing_utilities[*]} ]${COLOR_NONE}"
            [[ "$ENABLE_DEBUG" == "true" ]] && echo -e "${COLOR_BLUE}[DEBUG]: [ Reinstalling... ]${COLOR_NONE}"
            rm -rf "$UTILS_INSTALL_DIR"
        fi
    fi

    [[ "$ENABLE_DEBUG" == "true" ]] && echo -e "${COLOR_BLUE}[DEBUG]: [ Installing utils at $UTILS_INSTALL_DIR ]${COLOR_NONE}"
    git clone "$UTILS_REPO_URL" "$UTILS_INSTALL_DIR"
}

install_utils(){
    download_utils
}
