{ pkgs, lib, ... }: {
  wayland.windowManager.river = {
    enable = true;
    settings = let
      terminal = "kitty";
      modkey = "Super";
    in {

      # Theme options
      border-width = 2;
      border-color-focused = "0xeceff4";
      border-color-unfocused = "0x81a1c1";
      border-color-urgent = "0xbf616a";
      xcursor-theme = "Bibata-Modern-Ice 24";
      background-color = "0x2e3440";

      # Other options
      set-repeat = "50 300";
      focus-follows-cursor = "normal";
      set-cursor-warp = "on-output-change";
      attach-mode = "bottom";
      default-layout = "rivertile";
      keyboard-layout = "br";

      spawn = [
        "${pkgs.dunst}/bin/dunst"
        "'${pkgs.wbg}/bin/wbg ~/.config/.background'"
      ];

      map = {
        normal = {
          "${modkey} Return" = "spawn ${terminal}";
          "${modkey}+Shift Return" = "spawn thunar";
          "${modkey} B" = "spawn brave";
          "${modkey} R" = "spawn '${pkgs.rofi-wayland}/bin/rofi -show drun'";
          "${modkey} P" = "spawn ${pkgs.bemenu}/bin/bemenu-run";
          "${modkey} Space" = "spawn '${pkgs.dunst}/bin/dunstctl close'";
          "${modkey}+Shift Space" =
            "spawn '${pkgs.dunst}/bin/dunstctl close-all'";
          "${modkey}+Shift C" = "close";
          "${modkey}+Shift Q" = "exit";
        };
    };
  };
}
# "${modkey} ${toString i}" = "set-focused-tags ${toString i}";
# "${modkey}+Shift ${toString i}" = "set-focused-tags ${toString i}";
# "${modkey}+Control ${toString i}" =
#   "toggle-focused-tags ${toString i}";
# "${modkey}+Alt ${toString i}" = "toggle-view-tags ${toString i}";
