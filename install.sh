if [ -z $HOME/.config ] then;
	mkdir -p $HOME/.config
fi

export XDG_CONFIG_HOME=$HOME/.config

# NeoVim
ln -fis $PWD/nvim $XDG_CONFIG_HOME

# Vim8
ln -fis $PWD/vim/vimrc $HOME/.vimrc
ln -fis $PWD/vim/gvimrc $HOME/.gvimrc

# Zsh
ln -fis $PWD/zsh/.zshenv $HOME/.zshenv
ln -fis $PWD/zsh/.zshrc $HOME/.zshrc
ln -fis $PWD/zsh/.zsh_simple_prompt $HOME/.zsh_simple_prompt
ln -fis $PWD/zsh/.switch_proxy.zsh $HOME/.switch_proxy.zsh

# tmux
ln -fis $PWD/tmux/tmux.conf $HOME/.tmux.conf

# alacritty
ln -fis $PWD/alacritty/alacritty.yml $XDG_CONFIG_HOME/alacritty/alacritty.yml
