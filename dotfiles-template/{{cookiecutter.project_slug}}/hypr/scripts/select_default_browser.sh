#!/bin/bash

# List of browsers
browsers=("google-chrome" "firefox" "brave" "firedragon")

# Use rofi to select a browser
selected_browser=$(printf "%s\n" "${browsers[@]}" | rofi -dmenu -p "Select default browser:")

# Function to set the default browser
set_default_browser() {
  local browser_desktop
  case "$selected_browser" in
    "google-chrome")
      browser_desktop="google-chrome.desktop"
      ;;
    "firefox")
      browser_desktop="firefox.desktop"
      ;;
    "brave")
      browser_desktop="brave-browser.desktop"
      ;;
    "firedragon")
      browser_desktop="firedragon.desktop"
      ;;
    *)
      echo "Unsupported browser: $selected_browser"
      exit 1
      ;;
  esac

  # Set the default browser for HTTP and HTTPS
  xdg-mime default "$browser_desktop" x-scheme-handler/http
  xdg-mime default "$browser_desktop" x-scheme-handler/https

  echo "Default browser set to $selected_browser"
}

# Check if a browser was selected
if [ -n "$selected_browser" ]; then
  set_default_browser
else
  echo "No browser selected."
fi
