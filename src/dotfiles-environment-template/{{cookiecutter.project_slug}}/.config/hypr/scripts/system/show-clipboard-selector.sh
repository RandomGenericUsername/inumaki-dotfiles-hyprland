#!/bin/bash

preview_dir="/tmp/cliphist-previews"
mkdir -p "$preview_dir"

render_entry() {
    local content="$1"
    local hash
    hash=$(echo -n "$content" | sha256sum | awk '{print $1}')
    local tmpfile="$preview_dir/$hash"

    if [[ ! -f "$tmpfile" ]]; then
        echo -n "$content" > "$tmpfile"
    fi

    if file --mime-type "$tmpfile" | grep -q '^.*: image/'; then
        echo -en "$hash\x00icon\x1f$tmpfile\x1finfo\x1f$content\n"
    else
        preview=$(head -n 5 "$tmpfile" | tr '\n' '⏎' | cut -c1-150)
        [[ -z "$preview" ]] && preview="<empty or binary data>"
        echo -en "$preview\x00info\x1f$content\n"
    fi
}

# Called by Rofi to display entries
if [[ "$ROFI_RETV" -eq 0 ]]; then
    cliphist list | head -n 10 | while read -r line; do
        render_entry "$line"
    done

# Called when user selects an item
elif [[ "$ROFI_RETV" -eq 1 ]]; then
    echo -n "$1" | wl-copy
    notify-send "Clipboard" "✅ Restored selected entry"
fi
