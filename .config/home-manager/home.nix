{ pkgs, inputs, ... }:
let tokyonight = import ./tokyonight-gtk.nix { inherit pkgs inputs; };
in {
  home.username = "joaoqueiroga";
  home.homeDirectory = "/home/joaoqueiroga";

  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    webcord
    drawio
    yadm
    sassc
    nixfmt
    beekeeper-studio
    whatsapp-for-linux
    gradle
    gradle-completion
  ];

  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
    theme = {
      package = tokyonight;
      name = "TokyoNight";
    };
  };

  services.blueman-applet.enable = true;

  programs = {
    ags.enable = true;
    bemenu = {
      enable = true;
      settings = {
        ignorecase = true;
        binding = "vim";
        vim-esc-exits = true;
      };
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
      settings = {
        add_newline = false;
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[✗](bold red)";
          vicmd_symbol = "[](bold green)";
        };
      };
    };
    eza = {
      enable = true;
      enableAliases = true;
      icons = true;
      git = true;
    };
    ripgrep.enable = true;
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [ batdiff batman batwatch ];
    };
    fzf = { enable = true; };
    password-store = { enable = true; };
    gradle = {
      enable = true;
      home = ".local/share/gradle";
    };
  };

  programs.home-manager.enable = true;
}
