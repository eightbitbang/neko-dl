#!/bin/bash

# Build script for neko-dl

set -e

SCRIPT_NAME="neko-dl.sh"
BINARY_NAME="neko-dl"

echo "🔧 Building $BINARY_NAME from $SCRIPT_NAME..."

# Check if shc is installed
if ! command -v shc &>/dev/null; then
    echo "❌ Error: 'shc' is not installed. Please install it first."
    exit 1
fi

# Check if script exists
if [[ ! -f "$SCRIPT_NAME" ]]; then
    echo "❌ Error: Source script '$SCRIPT_NAME' not found."
    exit 1
fi

# Compile with shc
shc -f "$SCRIPT_NAME" -o "$BINARY_NAME"
echo "✅ Compiled binary: $BINARY_NAME"

# Optional: strip binary to reduce size
if command -v strip &>/dev/null; then
    strip "$BINARY_NAME"
    echo "🧽 Stripped binary to reduce size."
fi

# Make sure it's executable
chmod +x "$BINARY_NAME"
echo "🚀 Ready to run: ./$BINARY_NAME"
