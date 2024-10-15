export print_debug="$TEMP_DEPENDENCIES_INSTALL_PATH/$PRINT_DEBUG_UTILITY_REPO_NAME/$PRINT_DEBUG_UTILITY_BIN_NAME"


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