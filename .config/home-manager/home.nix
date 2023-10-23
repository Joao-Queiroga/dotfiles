{ pkgs, ... }:

{
  home.username = "joaoqueiroga";
  home.homeDirectory = "/home/joaoqueiroga";

  home.stateVersion = "23.05";

  home.packages = with pkgs; [
		discord
		webcord
		teams-for-linux
		drawio
		obsidian
		wezterm
		beekeeper-studio
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

	programs = {
		yazi = {
			enable = true;
			enableZshIntegration = true;
		};
	};

  programs.home-manager.enable = true;
}
