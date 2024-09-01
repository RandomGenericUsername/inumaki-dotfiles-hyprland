########################### Parameters that can be edited ###########################



########################### Dont modify this!!! ###########################

HIDDEN_INSTALL="true"
NODE_VERSION="20.17.0"

# Set the environment name prefix properly to be hidden or not.
# Need to export the variable 'ENV_HIDDEN' before sourcing this file.
export DOTFILES_NAME_RAW="inumaki-dotfiles"
export DOTFILES_NAME="$([ "$HIDDEN_INSTALL" = true ] && echo "." || echo "")$DOTFILES_NAME_RAW"
export DOTFILES_INSTALL_PATH="$HOME/$DOTFILES_NAME"

export VCPKG_INSTALL_DIR="$DOTFILES_INSTALL_PATH/.vcpkg"

export PYTHON_VENV="$DOTFILES_INSTALL_PATH/.python_venv"

export LOG="$DOTFILES_INSTALL_PATH/logs/install.log"

export BASH_VENV="$DOTFILES_INSTALL_PATH/.bash_venv"

export VCPKG_REPO="https://github.com/microsoft/vcpkg.git"

#These directories will be symlinked from Host to the $ENV_DIR
export HOST_WALLPAPER_DIR="$HOME/wallpapers"

export HOST_CACHE_DIR="$HOME/.cache"

# Directory to download utilities like debug-print, arg parser, etc.
# Check https://github.com/RandomGenericUsername/bash-utils
export UTILS_REPO_URL="https://github.com/RandomGenericUsername/bash-utils"
export UTILS_INSTALL_DIR="$DOTFILES_INSTALL_PATH/utils"
# Used to check if the utils exists
export PRINT_DEBUG_UTILITY="$UTILS_INSTALL_DIR/Print debug/print-debug"
export ARGUMENT_PARSER_UTILITY="$UTILS_INSTALL_DIR/Argument parser/argument-parser"
export VENV_CLI_UTILITY="$UTILS_INSTALL_DIR/Virtual environment CLI/venv"


export _copy_without_render=(
    ".settings/*"
    #".cache/*"
    #".zshrc"
    #".bashrc"
    #".config/hypr/conf/*"
    #".config/hypr/effects/*"
    #".config/wal/templates/*" # wal templates 
    #".config/waybar"
    #".config/waypaper"

)