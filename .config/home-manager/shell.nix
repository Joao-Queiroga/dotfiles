{ config, pkgs, ... }: {
  home.shellAliases = {
    nvimconf = "nvim ~/.config/nvim/init.lua";
    ly = "lazygit --git-dir $HOME/.local/share/yadm/repo.git --work-tree $HOME";
    cat = "bat";
    tree = "eza --tree";
    cd = "z";
    grep = "rg";
    du = "${pkgs.dust}/bin/dust";
    pandoc =
      "${pkgs.pandoc}/bin/pandoc --pdf-engine weasyprint --css ~/.config/pandoc/style.css";
  };

  programs.fish = {
    enable = true;
    functions = { fish_greeting.body = "${pkgs.pfetch-rs}/bin/pfetch"; };
    shellInitLast = ''
      set -U fish_color_command cyan
      fish_vi_key_bindings
      bind -M insert enter expand-abbr execute
      bind -M default enter expand-abbr execute
    '';
    plugins = with pkgs.fishPlugins; [
      {
        name = "fishbang";
        src = fishbang.src;
      }
      {
        name = "autopair";
        src = autopair.src;
      }
    ];
  };
  programs.zsh = {
    enable = true;
    autocd = true;
    autosuggestion = { enable = true; };
    dotDir = "${config.xdg.configHome}/zsh";
    historySubstringSearch.enable = true;
    initContent = "${pkgs.pfetch-rs}/bin/pfetch";
    profileExtra = ". ~/.config/shell/profile";
    plugins = [
      {
        name = "fast-syntax-highlighting";
        src = pkgs.zsh-fast-syntax-highlighting;
        file = "share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh";
      }
      {
        name = "zsh-autopair";
        src = pkgs.zsh-autopair;
        file = "share/zsh/zsh-autopair/autopair.zsh";
      }
      {
        name = "zsh-vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];
  };
  programs = {
    zoxide.enable = true;
    bat.enable = true;
    ripgrep = {
      enable = true;
      arguments = [ "--hidden" "--smart-case" ];
    };
    carapace.enable = true;
    fzf.enable = true;
    eza = {
      enable = true;
      icons = "auto";
    };
    starship = {
      enable = true;
      settings = {
        add_newline = false;
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[✗](bold red)";
          vicmd_symbol = "[](bold green)";
        };
      };
    };
    atuin = {
      enable = true;
      settings = {
        dialect = "uk";
        enter_accept = true;
        keymap_mode = "vim-normal";
        keymap_cursor = {
          emacs = "blink-block";
          vim_insert = "steady-bar";
          vim_normal = "steady-block";
        };
      };
    };
    nix-your-shell.enable = true;
    tmux = {
      enable = true;
      escapeTime = 0;
      keyMode = "vi";
      extraConfig = ''
        set -gq allow-passthrough on

        bind -n M-H previous-window
        bind -n M-L next-window

        bind C-l send-keys 'C-l'
      '';
      plugins = with pkgs.tmuxPlugins; [
        yank
        vim-tmux-navigator
        sensible
        {
          plugin = tokyo-night-tmux;
          extraConfig = "set -g @tokyo-night-tmux_window_id_style none";
        }
      ];
    };
  };
}
