# Default installation type. 
export INSTALL_TYPE="update"

# Name for the installation directory
export INSTALLATION_DIRNAME="inumaki-dotfiles"

# Name for dotfiles directory
export DOTFILES_DIRNAME="dotfiles"

# This is to allow creating the directory as hidden. If `HIDDEN_INSTALL` is `true` then the installation directory will be hidden.
INSTALLATION_DIRNAME_HIDDEN_PATH="$([ "$HIDDEN_INSTALL" = true ] && echo "." || echo "")$INSTALLATION_DIRNAME"
export INSTALLATION_DIRNAME_HIDDEN_PATH

# This is the path where the dotfiles will be installed. 'INSTALLATION_DIRECTORY' comes from settings.
export INSTALL_PATH="$INSTALLATION_DIRECTORY/$INSTALLATION_DIRNAME_HIDDEN_PATH"

# Dotfiles installation directory
export DOTFILES_INSTALL_PATH="$INSTALL_PATH/$DOTFILES_DIRNAME"

# This is the default path where the config file for the dotfiles installation will be looked up.
export CONFIG_FILE="$INSTALL_PATH/.config"

# It is required to set a slug ("name"(?)) for cookiecutter
export project_slug="$DOTFILES_DIRNAME"

# Ignore these files/folders from being backed up if found in the installation path. Add more if required.
export IGNORE_FROM_BACKUP=("environment_variables.sh" "$DOTFILES_DIRNAME")


# Since this file will be used to generate the template for cookiecutter, it is required to ignore
# directories, files, or lines of code containing characters conflicting with the way in which jinja2
# and that kind of stuff uses to expand the template.
export _copy_without_render=(
    "dummy"
    #".config/*"
    #".zshrc"
    #".cache/*"
    #".zshrc"
    #".bashrc"
    #".config/hypr/conf/*"
    #".config/hypr/effects/*"
    #".config/wal/templates/*" # wal templates 
    #".config/waybar"
    #".config/waypaper"
)

# Python version to install via pyenv. see `pyenv install --list`
export PYTHON_VERSION="3.10.4"
 
# Node version to install
export NODEJS_VERSION="20.9.0"
