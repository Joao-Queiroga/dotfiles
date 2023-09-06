# Start Antidote
# You can change the names/locations of these if you prefer.
antidote_dir=$ZSH/antidote
bundlefile=$ZSH/zsh_plugins
staticfile=$ZSH/.zsh_plugins.zsh

# Clone antidote if necessary and generate a static plugin file.
source $antidote_dir/antidote.zsh
zstyle ':antidote:bundle' use-friendly-names 'yes'
zstyle ':antidote:bundle' file $bundlefile
zstyle ':antidote:static' file $staticfile

antidote load

unset antidote_dir bundlefile staticfile
 
# Disable confirmation for history expansion
unsetopt HIST_VERIFY

setopt +o nomatch

# history substring search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

#ZSH autosugestion
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

for SCRIPT in $ZSH/scripts/*; do
    source $SCRIPT
done

eval "$(starship init zsh)"
