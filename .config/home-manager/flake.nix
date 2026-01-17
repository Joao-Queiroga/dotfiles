{
  description = "Home Manager configuration of joaoqueiroga";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    astal = {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    astal-niri = {
      url = "github:sameoldlab/astal?ref=feat/niri";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.astal.follows = "astal";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    hyprsplit = {
      url = "github:shezdy/hyprsplit";
      inputs.hyprland.follows = "hyprland";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    # Yazi plugins
    drag = {
      url = "github:Joao-Queiroga/drag.yazi";
      flake = false;
    };
    gvfs-yazi = {
      url = "github:boydaihungst/gvfs.yazi";
      flake = false;
    };

    my-packages.url = "path:./pkgs";
    my-packages.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [inputs.my-packages.overlays.default inputs.niri.overlays.niri];
    };
  in {
    homeConfigurations."joaoqueiroga" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        inputs.stylix.homeModules.stylix
        inputs.niri.homeModules.niri
        inputs.niri.homeModules.stylix
        ./home.nix
      ];

      extraSpecialArgs = {
        inherit inputs;
        inherit system;
      };
    };
  };
}
