#!/bin/bash

# Global variable for required environment variables
REQUIRED_VARS=(
    "SCREEN_SIZE"
    "FONT_SIZE"
    "FONT"
)

# Function to check required environment variables
check_required_vars() {
    for VAR in "${REQUIRED_VARS[@]}"; do
        if [[ -z "${!VAR}" ]]; then
            echo "Error: $VAR is not set."
            exit 1
        fi
    done
}

# Function to calculate font size
calculate_font_size() {
    # Check if SCREEN_SIZE contains 'x'
    if [[ "$SCREEN_SIZE" == *"x"* ]]; then
        IFS='x' read -r WIDTH HEIGHT <<< "$SCREEN_SIZE"
    else
        # If no 'x', assume the value is the width and height
        WIDTH=$SCREEN_SIZE
        HEIGHT=$SCREEN_SIZE
    fi
    
    # Determine the largest dimension
    if [[ $WIDTH -gt $HEIGHT ]]; then
        LARGEST=$WIDTH
    else
        LARGEST=$HEIGHT
    fi
    
    # Calculate font size
    CALCULATED_SIZE=$((LARGEST * FONT_SIZE / 100))
}

# Function to parse arguments
parse_args() {
    while [[ "$#" -gt 0 ]]; do
        case "$1" in
            -d|--destination)
                if [[ -n "$2" ]]; then
                    OUTPUT_FILE="$2"
                    shift 2
                else
                    echo "Error: --destination requires a value"
                    exit 1
                fi
                ;;
            *)
                echo "Unknown argument: $1"
                exit 1
                ;;
        esac
    done

    if [[ -z "$OUTPUT_FILE" ]]; then
        echo "Error: --destination is required"
        exit 1
    fi
}

# Parse script arguments
parse_args "$@"

# Run checks and calculations
check_required_vars
calculate_font_size

# Generate the CSS file
cat <<EOF > "$OUTPUT_FILE"
/* Import the pywal colors */
@import url("{{cookiecutter.CACHE_DIR}}/wal/colors-waybar.css");
* {
    font-family: "$FONT";
    font-size: ${CALCULATED_SIZE}px;
}
EOF

echo "Generated $OUTPUT_FILE with font $FONT and size ${CALCULATED_SIZE}px."
