{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    extraConfig = {
      display-run = " ";
      display-drun = "  ";
      # display-window = "  ";
      drun-display-format = "{icon} {name}";
      modi = "run,drun";
      show-icons = true;
    };
    theme = ./rofi-theme.rasi;
    terminal = "${pkgs.kitty}/bin/kitty -1";
  };
}
