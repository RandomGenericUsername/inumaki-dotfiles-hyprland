########################### Parameters that can be edited ###########################
HIDDEN_INSTALL=true



########################### Dont modify this!!! ###########################

# Set the environment name prefix properly to be hidden or not.
# Need to export the variable 'ENV_HIDDEN' before sourcing this file.
export DOTFILES_NAME_RAW="inumaki-dotfiles"
export DOTFILES_NAME="$([ "$HIDDEN_INSTALL" = true ] && echo "." || echo "")${DOTFILES_NAME_RAW}"
export DOTFILES_INSTALL_PATH="$HOME/$DOTFILES_NAME"

export VCPKG_INSTALL_DIR="$DOTFILES_INSTALL_PATH/.vcpkg"

export PYTHON_VENV="$DOTFILES_INSTALL_PATH/.python_venv"

export LOG="$DOTFILES_INSTALL_PATH/logs/install.log"


export VCPKG_REPO="https://github.com/microsoft/vcpkg.git"

# Directory to download utilities like debug-print, arg parser, etc.
# Check https://github.com/RandomGenericUsername/bash-utils
export UTILS_REPO_URL="https://github.com/RandomGenericUsername/bash-utils"
export UTILS_INSTALL_DIR="$DOTFILES_INSTALL_PATH/utils"
# Used to check if the utils exists
export PRINT_DEBUG_UTILITY="$UTILS_INSTALL_DIR/Print debug/print-debug"
export ARGUMENT_PARSER_UTILITY="$UTILS_INSTALL_DIR/Argument parser/argument-parser"
export VENV_CLI_UTILITY="$UTILS_INSTALL_DIR/Virtual environment CLI/venv"


#