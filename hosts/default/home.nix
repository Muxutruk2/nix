{ config, pkgs, inputs, ... }:

{
	imports = [
		inputs.nvf.homeManagerModules.default
			./modules/home-manager/fish.nix
			./modules/home-manager/hypr.nix
			./modules/home-manager/vesktop.nix
			./modules/home-manager/waybar.nix
			./modules/home-manager/wezterm.nix
			./modules/home-manager/tmux.nix
			./modules/home-manager/nvf.nix
	];

	home.username = "muxutruk";
	home.homeDirectory = "/home/muxutruk";

	home.stateVersion = "24.11";

	xdg.portal.enable = true;
	xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

	home.sessionVariables = {};
}

# vim: set shiftwidth=2 tabstop=2 :
