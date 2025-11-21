{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs.yazi = {
    enable = true;
    plugins = with pkgs.yaziPlugins; {
      smart-enter = smart-enter;
      drag = inputs.drag;
      gvfs = inputs.gvfs-yazi;
      git = git;
      starship = starship;
      full-border = full-border;
    };
    extraPackages = with pkgs; [ripdrag glow glib];
    settings = {
      opener = {
        jar = [
          {
            run = ''java -jar "$1"'';
            orphan = true;
            desc = "Open jar file";
          }
        ];
      };
      open = {
        prepend_rules = [
          {
            name = "*.jar";
            use = ["jar"];
          }
        ];
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
          on = ["M" "m"];
          run = "plugin gvfs -- select-then-mount --jump";
          desc = "Select device to mount and jump to its mount point";
        }

        {
          on = ["M" "R"];
          run = "plugin gvfs -- remount-current-cwd-device";
          desc = "Remount device under cwd";
        }
        {
          on = ["M" "u"];
          run = "plugin gvfs -- select-then-unmount --eject";
          desc = "Select device then eject";
        }
        {
          on = ["M" "U"];
          run = "plugin gvfs -- select-then-unmount --eject --force";
          desc = "Select device then force to eject/unmount";
        }
        {
          on = ["M" "a"];
          run = "plugin gvfs -- add-mount";
          desc = "Add a GVFS mount URI";
        }
        {
          on = ["M" "e"];
          run = "plugin gvfs -- edit-mount";
          desc = "Edit a GVFS mount URI";
        }
        {
          on = ["M" "r"];
          run = "plugin gvfs -- remove-mount";
          desc = "Remove a GVFS mount URI";
        }
        {
          on = ["g" "m"];
          run = "plugin gvfs -- jump-to-device";
          desc = "Select device then jump to its mount point";
        }
        {
          on = ["`" "`"];
          run = "plugin gvfs -- jump-back-prev-cwd";
          desc = "Jump back to the position before jumped to device";
        }
        {
          on = ["M" "t"];
          run = "plugin gvfs -- automount-when-cd";
          desc = "Enable automount when cd to device under cwd";
        }
        {
          on = ["M" "T"];
          run = "plugin gvfs -- automount-when-cd --disabled";
          desc = "Disable automount when cd to device under cwd";
        }
      ];
    };
    initLua = ./yazi.lua;
  };
}
