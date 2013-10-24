export LANG="ja_JP.UTF-8"
export TZ="JPN-9"
export DISPLAY="DISPLAY=:0.0"

export EDITOR="vim"
export PAGER="lv -c"
export LESSCHARSET="utf-8"

export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/homebrew/sbin:$PATH"
export PATH="$HOME/homebrew/bin:$PATH"
export PATH="$HOME/local/vim/bin:$PATH"
export PATH="$HOME/bin:$PATH"

export MANPATH="$HOME/share/man:$MANPATH"
export MANPATH="/usr/local/share/man:$MANPATH"

export SSL_CERT_FILE=`brew --prefix curl-ca-bundle`/share/ca-bundle.crt

if which plenv > /dev/null; then eval "$(plenv init -)"; fi
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

[[ -s "$HOME/.nvm/nvm.sh" ]] && . "$HOME/.nvm/nvm.sh"

if [ -e ~/.zshenv.local ]; then
    source ~/.zshenv.local
fi