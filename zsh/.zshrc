# ---------------------------
# General setting
# ---------------------------
plugins=(git ruby osx bundler brew emoji-clock)
export EDITOR=nvim           # エディタをVimに設定
export LANG=ja_JP.UTF-8     # 文字コードをUTF-8に設定
export KCODE=u              # KCODEにUTF-8を設定
export AUTOFEATURE=true     # autotestでfeatureを動かす
export ZSH=~/.oh-my-zsh

setopt auto_cd              # コマンド無くてディレクトリ名があればcd
setopt no_beep              # beep音を鳴らさない

#### 補完系 ####
setopt auto_list            # 補完候補を一覧表示
setopt auto_menu            # Tab連打で候補を順に表示
setopt list_packed          # 補完候補を詰めて表示
setopt list_types           # 補完候補のファイル種類を表示
setopt CORRECT_ALL          # コマンドを間違えたら訂正
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

# マッチしたコマンドのヒストリを表示できるようにする
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# ---------------------------
# Alias setting
# ---------------------------

# git
alias g=git

# Vim関係
alias v=nvim
alias vi=nvim
alias vim=nvim

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

# Python
alias py=python

# fzf
alias fzf="fzf --reverse"

# 学内プロキシ絶対許さねえ
alias nswitch="source ~/.switch_proxy.zsh"
# nswitch

# ---------------------------
# Own functions
# ---------------------------

# Enterだけ入力したらlsとgit statusを叩く
function do_enter() {
	if [ -n "$BUFFER" ]; then
		zle accept-line
		return 0
	fi

	echo
	ls
	# ls_abbrev

	if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
		echo
		echo -e "\e[0;33m--- git status ---\e[0m"
		git status -sb
	fi
	zle reset-prompt
	return 0
}

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

# cdしたあとに絶対lsする
function cd() {
  builtin cd $@ && ls;
}

# ---------------------------
# Key binding
# ---------------------------
# Enterだけ入力するとdo_enter関数を走らせる
zle -N do_enter
bindkey '^m' do_enter

# fzf keybindinf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ---------------------------
# Look and feel setting
# ---------------------------
### ZSH_THEME ###
source $ZSH/oh-my-zsh.sh

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

# if (which zprof > /dev/null) ;then
#     zprof | less
# fi
# ---------------------------
# 環境設定
# ---------------------------
if [ -e "$HOME/app/nvim/bin/nvim" ]; then
	export PATH="$PATH:$HOME/app/nvim/bin/nvim"
	alias nvim="$HOME/app/nvim/bin/nvim"
fi

case ${OSTYPE} in
    darwin*)
        export PATH="$PATH":"$HOME/myapp/bin"
				# for MySQL@5.7
				export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
				export LDFLAGS="-L/usr/local/opt/mysql@5.7/lib:$LDFLAGS"
				export CPPFLAGS="-I/usr/loca/opt/mysql@5.7/include:$CPPFLAGS"

				# for Homebrew Python3
				alias supython="sudo -H /usr/local/bin/python3"
				alias supip="sudo -H /usr/local/bin/pip3"
        ;;
esac

[[ -d ~/.rbenv  ]] && \
  export PATH=${HOME}/.rbenv/bin:${PATH} && \
  eval "$(rbenv init - zsh)"

# pyenv-virtualenv
export PYENV_ROOT=${HOME}/.pyenv
if [ -d "${PYENV_ROOT}" ]; then
    export PATH=${PYENV_ROOT}/bin:$PATH
    eval "$(pyenv init - --no-rehash)"
    eval "$(pyenv virtualenv-init -)"
fi

# direnv
eval "$(direnv hook zsh)"

# XSG_CONFIG_HOME
export XDG_CONFIG_HOME=$HOME/.config

# anyenv
export PATH=$HOME/.anyenv/bin:$PATH
eval "$(anyenv init - --no-rehash)"

# Elixir interactive shell
export ERL_AFLAGS="-kernel shell_history enable"

export PATH="/usr/local/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/lib"
export PATH="/usr/local/sbin:$PATH"

# PostgresSQL
export PGDATA=/usr/local/var/postgres

# fzf
export FZF_CTRL_T_COMMAND="/usr/locl/bin/fzf"

export PATH="$PATH:/usr/local/opt/node@10/bin"

export PATH="/usr/local/opt/avr-gcc@8/bin:$PATH"

autoload -U compinit
compinit -C

