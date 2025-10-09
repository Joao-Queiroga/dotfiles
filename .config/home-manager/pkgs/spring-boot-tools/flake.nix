{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    spring-boot-tools = {
      url = "https://github.com/spring-projects/spring-tools/releases/download/4.32.0.RELEASE/vscode-spring-boot-1.64.0-RC1.vsix";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    spring-boot-tools,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
    version = "1.64.0";
  in {
    packages.${system}.default = pkgs.stdenv.mkDerivation {
      pname = "spring-boot-tools";
      version = version;
      src = spring-boot-tools;
      nativeBuildInputs = [pkgs.unzip];
      unpackPhase = "unzip $src/*";
      installPhase = ''
        mkdir -p $out/share/vscode/extensions
        unzip $src -d $out/share/vscode/extensions
      '';
    };
  };
}
