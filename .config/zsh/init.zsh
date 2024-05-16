# ${ZDOTDIR:-~}/.zshrc

# Set the root name of the plugins files (.txt and .zsh) antidote will use.
zsh_plugins=${ZSH}/zsh_plugins

# Ensure the .zsh_plugins.txt file exists so you can add plugins.
[[ -f ${zsh_plugins} ]] || touch ${zsh_plugins}

# Lazy-load antidote from its functions directory.
fpath=($ZSH/.antidote/functions $fpath)
autoload -Uz antidote

# Generate a new static file whenever .zsh_plugins.txt is updated.
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins} ]]; then
  antidote bundle <${zsh_plugins} >|${zsh_plugins}.zsh
fi

# Source your static plugins file.
source ${zsh_plugins}.zsh

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey $terminfo[kcuu1] history-substring-search-up
bindkey $terminfo[kcud1] history-substring-search-down
bindkey -M vicmd 'K' history-substring-search-up
bindkey -M vicmd 'J' history-substring-search-down
zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
setopt +o nomatch

eval "$(starship init zsh)"

pfetch
