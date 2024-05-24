# eza alias
if (( $+commands[eza] )); then
  alias ls='eza --icons=auto'
fi

# ls aliases
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'

# cat alias
if (( $+commands[bat] )); then
  alias cat='bat'
fi
