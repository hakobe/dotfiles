source ~/.zsh/custom_plugins/auto-fu/auto-fu.zsh.git/auto-fu.zsh
function zle-line-init () {
    auto-fu-init
}
zle -N zle-line-init
