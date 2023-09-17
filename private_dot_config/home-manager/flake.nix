{
  description = "Home Manager configuration of joaoqueiroga";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
		st.url = "github:Joao-Queiroga/st";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... } @ inputs:
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
					./home.nix
				];
        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
				extraSpecialArgs = { inherit inputs; };
      };
    };
}
