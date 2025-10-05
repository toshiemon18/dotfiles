#!/usr/bin/env bash

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${BLUE}=== macOS Setup Script ===${NC}"
echo ""

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo -e "${RED}Error: This script is for macOS only${NC}"
    exit 1
fi

# Function to print section header
print_section() {
    echo ""
    echo -e "${BLUE}==>${NC} $1"
}

# Install Homebrew if not installed
print_section "Checking Homebrew installation"
if command -v brew &> /dev/null; then
    echo -e "${GREEN}✓${NC} Homebrew is already installed"
    brew --version
else
    echo -e "${YELLOW}!${NC} Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ $(uname -m) == "arm64" ]]; then
        echo -e "${YELLOW}!${NC} Detected Apple Silicon Mac. Adding Homebrew to PATH..."
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    echo -e "${GREEN}✓${NC} Homebrew installed successfully"
fi

# Update Homebrew
print_section "Updating Homebrew"
brew update

# Install packages from Brewfile if it exists
if [ -f "$SCRIPT_DIR/Brewfile" ]; then
    print_section "Installing packages from Brewfile"
    cd "$SCRIPT_DIR"
    brew bundle install
    echo -e "${GREEN}✓${NC} Packages installed from Brewfile"
else
    echo -e "${YELLOW}!${NC} Brewfile not found at $SCRIPT_DIR/Brewfile"
fi

# Cleanup
print_section "Cleaning up Homebrew"
brew cleanup

echo ""
echo -e "${GREEN}=== macOS setup complete! ===${NC}"
echo ""
echo "Next steps:"
echo "  1. Run ./setup_links.sh to create symbolic links for config files"
echo "  2. Restart your terminal or run 'exec zsh' to reload shell configuration"
