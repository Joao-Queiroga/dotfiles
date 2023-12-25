{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    antidote = {
      enable = true;
      plugins = [
        "mattmc3/zfunctions"
        "zsh-users/zsh-autosuggestions"
        "zsh-users/zsh-history-substring-search"
        "zdharma-continuum/fast-syntax-highlighting kind:defer"
        "chisui/zsh-nix-shell"
      ];
    };
    autocd = true;
    defaultKeymap = "viins";
    history = {
      ignoreAllDups = true;
      path = "$HOME/.local/share/zsh/history";
    };
    shellAliases = { cat = "${pkgs.bat}/bin/bat"; };
    initExtraBeforeCompInit = ''
      ${pkgs.pfetch-rs}/bin/pfetch
    '';
    initExtra = ''
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      bindkey $terminfo[kcuu1] history-substring-search-up
      bindkey $terminfo[kcud1] history-substring-search-down
      bindkey -M vicmd 'K' history-substring-search-up
      bindkey -M vicmd 'J' history-substring-search-down
      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
      setopt +o nomatch
    '';
  };
}
