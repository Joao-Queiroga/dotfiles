#LS to exa aliases
if (($+commands[lsd])); then
	alias ls="lsd"
	alias ll="lsd -l"
	alias la="lsd -la"
fi
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
