{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    spring-boot-nvim = {
      url = "github:JavaHello/spring-boot.nvim";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    spring-boot-nvim,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    packages.${system}.default = pkgs.vimUtils.buildVimPlugin {
      pname = "spring-boot.nvim";
      version = "2025-10-10";
      src = spring-boot-nvim;

      meta.homepage = "https://github.com/JavaHello/spring-boot.nvim/";
      meta.hydraPlatforms = [];
    };
  };
}
