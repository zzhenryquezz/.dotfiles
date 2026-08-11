#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SOURCE_DIR="$(realpath "$SCRIPT_DIR/../..")"
OUTPUT_DIR="$(dirname $SCRIPT_DIR)/.local/share/applications"

echo "creating scripts in $OUTPUT_DIR"

for dir in "$SOURCE_DIR"/*/; do
    [[ -d "$dir" ]] || continue

    name="$(basename "$dir")"
    script="$OUTPUT_DIR/_$name.desktop"

    cat > "$script" <<EOF
[Desktop Entry] 
Name=[config] $name 
Type=Application 
Exec=kitty --directory "$dir" -e nvim 
Terminal=false
Icon=catppuccin-3d
EOF

    chmod +x "$script"

    echo "Created: $script"
done


