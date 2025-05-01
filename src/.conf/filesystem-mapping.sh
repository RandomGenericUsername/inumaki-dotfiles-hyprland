#!/bin/bash

#
export WALLPAPERS_DIR="$DOTFILES_INSTALL_PATH/wallpapers"

export PRINT_DEBUG_UTIL_PATH="$DOTFILES_INSTALL_PATH/.print-debug"

export ARGUMENT_PARSER_UTIL_PATH="$DOTFILES_INSTALL_PATH/.argument-parser"

export SETTINGS_DIR="$DOTFILES_INSTALL_PATH/.settings"

export CACHE_DIR="$DOTFILES_INSTALL_PATH/.cache"

export CONFIG_DIR="$DOTFILES_INSTALL_PATH/.config"

export OH_MY_ZSH_DIR="$DOTFILES_INSTALL_PATH/.oh-my-zsh"

export NVM_DIR="$DOTFILES_INSTALL_PATH/.nvm"

export PYENV_DIR="$DOTFILES_INSTALL_PATH/.pyenv"

export PYTHON_VENV="$DOTFILES_INSTALL_PATH/.python-$PYTHON_VERSION-venv"

##

# Starship config file
export STARSHIP_CONFIG="$CONFIG_DIR/starship.toml"

export ROFI_DIR="$CONFIG_DIR/rofi"

export HYPR_DIR="$CONFIG_DIR/hypr"

export WAYBAR_DIR="$CONFIG_DIR/waybar"

export WLOGOUT_DIR="$CONFIG_DIR/wlogout"

export GENERATED_WALLPAPERS_WITH_EFFECTS_DIR="$CACHE_DIR/wallpapers-with-effects"

export WALLPAPER_SELECTOR_SETTINGS_DIR="$SETTINGS_DIR/wallpaper-selector"


### 
export HYPR_SCRIPTS_DIR="$HYPR_DIR/scripts"
export HYPR_CONF_DIR="$HYPR_DIR/conf"

export ROFI_SCRIPTS_DIR="$ROFI_DIR/scripts"

export WAYBAR_THEMES_DIR="$WAYBAR_DIR/themes"
export WAYBAR_ASSETS_DIR="$WAYBAR_DIR/assets"

####

export WAYBAR_DEFAULT_THEME_DIR="$WAYBAR_THEMES_DIR/default"
export WAYBAR_HYPRLAND_DEFAULT_THEME_DIR="$WAYBAR_THEMES_DIR/hyprland-default"

export WALLPAPER_SELECTOR_SCRIPTS_DIR="$HYPR_SCRIPTS_DIR/wallpaper-selector"
export SYSTEM_SCRIPTS_DIR="$HYPR_SCRIPTS_DIR/system"  
export WAYBAR_SCRIPTS_DIR="$HYPR_SCRIPTS_DIR/waybar"
export WLOGOUT_SCRIPTS_DIR="$HYPR_SCRIPTS_DIR/wlogout"

export CREATE_WLOGOUT_STYLESHEET_SCRIPT="$WLOGOUT_SCRIPTS_DIR/create-wlogout-stylesheet.sh"


#####
export WALLPAPER_EFFECTS_DIR="$WALLPAPER_SELECTOR_SCRIPTS_DIR/effects"


# ======== #
export WAYBAR_MODULES="$WAYBAR_DIR/modules.json"

export DISPLAY_BATTERY_PERCENTAGE_SCRIPT="$SYSTEM_SCRIPTS_DIR/display-battery-percentage.sh"
export DISPLAY_BATTERY_PERCENTAGE_ICON_SCRIPT="$SYSTEM_SCRIPTS_DIR/display-battery-percentage-icon.sh"


export SHOW_WAYBAR_THEMES_SELECTOR_SCRIPT="$ROFI_SCRIPTS_DIR/show-waybar-themes.sh"
export SHOW_WALLPAPER_SELECTOR_SCRIPT="$ROFI_SCRIPTS_DIR/show-wallpapers.sh"
export SHOW_WALLPAPER_EFFECTS_SELECTOR_SCRIPT="$ROFI_SCRIPTS_DIR/show-wallpaper-effects.sh"


export PRINT_DEBUG_UTIL="$PRINT_DEBUG_UTIL_PATH/print-debug"
export ARGUMENT_PARSER_UTIL="$ARGUMENT_PARSER_UTIL_PATH/argument-parser"

export WALLPAPER_SELECTOR_BORDER_CONF="$WALLPAPER_SELECTOR_SETTINGS_DIR/rofi-border.rasi"
export WALLPAPER_SELECTOR_FONT_CONF="$WALLPAPER_SELECTOR_SETTINGS_DIR/rofi-font.rasi"

export VARIABLES_HANDLER_SCRIPT="$SYSTEM_SCRIPTS_DIR/variables-handler.sh"
export UTILS_SCRIPT="$SYSTEM_SCRIPTS_DIR/utils.sh"
export RUN_PROCESS_SCRIPT="$SYSTEM_SCRIPTS_DIR/run_process.sh"


export HYPRLAND_CONFIG="$HYPR_DIR/hyprland.conf"
export HYPRPAPER_CONFIG_TEMPLATE="$HYPR_DIR/hyprpaper.conf.template"
export HYPRPAPER_CONFIG="$HYPR_DIR/hyprpaper.conf"

export CHANGE_WALLPAPER_SCRIPT="$WALLPAPER_SELECTOR_SCRIPTS_DIR/change-wallpaper.sh"
export SET_WALLPAPER_AFTER_REBOOT_SCRIPT="$WALLPAPER_SELECTOR_SCRIPTS_DIR/set-wallpaper-after-reboot.sh"
export ON_SELECTED_WALLPAPER_SCRIPT="$WALLPAPER_SELECTOR_SCRIPTS_DIR/on-selected-wallpaper.sh"
export ON_SELECTED_WALLPAPER_EFFECT_SCRIPT="$WALLPAPER_SELECTOR_SCRIPTS_DIR/on-selected-wallpaper-effect.sh"
export APPLY_PYWAL_PALLETE_SCRIPT="$WALLPAPER_SELECTOR_SCRIPTS_DIR/apply-pywal-pallete.sh"
export CACHE_WALLPAPER_SCRIPT="$WALLPAPER_SELECTOR_SCRIPTS_DIR/cache-wallpaper.sh"
export GENERATE_WALLPAPERS_WITH_EFFECTS_SCRIPT="$WALLPAPER_SELECTOR_SCRIPTS_DIR/generate-wallpapers-with-effects.sh"

export WAYBAR_THEME_SWITCHER_SCRIPT="$WAYBAR_SCRIPTS_DIR/theme-switcher.sh"
export WAYBAR_TOGGLE_SCRIPT="$WAYBAR_SCRIPTS_DIR/toggle.sh"
export WAYBAR_LAUNCH_SCRIPT="$WAYBAR_SCRIPTS_DIR/launch.sh"
export WAYBAR_CREATE_BATTERY_ICON_SCRIPT="$WAYBAR_SCRIPTS_DIR/create-battery-icon.sh"

export GENERATE_WAYBAR_STYLESHEET_SCRIPT="$WAYBAR_SCRIPTS_DIR/create-waybar-stylesheet.sh"


export ROFI_CONFIG_WAYBAR_THEMES_MODE="$ROFI_DIR/waybar-themes-mode.rasi"
export ROFI_CONFIG_WALLPAPERS_AND_EFFECTS_MODE="$ROFI_DIR/wallpapers-and-effects-mode.rasi"
export ROFI_CONFIG_CURRENT_WALLPAPER="$ROFI_DIR/current-wallpaper.rasi"


## Path to venv script
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
#export VCPKG_INSTALL_DIR="$DEPENDENCIES_INSTALL_PATH/vcpkg"


## Path to bash venv
#export BASH_VENV="$DEPENDENCIES_INSTALL_PATH/bash_venv"


## Config dir
#export CONFIG_DIR="$DOTFILES_INSTALL_PATH/.config"

## Settings dir
#export SETTINGS_DIR="$DOTFILES_INSTALL_PATH/.settings"

## Wallpaper dir
##export WALLPAPERS_DIR="$DOTFILES_INSTALL_PATH/wallpapers"

########################################################################################
################################### Dotfiles .cache ##################################

## Re-evaluae this
########################################################################################
################################### Dotfiles .config ##################################

## Hypr dir
#export HYPR_DIR="$CONFIG_DIR/hypr"


## Waybar
#export WAYBAR_DIR="$CONFIG_DIR/waybar"

########################################################################################
################################### Dotfiles wallpaper settings ##################################

## Wallpaper settings dir
#export WALLPAPER_SETTINGS_DIR="$SETTINGS_DIR/wallpaper"

########################################################################################
################################### Dotfiles hypr ##################################

#export HYPR_SCRIPTS_DIR="$HYPR_DIR/scripts"
#export HYPR_EFFECTS_DIR="$HYPR_DIR/effects"
#export HYPR_WALLPAPER_EFFECTS_DIR="$HYPR_EFFECTS_DIR/wallpapers"

########################################################################################
################################### Dotfiles wal ##################################

## Cache
#export WAL_CACHE_DIR="$CACHE_DIR/wal"

########################################################################################
################################### Waybar ##################################

#export WAYBAR_THEMES_DIR="$WAYBAR_DIR/themes"

########################################################################################

#export ROFI_CURRENT_WALLPAPER_RASI="$ROFI_DIR/current-wallpaper.rasi"
#export DEFAULT_WALLPAPER_PATH="$WALLPAPERS_DIR/default.png"
#export HYPRPAPER_CONFIG_TEMPLATE="$WALLPAPER_SETTINGS_DIR/hyprpaper.conf.tpl"
#export WAL_COLORS_WAYBAR_FILE="$WAL_CACHE_DIR/colors-waybar.css"
#export WALLPAPER_SELECTOR_SCRIPTS_DIR="$HYPR_SCRIPTS_DIR/wallpaper_selector"


# This is the user's cache directory. Needed for pywal and other tools.
#export HOST_CACHE_DIR="$HOME/.cache"
#export HOST_WALLPAPERS_DIR; HOST_WALLPAPERS_DIR="$WALLPAPERS_DIRECTORY"