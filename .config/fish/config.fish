if status is-login
  bass source ~/.config/shell/profile
  bass source /etc/profile
end
if status is-interactive
  type -q starship; and starship init fish | source
  type -q zoxide; and zoxide init fish | source
  type -q atuin; and atuin init fish | source
  type -q fzf; and fzf --fish | source
  bass source ~/.config/shell/aliasesrc
  fish_vi_key_bindings
end
