# 日本語を使用
export LANG=ja_JP.UTF-8
# パスを追加したい場合
export PATH="$HOME/bin:$HOME/.zinit/bin:$PATH:$HOME/go/bin:/usr/local/go/bin:$HOME/.cargo/bin"
# go
export GOPATH=$HOME/go 
# terminal 256 color
export TERM=xterm-256color

# alias
alias -g F='| fzf'
alias -g L='| less'
alias -g H='| head'
alias -g G='| grep'
alias -g GI='| grep -ri'
alias ..='c ../'
alias back='pushd'
alias c='cdr'
alias code-server='code-server --disable-telemetry'
alias cp='cp -i'
alias diff='diff -U1'
alias h='fc -lt '%F %T' 1'
alias ls='ls --color=auto'
alias lst='ls -ltr --color=auto'
alias l='ls -ltr --color=auto'
alias la='ls -la --color=auto'
alias ll='ls -l --color=auto'
alias mkdir='mkdir -p'
alias rm='rm -i'
alias so='source'
alias v='vim'
alias vi='vim'
alias view='vim -R'
alias vz='vim ~/.zshrc'

# 色を使用
autoload -Uz colors
colors

# 補完
fpath=(~/.zsh/zsh-completions/src $fpath)
autoload -Uz compinit
compinit



# emacsキーバインド
bindkey -e


setopt share_history     # 他のターミナルとヒストリーを共有
setopt histignorealldups # ヒストリーに重複を表示しない
setopt hist_ignore_dups  # 重複を記録しない

setopt auto_cd           # cdコマンドを省略して、ディレクトリ名のみの入力で移動
setopt auto_pushd        # 自動でpushdを実行
setopt pushd_ignore_dups # pushdから重複を削除
setopt correct           # コマンドミスを修正
setopt prompt_subst

HISTFILE=~/.zsh_history
HISTSIZE=100000000
SAVEHIST=100000000
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>' # Ctrl-wの挙動



# function
function history-all { history -E 1 } # 全履歴一覧
function mkcd() {                     # mkdirとcdを同時実行
  if [[ -d $1 ]]; then
    echo "$1 already exists!"
    cd $1
  else
    mkdir -p $1 && cd $1
  fi
}

# backspace,deleteキーを使えるように
stty erase '^?'
stty erase ^H
bindkey "^[[3~" delete-char

# cdの後にlsを実行
#chpwd() { ls -ltr --color=auto }

# どこからでも参照できるディレクトリパス
cdpath=(~)

## 区切り文字の設定
#autoload -Uz select-word-style
#select-word-style default
#zstyle ':zle:*' word-chars "_-./;@"
#zstyle ':zle:*' word-style unspecified

# Ctrl+sのロック, Ctrl+qのロック解除を無効にする
setopt no_flow_control

# プロンプトを2行で表示、時刻を表示
PROMPT="%(?.%{${fg[green]}%}.%{${fg[red]}%})%n${reset_color}@${fg[blue]}%m${reset_color} (%*%) ${fg[yellow]}%~${reset_color}
%# "

# 補完後、メニュー選択モードになり左右キーで移動が出来る
zstyle ':completion:*:default' menu select=2

# 補完で大文字にもマッチ
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Ctrl+rでヒストリーのインクリメンタルサーチ、Ctrl+sで逆順
bindkey '^r' history-incremental-pattern-search-backward
bindkey '^s' history-incremental-pattern-search-forward

## コマンドを途中まで入力後、historyから絞り込み
## 例 ls まで打ってCtrl+pでlsコマンドをさかのぼる、Ctrl+bで逆順
#autoload -Uz history-search-end
#zle -N history-beginning-search-backward-end history-search-end
#zle -N history-beginning-search-forward-end history-search-end
#bindkey "^p" history-beginning-search-backward-end
#bindkey "^b" history-beginning-search-forward-end

# cdrコマンドを有効 ログアウトしても有効なディレクトリ履歴
# cdr タブでリストを表示
autoload -Uz add-zsh-hook
autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs
# cdrコマンドで履歴にないディレクトリにも移動可能に
zstyle ":chpwd:*" recent-dirs-default true

# 複数ファイルのmv 例　zmv *.txt *.txt.bk
autoload -Uz zmv
alias zmv='noglob zmv -W'


# git設定
git config --global user.emal "hoge@example.com"
git config --global user.name "Kabukiage Daisuki"
RPROMPT="%{${fg[blue]}%}[%~]%{${reset_color}%}"
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'



# virtualenvwrapper
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
  export WORKON_HOME=$HOME/.virtualens
  source /usr/local/bin/virtualenvwrapper.sh
fi


### Added by Zplugin's installer
source '/home/shigeo/.zinit/bin/zinit.zsh'
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zplugin
### End of Zplugin's installer chunk

# plugin
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zdharma/fast-syntax-highlighting

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

### End of Zinit's installer chunk
### End of Zinit's installer chunk
### End of Zinit's installer chunk
### End of Zinit's installer chunk
### End of Zinit's installer chunk
### End of Zinit's installer chunk
### End of Zinit's installer chunk
### End of Zinit's installer chunk
### End of Zinit's installer chunk
### End of Zinit's installer chunk
### End of Zinit's installer chunk
