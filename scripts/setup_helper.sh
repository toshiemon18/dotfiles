#!/usr/bin/env bash
# Shared helper functions for dotfiles setup tasks

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Create a symlink, backing up any existing file/directory
link_file() {
    local src="$1"
    local dst="$2"

    if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
        echo -e "${GREEN}✓${NC} Already linked: $dst"
        return 0
    fi

    if [ -e "$dst" ] || [ -L "$dst" ]; then
        local backup="${dst}.backup.$(date +%Y%m%d_%H%M%S)"
        echo -e "${YELLOW}!${NC} Backing up: $dst -> $backup"
        mv "$dst" "$backup"
    fi

    mkdir -p "$(dirname "$dst")"
    ln -s "$src" "$dst"
    echo -e "${GREEN}✓${NC} Linked: $src -> $dst"
}

# Alias for directories (same behavior)
link_dir() {
    link_file "$1" "$2"
}

# Copy a file, backing up any existing destination
copy_file() {
    local src="$1"
    local dst="$2"

    if [ -e "$dst" ]; then
        local backup="${dst}.backup.$(date +%Y%m%d_%H%M%S)"
        echo -e "${YELLOW}!${NC} Backing up: $dst -> $backup"
        mv "$dst" "$backup"
    fi

    mkdir -p "$(dirname "$dst")"
    cp "$src" "$dst"
    echo -e "${GREEN}✓${NC} Copied: $src -> $dst"
}
