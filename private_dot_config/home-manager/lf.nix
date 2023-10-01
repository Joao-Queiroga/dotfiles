{ pkgs, config, ... }:
{
	programs.lf = {
		enable = true;
		commands = {
			dragon = ''%''$${pkgs.xdragon}/bin/xdragon -a -x "$fx"'';
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
			hidden = true;
			drawbox = true;
			icons = true;
			ignorecase = true;
		};
		extraConfig =
		let
			previewer = pkgs.writeShellScriptBin "pv.sh" ''
				file=$1
				w=$2
				h=$3
				x=$4
				y=$5

				if [[ "$( ${pkgs.file}/bin/file -Lb --mime-type "$file")" =~ ^image ]]; then
					${pkgs.kitty}/bin/kitty +kitten icat --silent --stdin no --transfer-mode file --place "''${w}x''${h}@''${x}x''${y}" "$file" < /dev/null > /dev/tty
					exit 1
				fi

				${pkgs.pistol}/bin/pistol "$file"
			'';
			cleaner = pkgs.writeShellScriptBin "clean.sh" ''
				${pkgs.kitty}/bin/kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
			'';
		in
		''
			set previewer ${previewer}/bin/pv.sh
			set cleaner ${cleaner}/bin/clean.sh
		'';
	};
}
