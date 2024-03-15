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
    functions = {
      fish_greeting = "${pkgs.pfetch-rs}/bin/pfetch";
      starship_transient_prompt_func =
        "${pkgs.starship}/bin/starship module character";
      starship_transient_rprompt_func =
        "${pkgs.starship}/bin/starship module time";
    };
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
