# ${ZDOTDIR:-~}/.zshrc

source $ZSH/.antidote/antidote.zsh

# Ensure the .zsh_plugins.txt file exists so you can add plugins.
[[ -f ${ZSH}/zsh_plugins ]] || touch ${ZSH}/zsh_plugins

zstyle ':antidote:bundle' file ${ZSH}/zsh_plugins
zstyle ':antidote:static' file ~/.cache/antidote/static_file.zsh
zstyle ':antidote:bundle:*' zcompile 'yes'
zstyle ':antidote:static' zcompile 'yes'

antidote load

for script in $ZSH/scripts/*; do
    source $script
done

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey $terminfo[kcuu1] history-substring-search-up
bindkey $terminfo[kcud1] history-substring-search-down
bindkey -M vicmd 'K' history-substring-search-up
bindkey -M vicmd 'J' history-substring-search-down
zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
setopt +o nomatch

unsetopt HIST_VERIFY

eval "$(starship init zsh)" 2> /dev/null

eval "$(zoxide init zsh)" 2> /dev/null

pfetch
