#!/usr/bin/env bash

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Set XDG_CONFIG_HOME if not set
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Setting up symbolic links..."
echo "XDG_CONFIG_HOME: $XDG_CONFIG_HOME"
echo "Source directory: $SCRIPT_DIR"
echo ""

# Create XDG_CONFIG_HOME if it doesn't exist
mkdir -p "$XDG_CONFIG_HOME"

# Function to create symlink
create_symlink() {
    local source="$1"
    local dest="$2"

    # Expand ~ to $HOME
    dest="${dest/#\~/$HOME}"

    # If destination exists
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        # If it's already a symlink to the correct source
        if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$source" ]; then
            echo -e "${GREEN}✓${NC} Already linked: $dest"
            return 0
        fi

        # Backup existing file/directory
        local backup="${dest}.backup.$(date +%Y%m%d_%H%M%S)"
        echo -e "${YELLOW}!${NC} Backing up existing $dest to $backup"
        mv "$dest" "$backup"
    fi

    # Create parent directory if needed
    local parent_dir="$(dirname "$dest")"
    mkdir -p "$parent_dir"

    # Create symlink
    ln -s "$source" "$dest"
    echo -e "${GREEN}✓${NC} Linked: $source -> $dest"
}

# Read settings.yml and create symlinks
# This assumes YAML structure with component names and their settings

# nvim
if [ -d "$SCRIPT_DIR/nvim" ]; then
    create_symlink "$SCRIPT_DIR/nvim" "$XDG_CONFIG_HOME/nvim"
fi

# tmux
if [ -d "$SCRIPT_DIR/tmux" ]; then
    create_symlink "$SCRIPT_DIR/tmux" "$XDG_CONFIG_HOME/tmux"
fi

# ghostty
if [ -d "$SCRIPT_DIR/ghostty" ]; then
    create_symlink "$SCRIPT_DIR/ghostty" "$XDG_CONFIG_HOME/ghostty"
fi

# mise
if [ -d "$SCRIPT_DIR/mise" ]; then
    create_symlink "$SCRIPT_DIR/mise" "$XDG_CONFIG_HOME/mise"
fi

# zsh (goes to HOME directory, not XDG_CONFIG_HOME)
if [ -d "$SCRIPT_DIR/zsh" ]; then
    for file in "$SCRIPT_DIR/zsh"/.z*; do
        if [ -f "$file" ]; then
            basename_file="$(basename "$file")"
            create_symlink "$file" "$HOME/$basename_file"
        fi
    done
fi

# git (goes to HOME directory, not XDG_CONFIG_HOME)
if [ -d "$SCRIPT_DIR/git" ]; then
    for file in "$SCRIPT_DIR/git"/.git*; do
        if [ -f "$file" ]; then
            basename_file="$(basename "$file")"
            # Copy instead of symlink for git (as per settings.yml)
            dest="$HOME/$basename_file"
            dest="${dest/#\~/$HOME}"
            if [ -e "$dest" ]; then
                backup="${dest}.backup.$(date +%Y%m%d_%H%M%S)"
                echo -e "${YELLOW}!${NC} Backing up existing $dest to $backup"
                mv "$dest" "$backup"
            fi
            cp "$file" "$dest"
            echo -e "${GREEN}✓${NC} Copied: $file -> $dest"
        fi
    done
fi

# vim
if [ -d "$SCRIPT_DIR/vim" ]; then
    create_symlink "$SCRIPT_DIR/vim" "$HOME/.vim"
fi

# hammerspoon
if [ -d "$SCRIPT_DIR/hammerspoon" ]; then
    create_symlink "$SCRIPT_DIR/hammerspoon" "$HOME/.hammerspoon"
fi

# ideavim
if [ -d "$SCRIPT_DIR/ideavim" ]; then
    for file in "$SCRIPT_DIR/ideavim"/.ideavim*; do
        if [ -f "$file" ]; then
            basename_file="$(basename "$file")"
            create_symlink "$file" "$HOME/$basename_file"
        fi
    done
fi

echo ""
echo -e "${GREEN}Setup complete!${NC}"
