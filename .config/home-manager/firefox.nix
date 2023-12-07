{ pkgs, system, inputs, ... }:
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-bin;
    profiles.joaoq = {
      userChrome = builtins.readFile ./userChrome.css;
      userContent = builtins.readFile ./userContent.css;
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
      extensions = with inputs.firefox-addons.packages.${system};[
        ublock-origin
        darkreader
        surfingkeys
        videospeed
        gopass-bridge
      ];
    };
  };
}
