if status is-login
  bass source ~/.config/shell/profile
  bass source /etc/profile
end
if status is-interactive
  type -q starship; and starship init fish | source; and enable_transience
  type -q zoxide; and zoxide init fish | source; and alias cd=z
  type -q atuin; and atuin init fish | source
  type -q fzf; and fzf --fish | source
  fish_vi_key_bindings

  carapace _carapace | source
  bass source ~/.config/shell/aliasesrc
end
