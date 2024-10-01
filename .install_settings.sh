########################### Parameters that can be edited ###########################

source "$(pwd)/settings.sh"

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
export INSTALL_PATH="$HOME/$DOTFILES_NAME"

#######################################################################################
################################## First level directories ##################################

export DOTFILES_INSTALL_PATH="$INSTALL_PATH/environment"
export DEPENDENCIES_INSTALL_PATH="$INSTALL_PATH/.dependencies"

#######################################################################################
################################## Dependencies first level directories ##################################

# Path to Print debug util
export PRINT_DEBUG_UTILITY_PATH="$DEPENDENCIES_INSTALL_PATH/Print-debug-CLI"
export PRINT_DEBUG_UTILITY="$PRINT_DEBUG_UTILITY_PATH/print-debug"
export PRINT_DEBUG_UTILITY_REPO="https://github.com/RandomGenericUsername/Print-debug-CLI.git"
# Path to Argument parser util
export ARGUMENT_PARSER_UTILITY_PATH="$DEPENDENCIES_INSTALL_PATH/Bash-scripting-argument-parser"
export ARGUMENT_PARSER_UTILITY="$ARGUMENT_PARSER_UTILITY_PATH/argument-parser"
export ARGUMENT_PARSER_UTILITY_REPO="https://github.com/RandomGenericUsername/Bash-scripting-argument-parser.git"

# Path to bash venv util
export BASH_VENV_CLI_UTILITY_PATH="$DEPENDENCIES_INSTALL_PATH/Bash-variables-CLI"
export BASH_VENV_CLI_UTILITY="$BASH_VENV_CLI_UTILITY_PATH/venv"
export BASH_VENV_CLI_UTILITY_REPO="https://github.com/RandomGenericUsername/Bash-variables-CLI.git"

#######################################################################################
################################## Dotfiles tools ##################################

# Path to vcpkg installation
export VCPKG_INSTALL_DIR="$DEPENDENCIES_INSTALL_PATH/vcpkg"

# Path to python venv 
export PYTHON_VENV="$DEPENDENCIES_INSTALL_PATH/python_venv"

# Path to bash venv
export BASH_VENV="$DEPENDENCIES_INSTALL_PATH/bash_venv"

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
################################## Dotfiles .cache ##################################

# Re-evaluae this
export GENERATED_WALLPAPERS_WITH_EFFECTS_DIR="$CACHE_DIR/wallpapers_with_effects"
#######################################################################################
################################## Dotfiles .config ##################################

# Hypr dir
export HYPR_DIR="$CONFIG_DIR/hypr"

# Rofi dir
export ROFI_DIR="$CONFIG_DIR/rofi"

# Waybar
export WAYBAR_DIR="$CONFIG_DIR/waybar"

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
################################## Waybar ##################################

export WAYBAR_THEMES_DIR="$WAYBAR_DIR/themes"

#######################################################################################
################################## Tools' repos ##################################

# Directory to download utilities like debug-print, arg parser, etc.
# Check https://github.com/RandomGenericUsername/bash-utils
export UTILS_REPO_URL="https://github.com/RandomGenericUsername/bash-utils"
export VCPKG_REPO="https://github.com/microsoft/vcpkg.git"

#######################################################################################
################################## Bash venv vars ##################################


export SELECTED_WAYBAR_THEME_VAR="selected_waybar_theme"
export CURRENT_WAYBAR_THEME_VAR="current_waybar_theme"
export ROFI_SELECTED_WALLPAPER_VAR="selected_wallpaper"
export ROFI_CURRENT_WALLPAPER_VAR="current_wallpaper"
export ROFI_CURRENT_WALLPAPER_NAME_VAR="current_wallpaper_name"
export ROFI_SELECTED_WALLPAPER_EFFECT_VAR="selected_wallpaper_effect"
export ROFI_CURRENT_WALLPAPER_EFFECT_VAR="current_wallpaper_effect"
export CUSTOM_WALLPAPER_DIR_VAR="custom_wallpaper_dir"
export WALLPAPER_BLUR_VAR="wallpaper_blur"
export WALLPAPER_BRIGHTNESS_VAR="wallpaper_brightness"
export CACHED_WALLPAPER_EFFECTS_VAR="cached_wallpapers"
export WAYBAR_CURRENT_LAUNCH_COMMAND_VAR="waybar_launch_command"
export WAYBAR_CURRENT_STATUS_VAR="waybar_current_status"


export WALLPAPER_BLUR_DEFAULT_VALUE="50x30"
export WALLPAPER_BRIGHTNESS_DEFAULT_VALUE="20%"
export WAYBAR_DEFAULT_THEME="/default;/default"

export ROFI_WALLPAPER_SELECTOR_WINDOW_NAME="Wallpaper"

#######################################################################################
################################## Resources ##################################
export HYPRPAPER_CONFIG_TEMPLATE="$WALLPAPER_SETTINGS_DIR/hyprpaper.conf.tpl"
export ROFI_CURRENT_WALLPAPER_RASI="$ROFI_DIR/current-wallpaper.rasi"

export DEFAULT_WALLPAPER_PATH="$WALLPAPERS_DIR/default.png"
export DEFAULT_WALLPAPER_PATH_SRC="$(pwd)/src/assets/default_wallpaper/default.png"

export WAL_COLORS_WAYBAR_FILE="$WAL_CACHE_DIR/colors-waybar.css"

#######################################################################################
################################## Script Resources ##################################

# wallpaper selector
export WALLPAPER_SELECTOR_SCRIPTS_DIR="$HYPR_SCRIPTS_DIR/wallpaper_selector"


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
INSTALL_SETTINGS="$(pwd)/.install_settings.sh"
# Path to the directory containing the cookiecutter template
DOTFILES_VENV_TEMPLATE_DIR="$(pwd)/dotfiles-venv-template"
# Set to change the Node version to install
NODE_VERSION="20.17.0"

ASSETS="$(pwd)/src/assets"