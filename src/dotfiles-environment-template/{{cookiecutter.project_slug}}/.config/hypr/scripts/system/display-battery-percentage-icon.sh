#!/bin/bash

# Look for any directory under /sys/class/power_supply where type == Battery
BATTERY_PATH=$(grep -l "Battery" /sys/class/power_supply/*/type | sed 's|/type||' | head -n 1)

# Fallback if no battery is found
if [ -z "$BATTERY_PATH" ]; then
  echo '{"text": "⚠", "class": "no-battery", "tooltip": "No battery found"}'
  exit 1
fi

# Read capacity
CHARGE=$(cat "$BATTERY_PATH/capacity")

# Choose class
if [ "$CHARGE" -ge 95 ]; then
  CLASS="battery-100"
elif [ "$CHARGE" -ge 65 ]; then
  CLASS="battery-75"
elif [ "$CHARGE" -ge 35 ]; then
  CLASS="battery-50"
elif [ "$CHARGE" -ge 15 ]; then
  CLASS="battery-25"
else
  CLASS="battery-0"
fi

# Output JSON
echo "{\"text\": \".\", \"class\": \"$CLASS\"}"
