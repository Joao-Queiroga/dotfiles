{ config, pkgs, inputs, ... }:

{
  home.username = "joaoqueiroga";
  home.homeDirectory = "/home/joaoqueiroga";

  home.stateVersion = "23.05";

  home.packages = with pkgs; [
		discord
		webcord
		teams-for-linux
		drawio
		logseq
		beekeeper-studio
		inputs.st.packages.${pkgs.system}.st
  ];

	gtk = {
		enable = true;
		iconTheme = {
			package = pkgs.papirus-icon-theme;
			name = "ePapirus-Dark";
		};
		theme = {
			package = pkgs.dracula-theme;
			name = "Dracula";
		};
	};
	
  programs.home-manager.enable = true;
}
