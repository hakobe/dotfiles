# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="nicoulaj"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git git-extras ruby perl rbenv tmux vagrant brew cpanm bundler node npm osx)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

bindkey '^P' history-beginning-search-backward # 先頭マッチのヒストリサーチ
bindkey '^N' history-beginning-search-forward  # 先頭マッチのヒストリサーチ

bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward

# Ctrl+S/Ctrl+Q によるフロー制御を使わないようにする
setopt NO_flow_control

# シェルが終了しても裏ジョブに HUP シグナルを送らないようにする
setopt NO_hup

# コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments

# ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt mark_dirs

# 8 ビット目を通すようになり、日本語のファイル名などを見れるようになる
setopt print_eightbit

# 戻り値が 0 以外の場合終了コードを表示する
setopt print_exit_value

### エイリアスファイルがあれば読み込む
if [ -e ~/.aliases ]; then
    source ~/.aliases
fi

### 便利な関数
function w {
    cd ~/working/$1
}

function _w {
    local allfiles
    local -a _projects

    allfiles=`find ~/working/* -type d -maxdepth 0 -exec basename '{}' ';'`

    _projects=( $(echo $allfiles) )
    _describe -t projects "Projects" _projects

    return 1;
}

compdef _w w

if [ -e ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi
