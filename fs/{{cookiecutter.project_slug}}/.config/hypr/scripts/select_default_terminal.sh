#!/bin/bash

# Global variable for the path to the configuration file
#CONFIG_FILE_PATH="$HOME/dotfiles/inumaki-dotfiles-hyprland .config/hyprland/terminal.sh"
#/home/inumaki/dotfiles//dotfiles/hypr/scripts

# List of terminal options
terminals=("zsh" "alacritty" "kitty" "foot")

# Use rofi to select a terminal
selected_terminal=$(printf "%s\n" "${terminals[@]}" | rofi -dmenu -p "Select default terminal:")

# Function to write the selected terminal to the configuration file
set_default_terminal() {
  local terminal_command
  case "$selected_terminal" in
    "zsh")
      terminal_command="zsh"
      ;;
    "alacritty")
      terminal_command="alacritty"
      ;;
    "kitty")
      terminal_command="kitty"
      ;;
    "foot")
      terminal_command="foot"
      ;;
    *)
      echo "Unsupported terminal: $selected_terminal"
      exit 1
      ;;
  esac

  # Write the terminal command to the configuration file
  echo "export TERMINAL=$terminal_command" > "$CONFIG_FILE_PATH"

  echo "Default terminal set to $selected_terminal"
}

# Check if a terminal was selected
if [ -n "$selected_terminal" ]; then
  set_default_terminal
else
  echo "No terminal selected."
fi
