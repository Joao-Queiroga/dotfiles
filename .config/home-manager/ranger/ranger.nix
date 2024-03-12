{ pkgs, ... }: {
  programs.ranger = {
    enable = true;
    settings = {
      preview_images = true;
      preview_images_method = "kitty";
    };
  };
  home.file.".config/ranger/commands.py".source = ./commands.py;
}
