# [ THESE VARIABLES NEED TO BE EXPORTED IN ORDER TO BE TRANSLATED INTO A CONFIG FILE REQUIRED BY COOKIECUTTER. ]
# [ THOSE NOT EXPORTED WON'T BE TRANSLATED ]

########################### Parameters that can be edited but are required for translating ###########################
########################### These can be found in 'settings' file ###########################

source "$(pwd)/settings" # Source the settings file
source "$(pwd)/.dotfiles-environment-definitions" # Source the settings file
source "$(pwd)/.dotfiles-dependencies-definitions" # Source the settings file

#######################################################################################

################################## Host directories ##################################

# This is the user's wallpaper directory. Needed to load wallpapers in the wallpaper selector.
#export HOST_WALLPAPERS_DIR="$HOME/wallpapers"
export HOST_WALLPAPERS_DIR; HOST_WALLPAPERS_DIR="$WALLPAPERS_DIRECTORY"

# This is the user's cache directory. Needed for pywal and other tools.
export HOST_CACHE_DIR="$HOME/.cache"

#######################################################################################
################################## Set the name for dotfiles install dir ##################################

# Ignore these files/folders from being backed up if found in the installation path. Add more if required.
export IGNORE_FROM_BACKUP=(".dependencies" "dotfiles")

## Name of the dotfiles, i.e. the name of the directory where it will be installed.
#export DOTFILES_NAME_RAW="inumaki-dotfiles"
## This is to allow creating the directory as hidden. If `HIDDEN_INSTALL` is `true` then the installation directory will be hidden.
#export DOTFILES_NAME="$([ "$HIDDEN_INSTALL" = true ] && echo "." || echo "")$DOTFILES_NAME_RAW"
## This is the path where the dotfiles will be installed. 
#export INSTALL_PATH="$INSTALLATION_DIRECTORY/$DOTFILES_NAME"
## This is the temporal installation path
#export TEMP_INSTALL_PATH="/tmp/$DOTFILES_NAME"
## This is the default path where the config file for the dotfiles installation will be looked up.
#export CONFIG_FILE="$INSTALL_PATH/.config"

#######################################################################################
################################## First level directories ##################################

# Dotfiles install dir is structured as:
#   .
#   ├── .dependencies -> This directory contains tools, binaries, utilities, scripts, etc required for running functionatilites. 
#   ├── dotfiles -> This directory contains all the hypr directories.

# Dotfiles installation directory
#export DOTFILES_INSTALL_PATH="$INSTALL_PATH/dotfiles"
## Dependencies installation directory
#export DEPENDENCIES_INSTALL_PATH="$INSTALL_PATH/.dependencies"
## Temporal dotfiles installation directory
#export TEMP_DOTFILES_INSTALL_PATH="$TEMP_INSTALL_PATH/dotfiles"
## Temportal dependencies installation directory
#export TEMP_DEPENDENCIES_INSTALL_PATH="$TEMP_INSTALL_PATH/.dependencies"
## Ignore these files/folders from being backed up if found in the installation path.
## Add more if required.
#export IGNORE_FROM_BACKUP=(".dependencies" "dotfiles")

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