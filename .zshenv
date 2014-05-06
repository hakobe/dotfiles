export LANG="ja_JP.UTF-8"
export TZ="JPN-9"
export DISPLAY="DISPLAY=:0.0"

export EDITOR="vim"
export PAGER="less"
export LESSCHARSET="utf-8"

export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/local/vim/bin:$PATH"
export PATH="$HOME/bin:$PATH"

export MANPATH="/usr/local/share/man:$MANPATH"

if which plenv > /dev/null; then eval "$(plenv init -)"; fi
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

which npm > /dev/null && [[ -d `npm bin -g` ]] && export PATH=`npm bin -g`:$PATH

if [ -e ~/.zshenv.local ]; then
    source ~/.zshenv.local
fi
