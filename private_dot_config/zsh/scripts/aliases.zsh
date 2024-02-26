#LS to exa aliases
if (($+commands[eza])); then
	alias ls="eza --icons"
fi
alias ll="ls -l"
alias la="ls -la"
#cat to bat aliase
if (($+commands[bat])); then
	alias cat="bat"
fi
#River
alias river="dbus-launch --sh-syntax --exit-with-session river"
#dwl
alias dwl="dbus-launch --sh-syntax --exit-with-session dwl >  ~/.cache/dwltags"

#Doas
if (($+commands[doas])) && ! (($+commands[sudo])); then
	alias sudo="doas"
elif (($+commands[sudo])) && ! (($+commands[doas])); then
	alias doas="sudo"
fi
