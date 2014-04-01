# see http://d.hatena.ne.jp/tarao/20100531/1275322620

source ~/.oh-my-zsh-custom/plugins/auto-fu/auto-fu.zsh/auto-fu.zsh
# initialization and options
function zle-line-init () { auto-fu-init }
zle -N zle-line-init
zstyle ':auto-fu:highlight' input bold
zstyle ':auto-fu:highlight' completion fg=white
zstyle ':auto-fu:var' postdisplay ''

# afu+cancel
function afu+cancel () {
    afu-clearing-maybe
    ((afu_in_p == 1)) && { afu_in_p=0; BUFFER="$buffer_cur"; }
}
function bindkey-advice-before () {
    local key="$1"
    local advice="$2"
    local widget="$3"
    [[ -z "$widget" ]] && {
        local -a bind
        bind=(`bindkey -M main "$key"`)
        widget=$bind[2]
    }
    local fun="$advice"
    if [[ "$widget" != "undefined-key" ]]; then
        local code=${"$(<=(cat <<"EOT"
            function $advice-$widget () {
                zle $advice
                zle $widget
            }
            fun="$advice-$widget"
EOT
        ))"}
        eval "${${${code//\$widget/$widget}//\$key/$key}//\$advice/$advice}"
    fi
    zle -N "$fun"
    bindkey -M afu "$key" "$fun"
}
bindkey-advice-before "^G" afu+cancel
bindkey-advice-before "^[" afu+cancel
bindkey-advice-before "^J" afu+cancel afu+accept-line
