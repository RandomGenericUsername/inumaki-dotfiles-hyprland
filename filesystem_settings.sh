#!/bin/bash


# Set the environment name prefix properly to be hidden or not.
# Need to export the variable 'ENV_HIDDEN' before sourcing this file.
env_name_prefix="$([ "$ENV_HIDDEN" = true ] && echo "." || echo "")"

###################################### Host symlink ########################################

#These directories will be symlinked from Host to the $ENV_DIR
export HOST_WALLPAPER_DIR="$HOME/wallpapers"
export HOST_CACHE_DIR="$HOME/.cache"

###################################### Define global variables for the setup and installation ########################################

# Installation path variables
export ENV_NAME_RAW="inumaki-dotfiles-env"
export ENV_NAME="${env_name_prefix}${ENV_NAME_RAW}"
export ENV_INSTALL_PATH="$HOME"
export ENV_DIR="$ENV_INSTALL_PATH/$ENV_NAME"

# Installation main directories
#export VCPKG_INSTALL_DIR="$ENV_DIR/.vcpkg"
export VCPKG_INSTALL_DIR="$HOME/.vcpkg"
export CACHE_DIR="$ENV_DIR/.cache"
export CONFIG_DIR="$ENV_DIR/.config"
export SETTINGS_DIR="$ENV_DIR/.settings"
export WALLPAPER_DIR="$ENV_DIR/wallpapers"
export SCRIPTS_DIR="$ENV_DIR/.scripts"

export VENV_DIR="$ENV_DIR/.virtual-env"
export VENV_SRC_DIR="$VENV_DIR/.src"
export VENV_MANAGER="$VENV_SRC_DIR/venv"

# Secondary level directories
export HYPR_DIR="$CONFIG_DIR/hypr"
export WALLPAPER_SETTINGS_DIR="$SETTINGS_DIR/wallpaper"
export ROFI_DIR="$CONFIG_DIR/rofi"
export WAYBAR_DIR="$CONFIG_DIR/waybar"

# Third
export HYPR_SCRIPTS_DIR="$HYPR_DIR/scripts"
export HYPR_EFFECTS_DIR="$HYPR_DIR/effects"
export HYPR_WALLPAPER_EFFECTS_DIR="$HYPR_EFFECTS_DIR/wallpaper"
#export HYPR_EFFECTS_DIR="$HYPR_DIR/effects"
#export HYPR_WALLPAPER_EFFECTS_DIR="$HYPR_EFFECTS_DIR/wallpaper"


# Wallpaper selector variables
export SETTINGS_BLUR_FILE="$WALLPAPER_SETTINGS_DIR/blur.sh"
export SELECTED_WALLPAPER_FILE="$CACHE_DIR/selected-wallpaper"
export CURRENT_WALLPAPER_FILE="$CACHE_DIR/current-wallpaper"
export SELECTED_WALLPAPER_EFFECT_FILE="$CACHE_DIR/selected-wallpaper-effect"
export CURRENT_WALLPAPER_EFFECT_FILE="$WALLPAPER_SETTINGS_DIR/wallpaper-effect.sh"
export WAL_CACHE_DIR="$CACHE_DIR/wal"
export WAL_COLORS_FILE="$WAL_CACHE_DIR/colors.sh"
export WAL_COLORS_WAYBAR_FILE="$WAL_CACHE_DIR/colors-waybar.css"
export CUSTOM_WALLPAPER_DIR_FILE="$WALLPAPER_SETTINGS_DIR/wallpaper-dir.sh"
#export WALLPAPER_EFFECT_SETTINGS_FILE="$WALLPAPER_SETTINGS_DIR/wallpaper-effect.sh"
export GENERATED_WALLPAPER_DIR="$CACHE_DIR/generated_wallpaper"

# Rofi configurations/variables
export ROFI_CONFIG_WALLPAPER="$ROFI_DIR/wallpapers-and-effects-mode.rasi"
export ROFI_CURRENT_WALLPAPER_RASI="$CACHE_DIR/current-wallpaper.rasi"
export COLORS_ROFI_PYWAL="$WAL_CACHE_DIR/colors-rofi-pywal.rasi"
export ROFI_BORDER_RASI="$WALLPAPER_SETTINGS_DIR/rofi-border.rasi"
export ROFI_FONT_RASI="$WALLPAPER_SETTINGS_DIR/rofi-font.rasi"
export ROFI_WALLPAPER_SELECTOR_WINDOW_NAME="Wallpaper"

###################################### YYY ########################################
export WAYBAR_THEMES_DIR="$WAYBAR_DIR/themes"


###################################### YYY ########################################

#export ROFI_CONFIG_THEMES="$ROFI_DIR/config-themes.rasi"


###################################### YYY ########################################
#export HYPRPAPER_CACHE_DIR="$CACHE_DIR/hyprpaper"
#export HYPRPAPER_CACHED_USED_WALLPAPER="$HYPRPAPER_CACHE_DIR/used-wallpaper"
#export HYPRPAPER_CACHED_CURRENT_WALLPAPER="$HYPRPAPER_CACHE_DIR/current-wallpaper"
#export HYPRPAPER_CACHED_BLURRED_WALLPAPER="$HYPRPAPER_CACHE_DIR/blurred_wallpaper.png"
#export HYPRPAPER_CACHED_SQUARE_WALLPAPER="$HYPRPAPER_CACHE_DIR/square_wallpaper.png"
#export HYPRPAPER_CACHED_CURRENT_WALLPAPER_RASI_CONFIG="$HYPRPAPER_CACHE_DIR/current_wallpaper.rasi"
#export HYPRPAPER_CACHED_BLUR_FILE="$SETTINGS_DIR/blur.sh"
#export HYPRPAPER_DEFAULT_SPLASH='false'
#
#export WAL_CACHE_DIR="$CACHE_DIR/wal"
#export WAL_CURRENT_COLORS="$WAL_CACHE_DIR/colors.sh"


###################################### YYY ########################################
#export USER_SETTINGS_DIR="$HOME/$ENV_NAME_RAW"
#export USER_SETTINGS="$HOME/$ENV_NAME_RAW/settings.sh"
###################################### YYY ########################################
# This are the directories that will be copied to the $ENV_INSTALL_PATH
export project_slug="$ENV_NAME"
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