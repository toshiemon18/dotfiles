# ---------------------------
# General setting
# ---------------------------
export AUTOFEATURE=true     # autotestでfeatureを動かす
export ZDOTDIR=$HOME
source $HOME/.zprofile

setopt auto_cd              # コマンド無くてディレクトリ名があればcd
setopt no_beep              # beep音を鳴らさない

#### 補完系 ####
zmodload zsh/complist
fpath=(/usr/local/share/zsh-completions $fpath)
fpath=($HOME/.docker/completions $fpath)
autoload -Uz compinit && compinit -u
zstyle ':completion:*' menu select search

setopt auto_list            # 補完候補を一覧表示
setopt auto_menu            # Tab連打で候補を順に表示
setopt auto_pushd
setopt list_packed          # 補完候補を詰めて表示
setopt list_types           # 補完候補のファイル種類を表示
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない

#### History ####
HISTFILE=~/.zsh_history     # ヒストリを保存するファイル
HISTSIZE=10000              # メモリに保存されるヒストリの件数
SAVEHIST=10000              # 保存されるヒストリの件数
setopt bang_hist            # !を使ったヒストリ展開を行う
setopt extended_history     # ヒストリに実行時間も保存する
setopt hist_ignore_dups     # 直前と同じコマンドはヒストリに追加しない
setopt share_history        # 他のシェルのヒストリをリアルタイムで共有する
setopt hist_reduce_blanks   # 余分なスペースを削除してヒストリに保存する
# setopt hist_ignore_space    # スペースで始まるコマンドは履歴に残さない
# setopt hist_verify          # ヒストリを呼び出したときに編集可能にする
# setopt hist_expand          # 履歴展開時に自動的に置換を行う

# emacsモードを有効化（Ctrl+A等のキーバインドを使えるようにする）
bindkey -e

# ---------------------------
# Alias setting
# ---------------------------

# git
alias g=git

# ls
alias sl=ls
case ${OSTYPE} in
    darwin*)
        alias ls="ls -GF"
        ;;
    linux*)
        alias ls="ls -F --color"
        ;;
esac
alias la="ls -al"
# usage : $ lag hogehoge
alias lag="ls -la | grep"

# fzf
alias fzf="fzf --reverse"

# ---------------------------
# Own functions
# ---------------------------

# fbr - checkout git branch (powered fzf)
function fbr() {
	if [ -z "$(which fzf)" ]; then
		echo "Please install fzf -- fzf does not exist"
		return -1
	fi

	local branches branch
	branches=$(git branch --all | grep -v HEAD) &&
	branch=$(echo "$branches" |
	fzf -d $(( 2 + $(wc -l <<<"$branches") )) +m) &&
	git checkout $(echo "$branch" | awk '{print $1}' | sed "s#remotes/[^/]*/##")
}

# fcd - cd to selected directory in fzf interface
function fcd() {
	local dir
	dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
	cd "$dir"
}

# fzf_ghq_look - cd to selected directory in fzf interface
function fzf_ghq_look() {
	if [ -z "$(which fzf)" ]; then
		echo "Please install fzf -- fzf does not exist"
		return -1
	fi
	if [ -z "$(which ghq)" ]; then
		echo "Please install ghq -- ghq does not exist"
		return -1
	fi

	local dir
	dir=$(ghq list -p | fzf +m) &&
	cd $dir

	zle clear-screen
}
zle -N fzf_ghq_look
bindkey "^]" fzf_ghq_look

# fzf_cmd_history - search command history in fzf interface
function fzf_cmd_history() {
	if [ -z "$(which fzf)" ]; then
			echo "Please install fzf -- fzf does not exist"
			return -1
	fi

	local selected=$(history -n 1 | fzf --reverse --height 40% --query="$BUFFER")
	if [ -n "$selected" ]; then
			BUFFER="$selected"
			CURSOR=$#BUFFER
	fi
	zle reset-prompt
}
zle -N fzf_cmd_history
bindkey '^R' fzf_cmd_history

# ---------------------------
# Key binding
# ---------------------------
# fzf keybindinf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# コマンドラインをエディタで編集する
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# ---------------------------
# Look and feel setting
# ---------------------------
# 区切り文字を変更
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars "_-./;@"
zstyle ':zle:*' word-style unspecified

#### Ls Color ####
# 色
export LSCOLORS=gxfxxxxxcxxxxxxxxxgxgx

# 補完時の色
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'ex=32'

# ZLS_COLORS
export ZLS_COLORS=$LS_COLORS
# lsで自動で色をつける
export CLICOLRS=true
# 補完候補に色を付ける
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

#### Prompt ####
# プロンプトに色を設定
autoload -U colors; colors
source ~/.zsh_simple_prompt



# Added by LM Studio CLI (lms)
export PATH="$PATH:$HOME/.lmstudio/bin"
# End of LM Studio CLI section


source ~/.safe-chain/scripts/init-posix.sh # Safe-chain Zsh initialization script
