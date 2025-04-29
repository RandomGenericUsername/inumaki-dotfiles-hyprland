#!/bin/bash

# === CONFIGURATION ===
SVG_INPUT_PATH="$1"        # Path to the SVG input file
SVG_OUTPUT_PATH="$2"       # Path to the SVG output file
COLORS_FILE="$3"           # Path to the colors.sh file
COLOR_LABEL="$4"           # The label to search in colors.sh (e.g., "foreground")
DEFAULT_COLOR="#000000"    # Default color if not found

# === SHOW HELP IF NO PARAMETERS ===
if [[ -z "$SVG_INPUT_PATH" || -z "$SVG_OUTPUT_PATH" || -z "$COLORS_FILE" || -z "$COLOR_LABEL" ]]; then
  echo "Usage: $0 <svg_input> <svg_output> <colors.sh path> <color label>"
  echo ""
  echo "Example:"
  echo "  $0 input.svg output.svg /path/to/colors.sh foreground"
  echo ""
  echo "If colors.sh is missing or the color label is not found, defaults to black (#000000)."
  exit 1
fi

# === VALIDATE COLORS FILE ===
if [[ ! -f "$COLORS_FILE" ]]; then
  echo "Warning: Colors file '$COLORS_FILE' not found. Using default color $DEFAULT_COLOR."
  COLOR_VALUE="$DEFAULT_COLOR"
else
  # === EXTRACT COLOR ===
  COLOR_VALUE=$(grep -E "^$COLOR_LABEL=" "$COLORS_FILE" | cut -d"'" -f2)

  if [[ -z "$COLOR_VALUE" ]]; then
    echo "Warning: Color label '$COLOR_LABEL' not found in '$COLORS_FILE'. Using default color $DEFAULT_COLOR."
    COLOR_VALUE="$DEFAULT_COLOR"
  fi
fi

{% raw %}
# === REPLACE {{CURRENT_COLOR}} with extracted or default color ===
sed "s/{{CURRENT_COLOR}}/$COLOR_VALUE/g" "$SVG_INPUT_PATH" > "$SVG_OUTPUT_PATH" 
{% endraw %}

