if status is-login
  bass source ~/.config/shell/profile
  bass source /etc/profile
end
if status is-interactive
  fish_vi_key_bindings
  bass source ~/.config/shell/aliasesrc
  starship init fish | source
end
