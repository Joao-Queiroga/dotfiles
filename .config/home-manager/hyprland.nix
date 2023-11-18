{ pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [
        "eDP-1,prefered, auto,1"
        "DP-1,highrr, 1920x0,1"
        "HDMI-A-1,prefered, 0x0,1"
      ];

      "$mhandler" = "~/.config/hypr/monitors";

      env = [
        "XDG_CURRENT_DESKTOP, Hyprland"
        "NIXOS_OZONE_WL, 1"
        "XDG_SESSION_TYPE, wayland"
        "XDG_SESSION_DESKTOP, Hyprland"
      ];

      exec-once = [
        "$mhandler setup"
        "swaybg -i ~/.config/.background "
        "~/.config/hypr/desktop-portal.sh"
        "wl-clipboard-history -t"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "dunst"
        "$mhandler setup"
        "dex --autostart"
        "ags"
        "hyprctl dispatch dpms off HDMI-A-1"
        "sleep 1 && hyprctl dispatch focusmonitor 0"
      ];

      source = [ "~/.config/hypr/bindings.conf" ];

      input = {
        kb_layout = "br";

        follow_mouse = 1;

        touchpad = {
          natural_scroll = false;
        };

        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

        numlock_by_default = true;
      };

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        col.active_border = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        col.inactive_border = "rgba(595959aa)";

        layout = "master";
      };

      misc = {
        vrr = true;
      };

      decoration = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        blur = {
          size = 3;
        };
        rounding = 5;

        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      animations = {
        enabled = true;

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 0, 6, default"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_is_master = true;
        new_on_top = true;
        special_scale_factor = 0.99;
      };

      windowrulev2 = [
        "workspace 2 silent, class:^(firefox.*)$"
        "workspace 6, class:^(discord)$"
        "workspace 6, class:^(WebCord)$"
        "workspace 7, class:^(teams-for-linux)$"
        "workspace 9 silent, class:^(Minecraft .*)$"
        "workspace 9 silent, class:^(org.prismlauncher.PrismLauncher)$"
        "workspace 9 silent, class:^(net-technicpack-launcher-LauncherMain)$"
        "noanim, class:^(.*ueberzug.*)$"
      ];

    };
  };
}
