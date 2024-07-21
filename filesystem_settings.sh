#!/bin/bash

export HOST_WALLPAPER_DIR="$HOME/wallpapers"
export HOST_CACHE_DIR="$HOME/.cache"

###################################### Define global variables for the setup and installation ########################################

export ENV_NAME_RAW="inumaki-dotfiles-env"
export ENV_NAME=".$ENV_NAME_RAW"
export ENV_INSTALL_PATH="$HOME"
export ENV_DIR="$ENV_INSTALL_PATH/$ENV_NAME"
export CACHE_DIR="$ENV_DIR/.cache"
export CONFIG_DIR="$ENV_DIR/.config"
export SETTINGS_DIR="$ENV_DIR/.settings"
export WALLPAPER_DIR="$ENV_DIR/wallpapers"


#secondary level
export HYPR_DIR="$CONFIG_DIR/hypr"
export ROFI_DIR="$CONFIG_DIR/rofi"
export WAYBAR_DIR="$CONFIG_DIR/waybar"

# Third
export HYPR_WALLPAPER_EFFECTS_DIR="$HYPR_DIR/effects/wallpaper"

###################################### YYY ########################################



# wallpaper tool variables
export WALLPAPER_SETTINGS_DIR="$SETTINGS_DIR/wallpaper"
export WALLPAPER_EFFECT="$WALLPAPER_SETTINGS_DIR/wallpaper-effect.sh"
export HYPR_WALLPAPER_EFFECTS_DIR="$HYPR_DIR/effects/wallpaper"
export HYPR_SCRIPTS_DIR="$HYPR_DIR/scripts"
export ROFI_CONFIG_THEMES="$ROFI_DIR/config-themes.rasi"
export ROFI_CONFIG_WALLPAPER="$ROFI_DIR/config-wallpaper.rasi"

export WAYBAR_THEMES_DIR="$WAYBAR_DIR/themes"

export ROFI_FONT_RASI="$WALLPAPER_SETTINGS_DIR/rofi-font.rasi"
export WAL_CACHE_DIR="$CACHE_DIR/wal"
export COLORS_ROFI_PYWAL="$WAL_CACHE_DIR/colors-rofi-pywal"
export CURRENT_WALLPAPER_RASI="$CACHE_DIR/current_wallpaper.rasi"
export ROFI_BORDER_RASI="$WALLPAPER_SETTINGS_DIR/rofi-border.rasi"
export ROFI_WALLPAPER_SELECTOR_WINDOW_NAME="wallpaper-selector"

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
    ".settings/*"
    ".config/wal/templates/*" # wal templates 
    ".cache/*"
)