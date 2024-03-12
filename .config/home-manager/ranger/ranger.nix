{ pkgs, ... }: {
  programs.ranger = {
    enable = true;
    settings = {
      preview_images = true;
      preview_images_method = "kitty";
    };
    mappings = {
      "<C-d>" = "shell ${pkgs.ripdrag}/bin/ripdrag -ax %p 2>/dev/null &";
    };
  };
  home.file.".config/ranger/commands.py".source = ./commands.py;
  home.file.".config/ranger/scope.sh".source = ./scope.sh;
}
