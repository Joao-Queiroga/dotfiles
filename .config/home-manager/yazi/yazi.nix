{ pkgs, ... }: {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    settings = import ./settings.nix;
    keymap = import ./keymap.nix;
    theme = import ./theme.nix;
  };
}
