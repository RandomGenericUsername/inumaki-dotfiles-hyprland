#!/bin/bash


VENV_MANAGER__INSTALL_PATH="$ENV_DIR/virtual-env"
cd "$ENV_DIR"
mkdir -p "$VENV_MANAGER__INSTALL_PATH"
git clone https://github.com/RandomGenericUsername/venv.git
./venv install "$VENV_MANAGER__INSTALL_PATH
rm -rf "$ENV_DIR/venv"