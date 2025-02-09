# Ls colors
eval $(dircolors --sh ~/.dir_colors)

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# autosugestion color
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#6272a4"
