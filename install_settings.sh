########################### Parameters that can be edited ###########################

# Set to true hide the install directory
HIDDEN_INSTALL="true"
# Path to installation logs
LOG="/tmp/logs/install.log"


#######################################################################################
################################## Host directories ##################################

# These directories will be symlinked from Host to the $ENV_DIR
export HOST_WALLPAPERS_DIR="$HOME/wallpapers"

# 
export HOST_CACHE_DIR="$HOME/.cache"

#######################################################################################
################################## Set the name for dotfiles install dir ##################################

# Need to export the variable 'ENV_HIDDEN' before sourcing this file.
export DOTFILES_NAME_RAW="inumaki-dotfiles"
# This is to allow creating the directory as hidden
export DOTFILES_NAME="$([ "$HIDDEN_INSTALL" = true ] && echo "." || echo "")$DOTFILES_NAME_RAW"
# This is where all will be installed
export DOTFILES_INSTALL_PATH="$HOME/$DOTFILES_NAME"

#######################################################################################
################################## Dotfiles first level directories ##################################

# Path to cache dir
export CACHE_DIR="$DOTFILES_INSTALL_PATH/.cache"

# Config dir
export CONFIG_DIR="$DOTFILES_INSTALL_PATH/.config"

# Settings dir
export SETTINGS_DIR="$DOTFILES_INSTALL_PATH/.settings"

# Wallpaper dir
export WALLPAPERS_DIR="$DOTFILES_INSTALL_PATH/wallpapers"


#######################################################################################
################################## Dotfiles .config ##################################

# Hypr dir
export HYPR_DIR="$CONFIG_DIR/hypr"

# Rofi dir
export ROFI_DIR="$CONFIG_DIR/rofi"

#######################################################################################
################################## Dotfiles wallpaper settings ##################################

# Wallpaper settings dir
export WALLPAPER_SETTINGS_DIR="$SETTINGS_DIR/wallpaper"

#######################################################################################
################################## Dotfiles hypr ##################################

export HYPR_SCRIPTS_DIR="$HYPR_DIR/scripts"
export HYPR_EFFECTS_DIR="$HYPR_DIR/effects"
export HYPR_WALLPAPER_EFFECTS_DIR="$HYPR_EFFECTS_DIR/wallpapers"

#######################################################################################
################################## Dotfiles wal ##################################

# Cache
export WAL_CACHE_DIR="$CACHE_DIR/wal"

#######################################################################################
################################## Dotfiles tools ##################################

# Path to vcpkg installation
export VCPKG_INSTALL_DIR="$DOTFILES_INSTALL_PATH/.vcpkg"

# Path to python venv 
export PYTHON_VENV="$DOTFILES_INSTALL_PATH/.python_venv"

# Path to bash venv
export BASH_VENV="$DOTFILES_INSTALL_PATH/.bash_venv"

# The following 3 are used to check if the utils exists
# Path to utils dirs
export UTILS_INSTALL_DIR="$DOTFILES_INSTALL_PATH/utils"
# Path to Print debug util
export PRINT_DEBUG_UTILITY="$UTILS_INSTALL_DIR/Print debug/print-debug"
# Path to Argument parser util
export ARGUMENT_PARSER_UTILITY="$UTILS_INSTALL_DIR/Argument parser/argument-parser"
# Path to bash venv util
export VENV_CLI_UTILITY="$UTILS_INSTALL_DIR/Virtual environment CLI/venv"

#######################################################################################
################################## Tools' repos ##################################

# Directory to download utilities like debug-print, arg parser, etc.
# Check https://github.com/RandomGenericUsername/bash-utils
export UTILS_REPO_URL="https://github.com/RandomGenericUsername/bash-utils"
export VCPKG_REPO="https://github.com/microsoft/vcpkg.git"

#######################################################################################
################################## Bash venv vars ##################################


export ROFI_SELECTED_WALLPAPER_VAR="selected_wallpaper"
export ROFI_CURRENT_WALLPAPER_VAR="current_wallpaper"
export ROFI_SELECTED_WALLPAPER_EFFECT_VAR="selected_wallpaper_effect"
export ROFI_CURRENT_WALLPAPER_EFFECT_VAR="current_wallpaper_effect"
export CUSTOM_WALLPAPER_DIR_VAR="custom_wallpaper_dir"
export WALLPAPER_BLUR_VAR="wallpaper_blur"


#######################################################################################
################################## Cookiecutter settings ##################################

# It is required to set a slug ("name"(?)) for cookiecutter
export project_slug="$DOTFILES_NAME"
# Since this file will be used to generate the template for cookiecutter, it is required to ignore
# directories, files, or lines of code containing characters conflicting with the way in which jinja2
# and that kind of stuff uses to expand the template.
export _copy_without_render=(
    #".settings/*"
    #".cache/*"
    #".zshrc"
    #".bashrc"
    #".config/hypr/conf/*"
    #".config/hypr/effects/*"
    ".config/wal/templates/*" # wal templates 
    #".config/waybar"
    #".config/waypaper"

)

# A reference to this file is required to let cookiecutter json generator know about it
INSTALL_SETTINGS="$(pwd)/install_settings.sh"
# Path to the directory containing the cookiecutter template
DOTFILES_VENV_TEMPLATE_DIR="$(pwd)/dotfiles-venv-template"
# Set to change the Node version to install
NODE_VERSION="20.17.0"