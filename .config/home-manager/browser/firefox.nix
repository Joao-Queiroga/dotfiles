{ pkgs, system, inputs, ... }: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-bin;
    profiles.joaoq = {
      userChrome = builtins.readFile ./userChrome.css;
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
      extraConfig = builtins.readFile ./user.js;
      extensions = with inputs.firefox-addons.packages.${system}; [
        ublock-origin
        darkreader
        surfingkeys
        sidebery
        videospeed
        gopass-bridge
      ];
    };
  };
}
