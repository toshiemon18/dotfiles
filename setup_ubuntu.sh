#!/usr/bin/env bash
# =============================================================
# setup_ubuntu.sh
# Ubuntu/WSL 向けセットアップスクリプト (setup_macos.sh のLinux版)
#
# 方針: Homebrewは使わない (macOS専用として残す)。
#       Linux側はaptで完結させ、go/ruby/rustはdotfilesのmiseに任せる。
# =============================================================
set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Ubuntu/WSL Setup Script ===${NC}"
echo ""

if [[ "$OSTYPE" != "linux-gnu"* ]]; then
    echo -e "${RED}Error: This script is for Linux/WSL (Ubuntu) only${NC}"
    exit 1
fi
if ! command -v apt-get &> /dev/null; then
    echo -e "${RED}Error: apt-get not found. This script assumes Ubuntu/Debian.${NC}"
    exit 1
fi

print_section() {
    echo ""
    echo -e "${BLUE}==>${NC} $1"
}

print_section "apt update"
sudo apt-get update

print_section "Ruby / mise ビルド用の依存ライブラリ"
sudo apt-get install -y \
    build-essential pkg-config autoconf bison \
    libssl-dev libreadline-dev zlib1g-dev libyaml-dev \
    libffi-dev libgdbm-dev libncurses-dev libxml2-dev libxslt1-dev

print_section "基本CLIツール"
sudo apt-get install -y \
    git curl wget unzip zsh tmux neovim \
    ripgrep fzf silversearcher-ag jq \
    cmake ninja-build universal-ctags \
    gnupg watch pandoc imagemagick

print_section "GitHub CLI (gh) の導入"
if ! command -v gh &> /dev/null; then
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
        | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
        | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y gh
else
    echo -e "${GREEN}✓${NC} gh はインストール済み"
fi

print_section "ghq の導入 (go install。mise管理のgoを利用)"
if command -v go &> /dev/null; then
    go install github.com/x-motemen/ghq@latest
else
    echo -e "${YELLOW}!${NC} go が見つかりません。先に 'mise use -g go@latest' を実行してから"
    echo -e "${YELLOW}!${NC} このスクリプトを再実行するか、後で手動で 'go install github.com/x-motemen/ghq@latest' してください"
fi

echo ""
echo -e "${GREEN}=== Ubuntu/WSL setup complete! ===${NC}"
echo ""
echo "Brewfile* (mac専用) はこのスクリプトでは使っていません。"
echo "ここに含まれていない追加ツールが必要な場合は都度 'sudo apt-get install <pkg>' してください。"
echo ""
echo "Next steps:"
echo "  1. mise run setup:all-linux    # config のシンボリックリンクを作成"
echo "  2. chsh -s \$(which zsh)        # デフォルトシェルをzshに変更"
echo "  3. ターミナルを開き直して zsh を再読み込み"
