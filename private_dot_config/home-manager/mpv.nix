{ ... }: {
  programs.mpv = {
    enable = true;
    config = { geometry = "800x450"; };
  };
}
