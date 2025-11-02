{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs.niri = {
    enable = true;
    settings = {
      xwayland-satellite.enable = true;
    };
  };
}
