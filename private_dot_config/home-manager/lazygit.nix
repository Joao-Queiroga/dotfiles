{ ... }:
{
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        nerdFontsVersion = 3;
      };
      promptToReturnFromSubprocess = false;
    };
  };
}
