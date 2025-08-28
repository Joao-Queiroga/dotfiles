{ config, pkgs, ... }: {
  programs.fish = {
    enable = true;
    functions = { fish_greeting.body = "${pkgs.pfetch}/bin/pfetch"; };
    shellInitLast = ''
      set -U fish_color_command cyan
      fish_vi_key_bindings
    '';
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
    bat = { enable = true; };
    eza = {
      enable = true;
      icons = "auto";
    };
  };
}
