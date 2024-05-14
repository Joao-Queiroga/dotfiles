{ pkgs, system, inputs, ... }: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-bin;
    profiles.joaoq = {
      userChrome = builtins.readFile ./userChrome.css;
      extraConfig = builtins.readFile ./user.js;
    };
  };
}
