{ pkgs, inputs }:
pkgs.stdenv.mkDerivation {
  name = "TokyoNight-Theme";

  src = inputs.tokyonight-gtk;

  dontUnpack = true;
  installPhase = ''
    mkdir -p $out/share
    cp -r $src/usr/share/themes $out/share
  '';
}
