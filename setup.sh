# /usr/bin/env sh

# ========================
#  dotfiles setup
# ========================
sh ./install.sh

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
#  Setup Zsh Environments
# ========================
ln -fis $PWD/zsh/.zshrc $HOME/.zshrc
ln -fis $PWD/zsh/.zsh_simple_prompt $HOME/.zsh_simple_prompt
chsh -s "$(which zsh)"
