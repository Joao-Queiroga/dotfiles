{ pkgs, inputs, ... }:
{
  home.username = "joaoqueiroga";
  home.homeDirectory = "/home/joaoqueiroga";

  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    webcord
    drawio
    yadm
    sassc
    beekeeper-studio
  ];

  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "ePapirus-Dark";
    };
    theme = {
      package = pkgs.dracula-theme;
      name = "Dracula";
    };
  };

  programs = {
    ags.enable = true;
    starship = {
      enable = true;
      enableZshIntegration = true;
    };
    eza = {
      enable = true;
      enableAliases = true;
      icons = true;
      git = true;
    };
    bat = {
      enable = true;
    };
  };

  programs.home-manager.enable = true;
}
