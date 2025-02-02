if status is-login
  bass source ~/.config/shell/profile
  bass source /etc/profile
end
if status is-interactive
  type -q starship; and starship init fish | source; enable_transience
  type -q zoxide; and zoxide init fish | source
  type -q atuin; and atuin init fish | source
  type -q fzf; and fzf --fish | source
  bass source ~/.config/shell/aliasesrc
  fish_vi_key_bindings

  set -Ux CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense' # optional
  mkdir -p ~/.config/fish/completions
  carapace --list | awk '{print $1}' | xargs -I{} touch ~/.config/fish/completions/{}.fish # disable auto-loaded completions (#185)
  carapace _carapace | source
end
