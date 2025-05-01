#!/bin/bash
profile=$(powerprofilesctl get)

case "$profile" in
  power-saver) icon="🛋️" ;;
  balanced) icon="⚖️" ;;
  performance) icon="🚀" ;;
esac

# This returns JSON for Waybar
echo "{\"text\": \"\", \"tooltip\": \"$icon $profile\"}"
