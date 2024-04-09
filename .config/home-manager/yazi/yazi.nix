{ pkgs, ... }: {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    settings = import ./settings.nix;
    keymap = import ./keymap.nix { pkgs = pkgs; };
    theme = import ./theme.nix;
  };
  home.file."yazi-lua" = {
    enable = true;
    source = ./init.lua;
    target = ".config/yazi/init.lua";
  };
  home.file."yazi-plugins" = {
    enable = true;
    source = ./plugins;
    target = ".config/yazi/plugins";
    recursive = true;
  };
  home.file."yazi-flavors" = {
    enable = true;
    source = ./flavors;
    target = ".config/yazi/flavors";
    recursive = true;
  };
}
