{ pkgs, ... }: {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    settings = ./settings.nix;
    keymap = ./keymap.nix;
    theme = ./theme.nix;
  };
}
