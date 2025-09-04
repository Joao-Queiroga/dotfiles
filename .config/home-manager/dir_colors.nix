{ config, ... }: {
  programs.dircolors = {
    enable = true;
    settings = {
      ln = "01;36"; # LINK
      "or" = "31;01"; # ORPHAN
      tw = "34"; # STICKY_OTHER_WRITABLE
      ow = "34"; # OTHER_WRITABLE
      st = "01;34"; # STICKY
      di = "01;34"; # DIR
      pi = "33"; # FIFO
      so = "01;35"; # SOCK
      bd = "33;01"; # BLK
      cd = "33;01"; # CHR
      su = "01;32"; # SETUID
      sg = "01;32"; # SETGID
      ex = "01;32"; # EXEC
      fi = "00"; # FILE

      #         Language colors
      "*.go" = "38;2;121;212;253";
      "*.php" = "38;5;147";
      "*.js" = "38;5;220";
      "*.c" = "38;5;33";
      "*.h" = "38;5;97";
      "*.cpp" = "38;5;33";
      "*.hpp" = "38;5;97";
      "*.html" = "38;5;202";
      "*.java" = "38;5;124";
      "*.lua" = "38;5;75";
      "*.css" = "38;5;33";
      "*.scss" = "38;5;198";
      "*.json" = "38;5;148";
      "*.py" = "38;2;255;212;59";
      "*.xml" = "38;2;145;167;141";
      "*.el" = "38;5;140";
      "*.sql" = "38;5;202";
      "*.vim" = "38;5;34";
      "*.vifm" = "38;5;34";
      "vifmrc*" = "38;5;34";
      "vimrc*" = "38;5;34";
      "*.vimrc" = "38;5;34";

      #Project  colors
      "*Makefil" = "01;38;5;130";
      "*LICENSE" = "38;5;226";
      "*README*" = "38;5;160";
      "*.md" = "0;31";
      "*.org" = "38;5;42";

      #Text     files
      "*.log" = "0;37";
      "*.txt" = "0;37";
      "*.pdf" = "38;5;160";

    };
  };
}
