{ pkgs, inputs, ... }:
let tokyonight = import ./pkgs/tokyonight-gtk.nix { inherit pkgs inputs; };
in {
  home.username = "joaoqueiroga";
  home.homeDirectory = "/home/joaoqueiroga";

  home.stateVersion = "23.05";
  imports = [
    inputs.ags.homeManagerModules.default
    ./flutter.nix
    ./lf.nix
    ./lazygit.nix
    ./yazi/yazi.nix
    ./ranger/ranger.nix
    ./hyprland.nix
    ./river.nix
    ./zsh.nix
    ./nu.nix
    ./fish.nix
    ./rofi.nix
    ./dir_colors.nix
    ./terminals.nix
    ./browser/firefox.nix
    ./btop.nix
    ./mpv.nix
    ./zathura.nix
    ./tmux.nix
  ];

  home.packages = with pkgs; [
    webcord
    drawio
    yadm
    sassc
    typescript
    nixfmt
    beekeeper-studio
    whatsapp-for-linux
    brave
  ];

  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
    theme = {
      package = tokyonight;
      name = "Tokyonight-Dark";
    };
  };

  services = {
    blueman-applet.enable = true;
    udiskie.enable = true;
    kdeconnect = {
      enable = true;
      indicator = true;
    };
  };

  programs = {
    ags.enable = true;
    bemenu = {
      enable = true;
      settings = {
        ignorecase = true;
        binding = "vim";
        vim-esc-exits = true;
      };
    };
    starship = {
      enable = true;
      enableTransience = true;
      settings = {
        add_newline = false;
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[✗](bold red)";
          vicmd_symbol = "[](bold green)";
        };
      };
    };
    eza = {
      enable = true;
      icons = true;
      git = true;
    };
    ripgrep.enable = true;
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [ batdiff batman batwatch ];
      config = {
        theme = "Tokyonight";
        wrap = "never";
      };
      themes = {
        Tokyonight = {
          src = inputs.tokyonight-nvim;
          file = "extras/sublime/tokyonight_night.tmTheme";
        };
      };
    };
    fzf.enable = true;
    password-store.enable = true;
    browserpass.enable = true;
    gradle = {
      enable = true;
      home = ".local/share/gradle";
    };
    neovim = {
      enable = true;
      withPython3 = true;
      withNodeJs = true;
      defaultEditor = true;
      extraLuaPackages = ps: [ ps.magick ];
    };
  };

  home.file.".config/awesome/.neoconf.json".text = ''
    {
    	"lspconfig": {
    		"lua_ls": {
    			"Lua.workspace.library": [
    				"~/.config/awesome/",
    				"${pkgs.awesome}/share/awesome/lib"
    			]
    		}
    	}
    }
    	'';

  programs.home-manager.enable = true;
}
