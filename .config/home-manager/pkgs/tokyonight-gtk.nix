{ pkgs, inputs }:
pkgs.stdenv.mkDerivation {
  name = "TokyoNight-Theme";

  src = inputs.tokyonight-gtk;

  buildInputs = with pkgs; [ sassc eza bat ];

  dontUnpack = true;
  buildPhase = builtins.readFile ./tokyonight_install.sh;
  installPhase = ''
    mkdir -p $out/share/
    mv themes $out/share/
  '';
}
