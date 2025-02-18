{ config, pkgs, ... }:

{
	home.username = "muxutruk";
	home.homeDirectory = "/home/muxutruk";

	home.stateVersion = "24.11";

	xdg.portal.enable = true;
	xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];


	home.file = {
		"hypr" = {
			source = ./dotfiles/hypr;
			target = "/home/muxutruk/.config/hypr";
		};
		"waybar" = {
			source = ./dotfiles/waybar;
			target = "/home/muxutruk/.config/waybar";
		};
		"wezterm" = {
			source = ./dotfiles/wezterm;
			target = "/home/muxutruk/.config/wezterm";
		};
		"tmux" = {
			source = ./dotfiles/tmux/tmux.conf;
			target = "/home/muxutruk/.tmux.conf";
		};
		".config/nvim" = {
			source = ./dotfiles/nvim;
			target = ".config/nvim";
		};

	};

	programs.fish = {
		enable = true;
		interactiveShellInit = ''
			if status is-interactive
				set EDITOR /usr/bin/nvim
					end

					fish_hybrid_key_bindings

					if type -q fortune
						set -U fish_greeting (fortune)
					else
						set -U fish_greeting ""
							end

							set XDG_PICTURES_DIR $HOME/Pictures
							set XDG_CONFIG_DIRS "$HOME/.config"
							set -x QT_QPA_PLATFORMTHEME qt5ct

							fish_add_path $HOME/.cargo/bin
							fish_add_path $HOME/.local/bin

							if test -f "$HOME/.cargo/env.fish"
								source "$HOME/.cargo/env.fish"
									end
									'';

		plugins = [
		{ name = "done"; src = pkgs.fishPlugins.done.src;}
		{ name = "transient-fish"; src = pkgs.fishPlugins.transient-fish.src;}
		{ name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src;}
		{ name = "puffer"; src = pkgs.fishPlugins.puffer.src;}
		{ name = "pisces"; src = pkgs.fishPlugins.pisces.src;}
		{ name = "colored-man-pages"; src = pkgs.fishPlugins.colored-man-pages.src;}
		{ name = "gruvbox"; src = pkgs.fishPlugins.gruvbox.src;}
		{ name = "z"; src = pkgs.fishPlugins.z.src;}
		];

	};
	home.sessionVariables = {};
}

# vim: set shiftwidth=2 tabstop=2 :
