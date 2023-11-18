{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    antidote = {
      enable = true;
      plugins = [
        "mattmc3/zfunctions"
        "zdharma-continuum/fast-syntax-highlighting kind:defer"
      ];
    };
    autocd = true;
    defaultKeymap = "viins";
    history = {
      ignoreAllDups = true;
      path = "$HOME/.local/share/zsh/history";
    };
    historySubstringSearch = {
      enable = true;
      searchUpKey = [
        "$terminfo[kcuu1]"
      ];
      searchDownKey = [
        "$terminfo[kcud1]"
      ];
    };
    initExtra = ''
      		setopt +o nomatch
      		${pkgs.pfetch-rs}/bin/pfetch
      		'';
  };
}
