{
  description = "Home Manager configuration of joaoqueiroga";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

		hyprland.url = "github:hyprwm/Hyprland";
		split-monitor-workspaces = {
			url = "github:Duckonaut/split-monitor-workspaces";
			inputs.hyprland.follows = "hyprland";
		};
  };

  outputs = { self, nixpkgs, home-manager, hyprland, split-monitor-workspaces, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
				inherit system;

				config = {
					allowUnfree = true;
				};
			};
    in {
      homeConfigurations."joaoqueiroga" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
					hyprland.homeManagerModules.default
					{wayland.windowManager.hyprland.enable = true;}
					./home.nix
				];
        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
