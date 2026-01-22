{
  config,
  pkgs,
  inputs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    plugins = with inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}; [
      hyprscrolling
      inputs.hyprsplit.packages.${pkgs.stdenv.hostPlatform.system}.hyprsplit
    ];
    systemd.enable = false;
    settings = {
      monitor = [
        "eDP-1, preferred, auto, 1"
        "DP-1, highrr, auto, 1, bitdepth, 10, cm, auto, sdrbrightness, 1.2, sdrsaturation, 1.1"
        "HDMI-A-1, preferred, auto-right, 1"
        ", highrr, auto, 1"
      ];
      plugin = {
        hyprscrolling = {
          fullscreen_on_one_column = true;
          focus_fit_method = 1;
        };
      };
      input = {
        kb_layout = "br";
        follow_mouse = 1;
        touchpad.natural_scroll = false;
        numlock_by_default = true;
      };
      general = {
        gaps_in = 5;
        gaps_out = 10;
        float_gaps = 10;
        layout = "scrolling";
      };
      misc = {
        enable_anr_dialog = false;
        vrr = true;
        vfr = true;
      };
      decoration = {
        blur.size = 3;
        rounding = 5;
      };
      animations.animation = ["workspaces, 0, 6, default"];
      master = {
        new_status = "inherit";
        new_on_top = true;
        special_scale_factor = 0.99;
      };
      windowrule = [
        "match:class (brave-browser), workspace 2"
        "match:class ^(zen.*)$, workspace 2"
        "match:class (discord), workspace 6"
        "match:class (WebCord), workspace 6"
        "match:class (teams-for-linux), workspace 7"
        "match:class ^(.*ueberzug.*)$, no_anim on"
        "match:class (info.cemu.Cemu), idle_inhibit focus"
        "match:title (Nova guia privada - Brave), workspace special"
      ];
      layerrule = [
        "match:namespace gtk4-layer-shell, blur on"
        "match:namespace gtk4-layer-shell, ignore_alpha 0"
        "match:namespace gtk4-layer-shell, xray 0"
      ];
      "$mod" = "Super";
      "$term" = "app2unit -- kitty -1";
      "$editor" = "$term nvim";
      bind =
        [
          "$mod_SHIFT, C, killactive, "
          "$mod_SHIFT, Q, exec, loginctl kill-session $XDG_SESSION_ID"
          "$mod, T, togglefloating, "
          "$mod, R, exec, ags toggle launcher"
          "$mod, P, exec, app2unit -- $(bemenu-run --binding vim)"

          # Launch keybindings
          "$mod, Return, exec, $term"
          "$mod_SHIFT, Return, exec, app2unit -- thunar"
          "$mod, B, exec, app2unit -- brave"
          "$mod_SHIFT, B, exec, [workspace special] app2unit -- brave --incognito"

          # Reset ags
          "$mod, q, exec, systemctl --user restart ags.service"

          # Move focus with mod + arrow keys
          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"

          # Focus or swap master
          "$mod, m, layoutmsg, focusmaster"
          "$mod_SHIFT, m, layoutmsg, swapwithmaster"

          # Add and remove masters
          "$mod, I, layoutmsg, addmaster"
          "$mod, D, layoutmsg, removemaster"

          # Enter FullscreenMode
          "$mod SHIFT, F, fullscreen"

          "$mod, F, layoutmsg, fit active"
          "$mod, C, layoutmsg, colresize 0.5"
          "$mod, minus, layoutmsg, colresize -0.1"
          "$mod, equal, layoutmsg, colresize +0.1"

          # special workspace
          "$mod, 0, togglespecialworkspace"
          "$mod SHIFT, 0, movetoworkspacesilent, special"

          # Hidden special workspace
          "$mod , n, movetoworkspacesilent, special:hidden"
          "$mod SHIFT, n, togglespecialworkspace, hidden"

          # Monitors bindings
          "$mod, period, focusmonitor, r"
          "$mod, comma, focusmonitor, l"

          # Move Windows throug monitors
          "$mod SHIFT, period, movewindow, mon:r"
          "$mod SHIFT, comma, movewindow, mon:l"

          # Open task manager
          "CONTROL SHIFT, escape, exec, $term -e btop"

          # Disable left monitor
          "$mod SHIFT, o, exec, hyprctl dispatch dpms off HDMI-A-1"
          # Disable all monitors
          "$mod CONTROL SHIFT, o, exec, hyprctl dispatch dpms off "
          # Enable all monitors
          "$mod CONTROL, o,exec, hyprctl dispatch dpms on"

          # Multimedia Keys
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPrev, exec, playerctl previous"
          ", XF86audiostop, exec, playerctl stop"
        ]
        ++ (builtins.concatLists (builtins.genList (i: let
            ws = i + 1;
          in [
            "$mod, code:1${toString i}, split:workspace, ${
              toString ws
            }"
            "$mod SHIFT, code:1${toString i}, split:movetoworkspacesilent, ${
              toString ws
            }"
          ])
          9));
      binde = [
        # Move focus with mod + JK
        "$mod, J, split:workspace, +1"
        "$mod, K, split:workspace, -1"

        # move column
        "$mod, H, layoutmsg, focus l"
        "$mod, L, layoutmsg, focus r"
        "$mod SHIFT, H, layoutmsg, swapcol l"
        "$mod SHIFT, L, layoutmsg, swapcol r"

        # Brightness Keys
        ", XF86MonBrightnessUp, exec, brightnessctl set 10%+"
        ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"

        # Volume keys
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%-"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%+"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle"

        #Print keys
        ", print, exec, grimblast save output"
        "SHIFT, print, exec, grimblast save area"

        # OBS vars
        "SUPER, F10, pass, ^(com.obsproject.Studio)$"
        "SUPER, F11, pass, ^(com.obsproject.Studio)$"
        ", PAUSE, pass, ^(com.obsproject.Studio)$"
      ];
      bindn = [
        # Notifications
        "CONTROL, Space, exec, ags request clearLastNotification"
        "CONTROL SHIFT, Space, exec, ags request clearAllNotifications"
      ];
      bindm = [
        # Move/resize windows with mod + LMB/RMB and dragging
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      bindl = [",switch:off:Lid Switch, exec, app2unit -- hyprlock --immediate"];
    };
  };
  xdg.configFile."uwsm/env-hyprland".text = ''
    export XDG_CURRENT_DESKTOP=Hyprland
    export XDG_SESSION_TYPE=wayland
    export XDG_SESSION_DESKTOP=Hyprland
  '';
  services.hyprpaper = {
    enable = true;
    settings = {
      wallpaper = [
        {
          monitor = "";
          path = "~/.config/.background";
        }
      ];
    };
  };
  services.hyprpolkitagent = {
    enable = true;
  };
  services.hypridle = {
    enable = true;
    systemdTarget = "hyprland-session.target";
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        ignore_systemd_inhibit = false;
      };
      listener = [
        {
          timeout = 150;
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        ignore_empty_input = true;
        text_trim = true;
      };
      background = {
        monitor = "";
        path = "~/.config/.lockscreen.jpg";
        #color = "rgba(25, 20, 20, 1.0)";

        blur_passes = 0;
        blur_size = 7;
        noise = 1.17e-2;
        contrast = 0.8916;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      };
      input_field = {
        monitor = "";
        size = "200, 50";
        outline_thickness = 2;
        rounding = -1;
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
        position = "0, -20";
      };
    };
  };
}
