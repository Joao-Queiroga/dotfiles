{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    spring-boot-tools.url = "path:./spring-boot-tools";
    spring-boot-nvim.url = "path:./spring-boot-nvim";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    _pkgs = import nixpkgs {inherit system;};
  in {
    packages.${system} = {
      spring-boot-tools = inputs.spring-boot-tools;
      spring-boot-nvim = inputs.spring-boot-nvim;
    };
  };
}
