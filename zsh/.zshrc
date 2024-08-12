# ---------------------------
# General setting
# ---------------------------
export AUTOFEATURE=true     # autotestでfeatureを動かす
export EDITOR=vim
export ZDOTDIR=$HOME
source $HOME/.zprofile

setopt auto_cd              # コマンド無くてディレクトリ名があればcd
setopt no_beep              # beep音を鳴らさない

#### 補完系 ####
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

bindkey -e

# マッチしたコマンドのヒストリを表示できるようにする
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line

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

# ---------------------------
# Key binding
# ---------------------------
# fzf keybindinf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zsh-autocomplete
zstyle '*:compinit' arguments -D -i -u -C -w
## Tabキーのバインドを再設定する
### タブで保管を開く, 末尾から最初に戻る
bindkey '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete
bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete
## 補完候補の表示制限
# Autocompletion
zstyle -e ':autocomplete:list-choices:*' list-lines 'reply=( $(( LINES / 3 )) )'
# Override history search.
zstyle ':autocomplete:history-incremental-search-backward:*' list-lines 8
# History menu.
zstyle ':autocomplete:history-search-backward:*' list-lines 30
## 履歴のキーバインドを上書きしない
# bindkey '^R' .history-incremental-search-backward
# bindkey '^S' .history-incremental-search-forward

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

fpath=(/usr/local/share/zsh-completions $fpath)

autoload -U compinit
compinit -C

