if status is-login
  bass source ~/.config/shell/profile
  bass source /etc/profile
end
if status is-interactive
  starship init fish | source
  zoxide init fish | source
  fzf --fish | source
  bass source ~/.config/shell/aliasesrc
  fish_vi_key_bindings
end
