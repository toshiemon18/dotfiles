# 基本設定
export EDITOR=nvim          # エディタをNeovimに設定
export LANG=ja_JP.UTF-8     # 文字コードをUTF-8に設定
export KCODE=u              # KCODEにUTF-8を設定

# XDG_CONFIG_HOME
export XDG_CONFIG_HOME=$HOME/.config

# PATH
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

# LD_LIBRARY_PATH (macOS Intel Homebrew: /usr/local配下のライブラリを優先させるため)
if [[ "$OSTYPE" == "darwin"* ]]; then
    export LD_LIBRARY_PATH="/usr/local/lib"
fi

alias cd_obsvault="cd $HOME/Dropbox/アプリ/remotely-save/toshiemon_obsidian/"

# Aliases
alias vim=nvim
alias v=nvim

