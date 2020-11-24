# /usr/bin/env sh

# ========================
#  HomeBrew setup
# ========================
# install homebrew
echo "==============================="
echo "Executing homebrew setup script"
echo "==============================="
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install fomulas from Brewfile
echo "================================"
echo "Install formulas from Brewfile"
echo "================================"
brew bundle --file $PWD/Brewfile

# ========================
#  dotfiles setup
# ========================
sh ./install.sh

# ========================
#  Setup shell
# ========================
chsh -s "$(which zsh)"
