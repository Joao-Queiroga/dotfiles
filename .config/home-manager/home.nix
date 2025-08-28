{ config, pkgs, inputs, ... }: {
  imports = [
    inputs.zen-browser.homeModules.beta
    inputs.ags.homeManagerModules.default
    ./shell.nix
  ];
  home.username = "joaoqueiroga";
  home.homeDirectory = "/home/joaoqueiroga";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    atuin
    fzf
    ripgrep
    dust
    pfetch
    zoxide
    tmux
    lazygit
    yazi
    uwsm
    git
    nil
    hyprpaper
    hypridle
    hyprlock
    wluma
    rose-pine-hyprcursor
    nodePackages.nodejs
    rustup
    go
    brightnessctl
    hyprprop
    wl-clipboard
    gcc
    tree-sitter
    gnumake
  ];

  programs = {
    zen-browser.enable = true;
    bemenu.enable = true;
    ags = {
      enable = true;
      extraPackages = with pkgs // inputs.astal.packages.${pkgs.system}; [
        brightnessctl
        apps
        notifd
        battery
        hyprland
        powerprofiles
        tray
        wireplumber
      ];
    };
  };

  services = {
    network-manager-applet.enable = true;
    blueman-applet.enable = true;
    kdeconnect = {
      enable = true;
      indicator = true;
    };
  };

  home.file = { };

  stylix = {
    enable = true;
    base16Scheme =
      "${pkgs.base16-schemes}/share/themes/tokyo-night-terminal-dark.yaml";
    override = {
      base05 = "#c0caf5";
      base09 = "#faba4a";
      base0B = "#9ece6a";
    };
    polarity = "dark";
    icons = {
      enable = true;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
      package = pkgs.papirus-icon-theme;
    };
    fonts = {
      monospace = {
        name = "JetBrainsMono Nerd Font";
        package = pkgs.nerd-fonts.jetbrains-mono;
      };
    };
    targets.kitty.variant256Colors = true;
  };

  gtk.enable = true;
  qt.enable = true;

  programs.kitty = {
    enable = true;
    settings = {
      cursor = "none";
      enable_audio_bell = false;
      tab_bar_style = "slant";
      confirm_os_window_close = 0;
    };
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/joaoqueiroga/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
