{ pkgs, inputs, ... }: {
  programs.ranger = {
    enable = true;
    settings = {
      preview_images = true;
      preview_images_method = "kitty";
      draw_borders = true;
    };
    aliases = let
      bg_script = pkgs.writeShellScriptBin "bg.sh" "$@ >/dev/null &";
      bg = commando: "shell ${bg_script}/bin/bg.sh ${commando}";
    in {
      drag = bg "${pkgs.ripdrag}/bin/ripdrag -ax %p";
      extract = bg "${pkgs.atool}/bin/atool -x %p";
    };
    mappings = { "<C-d>" = "drag"; };
    plugins = [{
      name = "devicons2";
      src = inputs.devicons2;
    }];
    extraConfig = ''
      default_linemode devicons2
    '';
  };
  home.file.".config/ranger/commands.py".source = ./commands.py;
  home.file.".config/ranger/scope.sh".source = ./scope.sh;
}
