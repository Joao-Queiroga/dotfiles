{ pkgs, ... }:
{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "JetBrains Mono Nerd Font:size=12:antialias=true:autohint=true";
        box-drawings-uses-font-glyphs = true;
        font-size-adjustment = 0;
        letter-spacing = 0;
        pad = "0x0center";
        dpi-aware = true;
      };
      colors = {
        foreground = "c0caf5";
        background = "1a1b26";
        selection-foreground = "c0caf5";
        selection-background = "283457";
        urls = "73daca";

        ## Normal/regular colors (color palette 0-7)
        regular0 = "15161e";
        regular1 = "f7768e";
        regular2 = "9ece6a";
        regular3 = "e0af68";
        regular4 = "7aa2f7";
        regular5 = "bb9af7";
        regular6 = "7dcfff";
        regular7 = "a9b1d6";

        ## Bright colors (color palette 8-15)
        bright0 = "414868";
        bright1 = "f7768e";
        bright2 = "9ece6a";
        bright3 = "e0af68";
        bright4 = "7aa2f7";
        bright5 = "bb9af7";
        bright6 = "7dcfff";
        bright7 = "c0caf5";

        ## dimmed colors (see foot.ini(5) man page)
        # dim0 = "<not set>";
        # ...
        # dim7 = "<not-set>";

        ## The remaining 256-color palette
        "16" = "ff9e64";
        "17" = "db4b4b";
      };
    };
  };
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrains Mono Nerd Font";
      size = 12;
    };
    settings = {
      cursor = "none";
      cursor_shape = "block";
    };
    # extraConfig = ''
    #   cursor none
    # '';
    theme = "Tokyo Night";
  };
}
