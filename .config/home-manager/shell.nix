{ config, pkgs, ... }:
{
  programs.fish = {
    enable = true;
  };
  programs = {
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
    bat = {
      enable = true;
      # config = {
      #   theme = "Tokyonight";
      # };
    };
    eza.enable = true;
  };
}
