{
  manager = {
    layout = [ 1 4 3 ];
    sort_by = "modified";
    sort_sensitive = true;
    sort_reverse = true;
    sort_dir_first = true;
    linemode = "none";
    show_hidden = false;
    show_symlink = true;
  };

  preview = {
    tab_size = 2;
    max_width = 600;
    max_height = 900;
    cache_dir = "";
    ueberzug_scale = 1;
    ueberzug_offset = [ 0 0 0 0 ];
  };

  opener = {
    edit = [
      {
        exec = ''$EDITOR "$@"'';
        block = true;
        for = "unix";
      }
      {
        exec = ''code "%*"'';
        orphan = true;
        for = "windows";
      }
    ];
    open = [
      {
        exec = ''xdg-open "$@"'';
        desc = "Open";
        for = "linux";
      }
      {
        exec = ''open "$@"'';
        desc = "Open";
        for = "macos";
      }
      {
        exec = ''start "%1"'';
        orphan = true;
        desc = "Open";
        for = "windows";
      }
    ];
    reveal = [
      {
        exec = ''open -R "$1"'';
        desc = "Reveal";
        for = "macos";
      }
      {
        exec = "explorer /select,%1";
        orphan = true;
        desc = "Reveal";
        for = "windows";
      }
      {
        exec = ''exiftool "$1"; echo "Press enter to exit"; read'';
        block = true;
        desc = "Show EXIF";
        for = "unix";
      }
    ];
    extract = [
      {
        exec = ''unar "$1"'';
        desc = "Extract here";
        for = "unix";
      }
      {
        exec = ''unar "%1"'';
        desc = "Extract here";
        for = "windows";
      }
    ];
    play = [
      {
        exec = ''mpv "$@"'';
        orphan = true;
        for = "unix";
      }
      {
        exec = ''mpv "%1"'';
        orphan = true;
        for = "windows";
      }
      {
        exec = ''mediainfo "$1"; echo "Press enter to exit"; read'';
        block = true;
        desc = "Show media info";
        for = "unix";
      }
    ];
  };

  open = {
    rules = [
      {
        name = "*/";
        use = [ "edit" "open" "reveal" ];
      }
      {
        mime = "text/*";
        use = [ "edit" "reveal" ];
      }
      {
        mime = "image/*";
        use = [ "open" "reveal" ];
      }
      {
        mime = "video/*";
        use = [ "play" "reveal" ];
      }
      {
        mime = "audio/*";
        use = [ "play" "reveal" ];
      }
      {
        mime = "inode/x-empty";
        use = [ "edit" "reveal" ];
      }
      {
        mime = "application/json";
        use = [ "edit" "reveal" ];
      }
      {
        mime = "*/javascript";
        use = [ "edit" "reveal" ];
      }
      {
        mime = "application/zip";
        use = [ "extract" "reveal" ];
      }
      {
        mime = "application/gzip";
        use = [ "extract" "reveal" ];
      }
      {
        mime = "application/x-tar";
        use = [ "extract" "reveal" ];
      }
      {
        mime = "application/x-bzip";
        use = [ "extract" "reveal" ];
      }
      {
        mime = "application/x-bzip2";
        use = [ "extract" "reveal" ];
      }
      {
        mime = "application/x-7z-compressed";
        use = [ "extract" "reveal" ];
      }
      {
        mime = "application/x-rar";
        use = [ "extract" "reveal" ];
      }
      {
        mime = "*";
        use = [ "open" "reveal" ];
      }
    ];
  };

  tasks = {
    micro_workers = 5;
    macro_workers = 10;
    bizarre_retry = 5;
    image_alloc = 536870912;
    image_bound = [ 0 0 ];
  };

  plugins = { preload = [ ]; };

  input = {
    cd_title = "Change directory:";
    cd_origin = "top-center";
    cd_offset = [ 0 2 50 3 ];
    create_title = "Create:";
    create_origin = "top-center";
    create_offset = [ 0 2 50 3 ];
    rename_title = "Rename:";
    rename_origin = "hovered";
    rename_offset = [ 0 1 50 3 ];
    trash_title = "Move {n} selected file{s} to trash? (y/N)";
    trash_origin = "top-center";
    trash_offset = [ 0 2 50 3 ];
    delete_title = "Delete {n} selected file{s} permanently? (y/N)";
    delete_origin = "top-center";
    delete_offset = [ 0 2 50 3 ];
    find_title = [ "Find next:" "Find previous:" ];
    find_origin = "top-center";
    find_offset = [ 0 2 50 3 ];
    search_title = "Search:";
    search_origin = "top-center";
    search_offset = [ 0 2 50 3 ];
    shell_title = [ "Shell:" "Shell (block):" ];
    shell_origin = "top-center";
    shell_offset = [ 0 2 50 3 ];
    overwrite_title = "Overwrite an existing file? (y/N)";
    overwrite_origin = "top-center";
    overwrite_offset = [ 0 2 50 3 ];
    quit_title = "{n} task{s} running, sure to quit? (y/N)";
    quit_origin = "top-center";
    quit_offset = [ 0 2 50 3 ];
  };

  select = {
    open_title = "Open with:";
    open_origin = "hovered";
    open_offset = [ 0 1 50 7 ];
  };

  log = { enabled = false; };
}
