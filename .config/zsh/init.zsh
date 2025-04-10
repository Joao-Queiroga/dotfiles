# ${ZDOTDIR:-~}/.zshrc

source $ZSH/.antidote/antidote.zsh

[[ -f ${ZSH}/zsh_plugins ]] || touch ${ZSH}/zsh_plugins

zstyle ':antidote:bundle' file ${ZSH}/zsh_plugins
zstyle ':antidote:static' file ~/.cache/antidote/static_file.zsh
zstyle ':antidote:bundle:*' zcompile 'yes'
zstyle ':antidote:static' zcompile 'yes'

antidote load

for script in $ZSH/scripts/*; do
    source $script
done

zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'

eval "$(starship init zsh)" 2> /dev/null

eval "$(zoxide init zsh)" 2> /dev/null

eval "$(atuin init zsh)" 2> /dev/null

source <(fzf --zsh) 2> /dev/null

pfetch 2> /dev/null
