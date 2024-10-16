


# This is where pyenv will be installed.
export PYENV_INSTALL_PATH="$DOTFILES_INSTALL_PATH/.pyenv"
# Path to pyenv bin
export PYENV="$PYENV_INSTALL_PATH/bin/pyenv"

# This is the path to the installed python version
export PYTHON="$PYENV_INSTALL_PATH/versions/$PYTHON_VERSION/bin/python"


# Ignore these files/folders from being backed up if found in the installation path. Add more if required.
export IGNORE_FROM_BACKUP=(".dependencies" "dotfiles")


#######################################################################################
################################## First level directories ##################################

# Dotfiles install dir is structured as:
#   .
#   ├── .dependencies -> This directory contains tools, binaries, utilities, scripts, etc required for running functionatilites. 
#   ├── dotfiles -> This directory contains all the hypr directories.

# Dotfiles installation directory
#export DOTFILES_INSTALL_PATH;DOTFILES_INSTALL_PATH="$INSTALL_PATH/dotfiles"
## Dependencies installation directory
#export DEPENDENCIES_INSTALL_PATH;DEPENDENCIES_INSTALL_PATH="$INSTALL_PATH/.dependencies"
## Temporal dotfiles installation directory
#export TEMP_DOTFILES_INSTALL_PATH;TEMP_DOTFILES_INSTALL_PATH="$TEMP_INSTALL_PATH/dotfiles"
## Temportal dependencies installation directory
#export TEMP_DEPENDENCIES_INSTALL_PATH;TEMP_DEPENDENCIES_INSTALL_PATH="$TEMP_INSTALL_PATH/.dependencies"
#######################################################################################
################################## Dotfiles first level directories ##################################
# Path to vcpkg installation
export VCPKG_INSTALL_DIR="$DEPENDENCIES_INSTALL_PATH/vcpkg"

# Path to python venv 
export PYTHON_VENV="$DEPENDENCIES_INSTALL_PATH/python_venv"

# Path to bash venv
export BASH_VENV="$DEPENDENCIES_INSTALL_PATH/bash_venv"

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

export ROFI_CURRENT_WALLPAPER_RASI="$ROFI_DIR/current-wallpaper.rasi"
export DEFAULT_WALLPAPER_PATH="$WALLPAPERS_DIR/default.png"
export HYPRPAPER_CONFIG_TEMPLATE="$WALLPAPER_SETTINGS_DIR/hyprpaper.conf.tpl"
export WAL_COLORS_WAYBAR_FILE="$WAL_CACHE_DIR/colors-waybar.css"
export WALLPAPER_SELECTOR_SCRIPTS_DIR="$HYPR_SCRIPTS_DIR/wallpaper_selector"


# This is the user's cache directory. Needed for pywal and other tools.
#export HOST_CACHE_DIR="$HOME/.cache"
#export HOST_WALLPAPERS_DIR; HOST_WALLPAPERS_DIR="$WALLPAPERS_DIRECTORY"