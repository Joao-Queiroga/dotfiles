{ pkgs, inputs, ... }:
{
  home.username = "joaoqueiroga";
  home.homeDirectory = "/home/joaoqueiroga";
  targets.genericLinux.enable = true;

  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    webcord
    drawio
    yazi
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

	programs.ags.enable = true;

  programs.home-manager.enable = true;
}
