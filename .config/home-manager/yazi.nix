{ config, pkgs, inputs, ... }: {
  programs.yazi = {
    enable = true;
    plugins = with pkgs.yaziPlugins; {
      smart-enter = smart-enter;
      mount = mount;
      drag = inputs.drag;
      git = git;
      starship = starship;
      full-border = full-border;
    };
    extraPackages = with pkgs; [ ripdrag glow ];
    settings = {
      opener = {
        jar = [{
          run = ''java -jar "$1"'';
          orphan = true;
          desc = "Open jar file";
        }];
      };
      open = {
        prepend_rules = [{
          name = "*.jar";
          use = [ "jar" ];
        }];
      };
    };
    keymap = {
      mgr.prepend_keymap = [
        {
          on = "l";
          run = "plugin smart-enter";
          desc = "Enter the child directory, or open the file";
        }
        {
          on = "$";
          run = "shell --block --confirm fish";
          desc = "Open shell";
        }
        {
          on = "<C-d>";
          run = "plugin drag";
          desc = "Drag files";
        }
        {
          on = "M";
          run = "plugin mount";
          desc = "Mount manager";
        }
      ];
    };
    initLua = ./yazi.lua;
  };
}
