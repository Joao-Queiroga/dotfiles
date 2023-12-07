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
      url = "github:Duckonaut/split-monitor-workspaces";
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

    ags.url = "github:Aylur/ags";
  };

  outputs = { nixpkgs, home-manager, hyprland, split-monitor-workspaces, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;

        config = {
          allowUnfree = true;
        };
      };
    in
    {
      homeConfigurations."joaoqueiroga" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          inputs.ags.homeManagerModules.default
          ./home.nix
          ./lf.nix
          ./yazi.nix
          ./hyprland.nix
          ./zsh.nix
          ./rofi.nix
          ./nu.nix
          ./dir_colors.nix
          ./terminals.nix
          ./firefox.nix
        ];

        extraSpecialArgs = { inherit inputs system hyprland split-monitor-workspaces; };
      };
    };
}
