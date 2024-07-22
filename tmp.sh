# Define whether the environment directory should be hidden
ENV_HIDDEN=false

export ENV_NAME_RAW="inumaki-dotfiles-env"
ENV_NAME_PREFIX="$([ "$ENV_HIDDEN" = true ] && echo "." || echo "")"
export ENV_NAME="${ENV_NAME_PREFIX}${ENV_NAME_RAW}"

# Set the installation path and directory
export ENV_INSTALL_PATH="$HOME"
export ENV_DIR="$ENV_INSTALL_PATH/$ENV_NAME"

echo "ENV_DIR=$ENV_DIR"