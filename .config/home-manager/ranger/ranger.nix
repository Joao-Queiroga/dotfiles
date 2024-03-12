{ pkgs, ... }: {
  programs.ranger = {
    enable = true;
    settings = {
      preview_images = true;
      preview_images_method = "kitty";
    };
    aliases = let
      bg_script = pkgs.writeShellScriptBin "bg.sh" "$@ >/dev/null &";
      bg = commando: "shell ${bg_script}/bin/bg.sh ${commando}";
    in {
      drag = bg "${pkgs.ripdrag}/bin/ripdrag -ax %p";
      extract = bg "${pkgs.atool}/bin/atool -x %p";
    };
    mappings = { "<C-d>" = "drag"; };
  };
  home.file.".config/ranger/commands.py".source = ./commands.py;
  home.file.".config/ranger/scope.sh".source = ./scope.sh;
}
