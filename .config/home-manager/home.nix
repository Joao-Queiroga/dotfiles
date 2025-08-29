{ config, pkgs, inputs, ... }: {
  imports = [
    inputs.zen-browser.homeModules.beta
    inputs.ags.homeManagerModules.default
    ./shell.nix
  ];
  home.username = "joaoqueiroga";
  home.homeDirectory = "/home/joaoqueiroga";

  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    atuin
    fzf
    dust
    pfetch
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
    targets.zen-browser.enable = false;
  };

  gtk.enable = true;
  gtk.gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  qt.enable = true;

  programs.kitty = {
    enable = true;
    settings = {
      cursor = "none";
      enable_audio_bell = false;
      tab_bar_style = "slant";
      confirm_os_window_close = 0;
    };
    extraConfig = "cursor none";
  };

  home.sessionVariables = { EDITOR = "nvim"; };

  programs.home-manager.enable = true;
}
