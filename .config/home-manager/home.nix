{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.zen-browser.homeModules.beta
    inputs.ags.homeManagerModules.default
    ./shell.nix
    ./hyprland.nix
    ./niri.nix
    ./dir_colors.nix
    ./yazi.nix
    ./nvim
  ];
  home.username = "joaoqueiroga";
  home.homeDirectory = "/home/joaoqueiroga";

  home.stateVersion = "25.05";

  home.sessionPath = [
    "${config.home.sessionVariables.CARGO_HOME}/bin"
    "${config.home.sessionVariables.GOPATH}/bin"
    "$HOME/.local/bin"
  ];

  xdg.autostart = {
    enable = true;
    entries = ["${pkgs.protonvpn-gui}/share/applications/proton.vpn.app.gtk.desktop"];
  };
  xdg.portal.enable = lib.mkForce false;

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    app2unit
    yadm
    dust
    fd
    pfetch
    ripdrag
    git
    p7zip
    filezilla
    ns-usbloader
    telegram-desktop
    rose-pine-hyprcursor
    ncpamixer
    nodePackages.nodejs
    rustup
    go
    brightnessctl
    qbittorrent
    hyprprop
    wl-clipboard
    gcc
    w3m
    gnumake
    protonvpn-gui
    python313Packages.weasyprint
  ];

  programs = {
    zen-browser.enable = true;
    chromium = {
      enable = true;
      package = pkgs.brave;
    };
    bemenu.enable = true;
    helix = {
      enable = true;
      package = pkgs.evil-helix;
    };
    ags = {
      enable = true;
      systemd.enable = true;
      extraPackages = with pkgs // inputs.astal.packages.${pkgs.system}; [
        brightnessctl
        app2unit
        apps
        notifd
        battery
        hyprland
        # niri lib that is still in a PR
        (inputs.astal-niri.packages.${pkgs.system}.niri.overrideAttrs (old: {nativeBuildInputs = hyprland.nativeBuildInputs;}))
        powerprofiles
        tray
        wireplumber
      ];
    };
    zathura = {
      enable = true;
      options = {
        adjust-open = "width";
        selection-clipboard = "clipboard";
        window-title-basename = true;
        recolor = true;
      };
    };
    imv.enable = true;
    mpv.enable = true;
    nh = {
      enable = true;
      flake = "${config.home.homeDirectory}/Projects/nixos";
      homeFlake = "${config.home.homeDirectory}/.config/home-manager";
    };
    lazygit = {
      enable = true;
      settings = {
        gui.nerdFontsVersion = 3;
        os.editPreset = "nvim";
        promptToReturnFromSubprocess = false;
      };
    };
    quickshell.enable = true;
    btop = {
      enable = true;
      settings = {
        update_ms = 100;
        vim_keys = true;
        proc_tree = true;
        proc_gradient = false;
        proc_sorting = "pid";
        proc_mem_bytes = true;
        proc_filter_kernel = true;
        cpu_invert_lower = true;
        cpu_single_graph = true;
        mem_graphs = false;
      };
    };
    vesktop = {
      enable = true;
    };
  };

  services = {
    udiskie = {
      enable = true;
      tray = "auto";
      settings = {program_options = {terminal = "kitty -1";};};
    };
    network-manager-applet.enable = true;
    blueman-applet.enable = true;
    kdeconnect = {
      enable = true;
      indicator = true;
    };
    wluma = {
      enable = true;
      settings = {
        als.time.thresholds = {
          "0" = "night";
          "7" = "dark";
          "9" = "dim";
          "11" = "normal";
          "13" = "bright";
          "16" = "normal";
          "18" = "dark";
          "20" = "night";
        };
        output.backlight = [
          {
            name = "SFP2412FHD";
            path = "/sys/class/backlight/ddcci6";
            capturer = "wayland";
            predictor.manual = {
              thresholds.day = {
                "0" = 0;
                "100" = 10;
              };
              thresholds.night = {
                "0" = 0;
                "100" = 60;
              };
            };
          }
          {
            name = "eDP-1";
            path = "/sys/class/backlight/intel_backlight";
            capturer = "wayland";
            predictor.manual = {
              thresholds.day = {
                "0" = 0;
                "100" = 10;
              };
              thresholds.night = {
                "0" = 0;
                "100" = 60;
              };
            };
          }
        ];
      };
    };
  };

  home.file = {};

  stylix = {
    enable = true;
    enableReleaseChecks = false;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-terminal-dark.yaml";
    override = {
      base05 = "#c0caf5";
      base09 = "#faba4a";
      base0B = "#9ece6a";
    };
    polarity = "dark";
    icons = {
      enable = true;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
      package = pkgs.papirus-icon-theme;
    };
    cursor = {
      name = "BreezeX-RosePine-Linux";
      package = pkgs.rose-pine-cursor;
      size = 27;
    };
    fonts = {
      monospace = {
        name = "JetBrainsMono Nerd Font";
        package = pkgs.nerd-fonts.jetbrains-mono;
      };
    };
    targets.kitty.variant256Colors = true;
    targets.zen-browser.enable = false;
  };

  gtk.enable = true;
  gtk.gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  qt.enable = true;
  qt.platformTheme.name = "gtk3";

  xdg.terminal-exec = {
    enable = true;
    settings = {default = ["kitty.desktop"];};
  };

  programs.kitty = {
    enable = true;
    settings = {
      cursor = "none";
      enable_audio_bell = false;
      tab_bar_style = "slant";
      confirm_os_window_close = 0;
    };
    extraConfig = "cursor none";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    PF_INFO = "ascii title os host kernel uptime pkgs wm memory palette";

    MESA_SHADER_CACHE_DIR = "$HOME/.cache/mesa_shader_cache";
    MESA_SHADER_CACHE_MAX_SIZE = "12G";
    RADV_PERFTEST = "aco";
    NIXOS_OZONE_WL = "1";
    XINITRC = "${config.xdg.configHome}/x11/xinitrc";
    _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=${config.xdg.configHome}/java";
    GOPATH = "${config.xdg.dataHome}/go";
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
    WGETRC = "${config.xdg.configHome}/wget/wgetrc";
    GNUPGHOME = "${config.xdg.dataHome}/gnupg";
    ANDROID_SDK_HOME = "${config.xdg.configHome}/android";
    ANDROID_USER_HOME = "${config.xdg.dataHome}/android";
    BUN_INSTALL = "${config.xdg.dataHome}/bun";
    NPM_CONFIG_INIT_MODULE = "${config.xdg.configHome}/npm/config/npm-init.js";
    NPM_CONFIG_CACHE = "${config.xdg.cacheHome}/npm";
    NPM_CONFIG_TMP = "$XDG_RUNTIME_DIR/npm";
    WINEPREFIX = "${config.xdg.dataHome}/wine";

    CARAPACE_HIDDEN = 1;
    CARAPACE_LENIENT = 1;
    CARAPACE_MATCH = 1;

    W3M_DIR = "${config.xdg.configHome}/w3m";

    MANPAGER = "nvim +Man!";
  };

  xdg.configFile."uwsm/env".source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
  xdg.configFile."w3m/config".text = "inline_img_protocol 4";

  programs.home-manager.enable = true;
}
