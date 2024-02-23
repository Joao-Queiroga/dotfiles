{
  description = "Home Manager configuration of joaoqueiroga";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    st = {
      url = "github:Joao-Queiroga/st";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    split-monitor-workspaces = {
      url = "github:zjeffer/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tokyonight-gtk = {
      url = "github:Fausto-Korpsvart/Tokyo-Night-GTK-Theme";
      flake = false;
    };
    tokyonight-nvim = {
      url = "github:folke/tokyonight.nvim";
      flake = false;
    };

    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, hyprland, split-monitor-workspaces, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          android_sdk.accept_license = true;
        };
      };
    in {
      homeConfigurations."joaoqueiroga" =
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            hyprland.homeManagerModules.default
            inputs.ags.homeManagerModules.default
            ./flutter.nix
            ./home.nix
            ./lf.nix
            ./lazygit.nix
            ./yazi.nix
            ./hyprland.nix
            ./zsh.nix
            ./rofi.nix
            ./nu.nix
            ./dir_colors.nix
            ./terminals.nix
            ./browser/firefox.nix
            ./btop.nix
            ./mpv.nix
            ./zathura.nix
          ];

          extraSpecialArgs = {
            inherit inputs system split-monitor-workspaces;
          };
        };
    };
}
