{ pkgs, ... }: {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    settings = import ./settings.nix;
    keymap = import ./keymap.nix { pkgs = pkgs; };
    theme = import ./theme.nix;
  };
}
