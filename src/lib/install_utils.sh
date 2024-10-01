download_utils() {
    # Check if the dependencies install path exists
    if [[ -d "$DEPENDENCIES_INSTALL_PATH" ]]; then
        missing_utilities=()
        [[ ! -f "$PRINT_DEBUG_UTILITY" ]] && missing_utilities+=("$(basename "$PRINT_DEBUG_UTILITY")")
        [[ ! -f "$ARGUMENT_PARSER_UTILITY" ]] && missing_utilities+=("$(basename "$ARGUMENT_PARSER_UTILITY")")
        [[ ! -f "$BASH_VENV_CLI_UTILITY" ]] && missing_utilities+=("$(basename "$VENV_CLI_UTILITY")")
        
        if [[ ${#missing_utilities[@]} -eq 0 ]]; then
            [[ "$ENABLE_DEBUG" == "true" ]] && echo -e "${COLOR_BLUE}[DEBUG]: [All utils are already installed]${COLOR_NONE}"
            return 0
        else
            [[ "$ENABLE_DEBUG" == "true" ]] && echo -e "${COLOR_BLUE}[DEBUG]: [Missing utilities ${missing_utilities[*]}]${COLOR_NONE}"
            [[ "$ENABLE_DEBUG" == "true" ]] && echo -e "${COLOR_BLUE}[DEBUG]: [Reinstalling...]${COLOR_NONE}"
            rm -rf "$DEPENDENCIES_INSTALL_PATH"
        fi
    fi

    [[ "$ENABLE_DEBUG" == "true" ]] && echo -e "${COLOR_BLUE}[DEBUG]: [Installing utils at $DEPENDENCIES_INSTALL_PATH]${COLOR_NONE}"

    if [[ "$ENABLE_DEBUG" == "true" ]];then
        echo -e "${COLOR_BLUE}"
        git clone "$PRINT_DEBUG_UTILITY_REPO" "$PRINT_DEBUG_UTILITY_PATH"
        git clone "$ARGUMENT_PARSER_UTILITY_REPO" "$ARGUMENT_PARSER_UTILITY_PATH" 
        git clone "$BASH_VENV_CLI_UTILITY_REPO" "$BASH_VENV_CLI_UTILITY_PATH"
        echo -e "${COLOR_NONE}"
    else
        git clone "$PRINT_DEBUG_UTILITY_REPO" "$PRINT_DEBUG_UTILITY_PATH" > /dev/null 2>&1
        git clone "$ARGUMENT_PARSER_UTILITY_REPO" "$ARGUMENT_PARSER_UTILITY_PATH" > /dev/null 2>&1 
        git clone "$BASH_VENV_CLI_UTILITY_REPO" "$BASH_VENV_CLI_UTILITY_PATH" > /dev/null 2>&1

    fi
}
