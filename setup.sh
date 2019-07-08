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
echo "Installing fomulas from Brewfile"
echo "================================"
mkdir -p $HOME/.config/brewfile
ln -fis $PWD/Brewfile $HOME/.config/brewfile/Brewfile
brew file install

# ========================
#  Setup Zsh Environments
# ========================
ln -fis $PWD/zsh/.zshrc $HOME/.zshrc
ln -fis $PWD/zsh/.zsh_simple_prompt $HOME/.zsh_simple_prompt

chsh -s "$(which zsh)"

# ========================
#  Setup Ruby environment
# ========================
echo "================================"
echo "Installing fomulas from Brewfile"
echo "================================"
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv && src/configure && make -C src
