{
  description = "Home Manager configuration of joaoqueiroga";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
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

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          # hyprland.homeManagerModules.default
          inputs.ags.homeManagerModules.default
          ./home.nix
          ./lf.nix
          ./yazi.nix
          ./hyprland.nix
          ./zsh.nix
          ./nu.nix
          ./dir_colors.nix
          ./terminals.nix
        ];
        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = { inherit inputs hyprland split-monitor-workspaces; };
      };
    };
}
