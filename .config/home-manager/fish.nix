{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fish_vi_key_bindings
    '';
    loginShellInit = ''
      bass source ~/.profile
      bass source /etc/profile
    '';
    functions = { fish_greeting = "${pkgs.pfetch-rs}/bin/pfetch"; };
    plugins = with pkgs.fishPlugins; [
      {
        name = "bass";
        src = bass;
      }
      {
        name = "async-prompt";
        src = async-prompt;
      }
    ];
  };
}
