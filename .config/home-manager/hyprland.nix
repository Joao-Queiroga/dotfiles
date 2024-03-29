{ pkgs, inputs, ... }: {
  imports = [
    inputs.hyprland.homeManagerModules.default
    inputs.hyprpaper.homeManagerModules.default
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [
        "eDP-1,prefered, auto,1"
        "DP-1,highrr, 1920x0,1"
        "HDMI-A-1,prefered, 0x0,1"
      ];

      env = [
        "XDG_CURRENT_DESKTOP, Hyprland"
        "NIXOS_OZONE_WL, 1"
        "XDG_SESSION_TYPE, wayland"
        "XDG_SESSION_DESKTOP, Hyprland"
      ];

      exec-once = [
        "${pkgs.dunst}/bin/dunst"
        "ags"
        "hyprctl dispatch dpms off HDMI-A-1"
        "hyprctl dispatch focusmonitor 0"
      ];

      input = {
        kb_layout = "br";

        follow_mouse = 1;

        touchpad = { natural_scroll = false; };

        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

        numlock_by_default = true;
      };

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        layout = "master";
      };

      misc = {
        enable_swallow = true;
        swallow_regex = "kitty";
        vrr = true;
      };

      decoration = {
        blur = { size = 3; };
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
        "workspace 2 silent, class:^(brave-browser)$"
        "workspace 6, class:^(discord)$"
        "workspace 6, class:^(WebCord)$"
        "workspace 7, class:^(teams-for-linux)$"
        "noanim, class:^(.*ueberzug.*)$"
      ];

      "$mainMod" = "SUPER";
      "$term" = "kitty -1";
      "$edittor" = "$term nvim";

      bind = [
        "$mainMod_SHIFT, C, killactive, "
        "$mainMod_SHIFT, Q, exit, "
        "$mainMod, T, togglefloating, "
        "$mainMod, R, exec, ${pkgs.rofi-wayland}/bin/rofi -i -show drun"
        "$mainMod, P, exec, ${pkgs.bemenu}/bin/bemenu-run --binding vim"

        # Launch keybindings
        "$mainMod, Return, exec, $term"
        "$mainMod_SHIFT, Return, exec, thunar"
        "$mainMod, B, exec, brave"

        # Open settings
        "$mainMod, S, exec, $edittor $HOME/.config/hypr/hyprland.conf"

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Swap window
        "$mainMod_SHIFT, J, layoutmsg, swapnext"
        "$mainMod_SHIFT, K, layoutmsg, swapprev"

        # Focus or swap master
        "$mainMod, m, layoutmsg, focusmaster"
        "$mainMod_SHIFT, m, layoutmsg, swapwithmaster"

        # Add and remove masters
        "$mainMod, I, layoutmsg, addmaster"
        "$mainMod, D, layoutmsg, removemaster"

        # Enter FullscreenMode
        "$mainMod, F, fullscreen"
        "$mainMod_SHIFT, F, fakefullscreen"

        # special workspace
        "$mainMod, 0, togglespecialworkspace"
        "$mainMod SHIFT, 0, movetoworkspacesilent, special"

        # Hidden special workspace
        "$mainMod , n, movetoworkspacesilent, special:hidden"
        "$mainMod SHIFT, n, togglespecialworkspace, hidden"

        # Monitors bindings
        "$mainMod, period, focusmonitor, r"
        "$mainMod, comma, focusmonitor, l"

        # Move Windows throug monitors
        "$mainMod SHIFT, period, movewindow, mon:r"
        "$mainMod SHIFT, comma, movewindow, mon:l"

        # Open task manager
        "CONTROL SHIFT, escape, exec, $term -e ${pkgs.btop}/bin/btop"

        # Disable left monitor
        "$mainMod SHIFT, o, exec, hyprctl dispatch dpms off HDMI-A-1"
        # Disable all monitors
        "$mainMod CONTROL SHIFT, o, exec, hyprctl dispatch dpms off "
        # Enable all monitors
        "$mainMod CONTROL, o,exec, hyprctl dispatch dpms on"

        # Multimedia Keys
        ", XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
        ", XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next"
        ", XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous"
        ", XF86audiostop, exec, ${pkgs.playerctl}/bin/playerctl stop"
      ] ++ (
        # workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList (x:
          let
            ws = let c = (x + 1) / 10; in builtins.toString (x + 1 - (c * 10));
          in [
            "$mainMod, ${ws}, split-workspace, ${toString (x + 1)}"
            "$mainMod SHIFT, ${ws}, split-movetoworkspacesilent, ${
              toString (x + 1)
            }"
          ]) 9));

      binde = [
        # Move focus with mainMod + JK
        "$mainMod, J, layoutmsg, cyclenext"
        "$mainMod, K, layoutmsg, cycleprev"

        # Change splitratio whith mainMod + HL
        "$mainMod, H, splitratio, -0.05"
        "$mainMod, L, splitratio, +0.05"

        # Brightness Keys
        ", XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 10%+"
        ", XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 10%-"

        # Volume keys
        ", XF86AudioLowerVolume, exec, amixer -q sset Master 5%-"
        ", XF86AudioRaiseVolume, exec, amixer -q sset Master 5%+"
        ", XF86AudioMute, exec, amixer -q sset Master toggle"
      ];

      bindn = [
        # Dunst
        "CONTROL, Space, exec, ${pkgs.dunst}/bin/dunstctl close"
        "CONTROL SHIFT, Space, exec, ${pkgs.dunst}/bin/dunstctl close-all"
      ];

      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };

    plugins = [
      inputs.split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces
    ];
  };
  services.hyprpaper = {
    enable = true;
    preloads = [ "~/.config/.background" ];
    wallpapers = [
      "DP-1, ~/.config/.background"
      "eDP-1, ~/.config/.background"
      "HDMI-A-1, ~/.config/.background"
    ];
  };
}
