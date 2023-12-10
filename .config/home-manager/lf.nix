{ pkgs, ... }:
{
  programs.lf = {
    enable = true;
    commands = {
      on-cd = ''&{{
				export STARSHIP_SHELL=
				fmt="$(${pkgs.starship}/bin/starship prompt)"
				${pkgs.lf}/bin/lf -remote "send $id set promptfmt \"$fmt\""
			}}'';
      on-select = ''&{{
				${pkgs.lf}/bin/lf -remote "send $id set statfmt \"$(${pkgs.eza}/bin/eza -ld --color=always "$f")\""
			}}'';
      open = ''
        ''${{
        	test -L "$f" && f=$(readlink -f $f)
        	case $(${pkgs.file}/bin/file --mime-type $f -b) in
        		text/*|application/json|application/javascript|application/xml) $EDITOR "$f";;
        		*) xdg-open "$f";;
        	esac
        }}
      '';
      drag = ''& ${pkgs.ripdrag}/bin/ripdrag -a -x $fx'';
      edit = ''$$EDITOR $f'';
      mkdir = ''
        ''${{
        	printf "Enter directory name: "
        	read DIR
        	mkdir $DIR
        }}
      '';
    };
    settings = {
      preview = true;
      hidden = false;
      drawbox = true;
      icons = true;
      ignorecase = true;
    };
    keybindings = {
      "." = "set hidden!";
      V = ''''$${pkgs.bat}/bin/bat --paging=always "$f"'';
      "<c-d>" = "drag";
    };
    extraConfig =
      let
        previewer = pkgs.writeShellScriptBin "pv.sh" ''
          file=$1
          w=$2
          h=$3
          x=$4
          y=$5

          image() {
          	${pkgs.kitty}/bin/kitty +kitten icat --silent --stdin no --transfer-mode file --place "''${w}x''${h}@''${x}x''${y}" "$1" < /dev/null > /dev/tty
          	exit 1
          }

          case "$( ${pkgs.file}/bin/file -Lb --mime-type "$file")" in
          	image/*) image "$file";;
          	video/*)
          		CACHE="''${XDG_CACHE_HOME:-$HOME/.cache}/lf/thumb.$(stat --printf '%n\0%i\0%F\0%s\0%W\0%Y' -- "$(readlink -f "$file")" | sha256sum | cut -d' ' -f1)"
          		[ ! -f "$CACHE" ] && ${pkgs.ffmpegthumbnailer}/bin/ffmpegthumbnailer -i "$file" -o "$CACHE" -s 0
          		image "$CACHE"
          		;;
          	application/pdf)
          			CACHE="''${XDG_CACHE_HOME:-$HOME/.cache}/lf/thumb.$(stat --printf '%n\0%i\0%F\0%s\0%W\0%Y' -- "$(readlink -f "$1")" | sha256sum | cut -d' ' -f1)"
          			[ ! -f "$CACHE.jpg" ] && ${pkgs.poppler_utils}/bin/pdftoppm -jpeg -f 1 -singlefile "$1" "$CACHE"
          			image "$CACHE.jpg" "$2" "$3" "$4" "$5" "$1"
          			;;
          	*) ${pkgs.pistol}/bin/pistol "$file";;
          esac
        '';
        cleaner = pkgs.writeShellScriptBin "clean.sh" ''
          ${pkgs.kitty}/bin/kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
        '';
      in
      ''
        set previewer ${previewer}/bin/pv.sh
        set cleaner ${cleaner}/bin/clean.sh
        on-cd
        on-select
      '';
  };
}
