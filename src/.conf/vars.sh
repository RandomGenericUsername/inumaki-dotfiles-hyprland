# This is to allow creating the directory as hidden. If `HIDDEN_INSTALL` is `true` then the installation directory will be hidden.
export DOTFILES_NAME;DOTFILES_NAME="$([ "$HIDDEN_INSTALL" = true ] && echo "." || echo "")$DOTFILES_NAME_RAW"
# This is the path where the dotfiles will be installed. 'INSTALLATION_DIRECTORY' comes from settings.
export INSTALL_PATH;INSTALL_PATH="$INSTALLATION_DIRECTORY/$DOTFILES_NAME"
# This is the temporal installation path
export TEMP_INSTALL_PATH;TEMP_INSTALL_PATH="/$TEMP_INSTALL_DIR/$DOTFILES_NAME"
# This is the default path where the config file for the dotfiles installation will be looked up.
export CONFIG_FILE;CONFIG_FILE="$INSTALL_PATH/.config"
# Dotfiles installation directory
export DOTFILES_INSTALL_PATH;DOTFILES_INSTALL_PATH="$INSTALL_PATH/$DOTFILES_DIRNAME"
# Dotfiles temporal installation directory
export TEMP_DOTFILES_INSTALL_PATH;TEMP_DOTFILES_INSTALL_PATH="$TEMP_INSTALL_PATH/$DOTFILES_DIRNAME"
# Path where pyenv will be installed temporarily.
export TEMP_PYENV_INSTALL_PATH="$TEMP_DOTFILES_INSTALL_PATH/.pyenv"
# This is required so other scripts can use this utility using the temporal installation path.
export print_debug="$PRINT_DEBUG_UTILITY_TEMP_PATH"


# Print debug utility repo name
export PRINT_DEBUG_UTILITY_REPO_NAME="Print-debug-CLI"
# Print debug utility bin name
export PRINT_DEBUG_UTILITY_BIN_NAME="print-debug"
# Temporal path for installing print debug utility
export PRINT_DEBUG_UTILITY_TEMP_PATH="$TEMP_DOTFILES_INSTALL_PATH/$PRINT_DEBUG_UTILITY_REPO_NAME/$PRINT_DEBUG_UTILITY_BIN_NAME"

# utilities repositories
export UTILS_REPOS=(
    "https://github.com/RandomGenericUsername/$PRINT_DEBUG_UTILITY_REPO_NAME.git"
)

#"https://github.com/RandomGenericUsername/$ARGUMENT_PARSER_UTILITY_REPO_NAME.git"
#"https://github.com/RandomGenericUsername/$BASH_VENV_CLI_UTILITY_REPO_NAME.git"

# Argument parser utility repo name
#export ARGUMENT_PARSER_UTILITY_REPO_NAME="Bash-scripting-argument-parser"
# Argument parser utility bin name
#export ARGUMENT_PARSER_UTILITY_BIN_NAME="argument-parser"

# Bash venv cli utility repo name 
#export BASH_VENV_CLI_UTILITY_REPO_NAME="Bash-variables-CLI"
# Bash venv cli utility bin name 
#export BASH_VENV_CLI_UTILITY_BIN_NAME="venv"

#export DEFAULT_WALLPAPER_PATH_SRC="$(pwd)/src/assets/default_wallpaper/default.png"
# It is required to set a slug ("name"(?)) for cookiecutter
#export project_slug="$DOTFILES_NAME"
# Since this file will be used to generate the template for cookiecutter, it is required to ignore
# directories, files, or lines of code containing characters conflicting with the way in which jinja2
# and that kind of stuff uses to expand the template.
#export _copy_without_render=(
#    #".settings/*"
#    #".cache/*"
#    #".zshrc"
#    #".bashrc"
#    #".config/hypr/conf/*"
#    #".config/hypr/effects/*"
#    ".config/wal/templates/*" # wal templates 
#    #".config/waybar"
#    #".config/waypaper"
#
#)

# A reference to this file is required to let cookiecutter json generator know about it
#INSTALL_SETTINGS="$(pwd)/.install_settings.sh"
# Path to the directory containing the cookiecutter template
#DOTFILES_VENV_TEMPLATE_DIR="$(pwd)/dotfiles-venv-template"
# Set to change the Node version to install
#NODE_VERSION="20.17.0"

#ASSETS="$(pwd)/src/assets"


#
#export VCPKG_REPO="https://github.com/microsoft/vcpkg.git"

