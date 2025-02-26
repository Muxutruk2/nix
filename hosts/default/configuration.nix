# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
		./hardware-configuration.nix
			inputs.home-manager.nixosModules.home-manager
		];
	hardware.graphics.enable = true;
# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "nixos"; # Define your hostname.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.


# Enable networking
		networking.networkmanager.enable = true;

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;	
		alsa.support32Bit = true;	
		pulse.enable = true;	
		jack.enable = true;	
	};
# Set your time zone.
	time.timeZone = "Europe/Madrid";

# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";

	i18n.extraLocaleSettings = {
		LC_ADDRESS = "es_ES.UTF-8";
		LC_IDENTIFICATION = "es_ES.UTF-8";
		LC_MEASUREMENT = "es_ES.UTF-8";
		LC_MONETARY = "es_ES.UTF-8";
		LC_NAME = "es_ES.UTF-8";
		LC_NUMERIC = "es_ES.UTF-8";
		LC_PAPER = "es_ES.UTF-8";
		LC_TELEPHONE = "es_ES.UTF-8";
		LC_TIME = "es_ES.UTF-8";
	};

# Configure keymap in X11
	services.xserver.xkb = {
		layout = "es";
		variant = "";
	};

# Configure console keymap
	console.keyMap = "es";

# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.muxutruk = {
		isNormalUser = true;
		description = "Muxutruk";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [];
	};

	home-manager = {
		extraSpecialArgs = { inherit inputs; };
		users = {
			"muxutruk" = import ./home.nix;
		};
	};

# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

# List packages installed in system profile. To search, run:
# $ nix search wget
	environment.systemPackages = with pkgs; [
		home-manager
			gh
			vim
			wget
			git
			hyprland
			waybar
			(waybar.overrideAttrs (oldAttrs: {mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];}))
			wezterm
			nemo
			rofi-wayland
			networkmanagerapplet
			swww
			flameshot
			hyprpolkitagent
			dunst
			libnotify
			hyprlock
			wireplumber
			sway-contrib.grimshot
			playerctl
			networkmanagerapplet	
			pciutils
			firefox
			fzf
			fd
			bat
			tmux
			fish
			fishPlugins.done
			fishPlugins.transient-fish
			fishPlugins.fzf-fish
			fishPlugins.puffer
			fishPlugins.pisces
			fishPlugins.colored-man-pages
			fishPlugins.gruvbox
			fishPlugins.z
			neovim
			ripgrep
			fd
			tree-sitter
			gcc
			cargo
			unzip
			lua-language-server
			xclip
			wl-clipboard
			rust-analyzer
			nil # Nix LSP
			lua-language-server
			pyright
			bash-language-server
			jdt-language-server # Java
			vscode-langservers-extracted # HTML, CSS, JSON, JavaScript LSP
			stylua # Lua formatter
			ruff # Python linter
			black # Python formatter
			shellcheck # Bash linter
			shfmt # Bash formatter
			clang-tools 
			vesktop
			xdg-utils
			xwayland
			gh
			dig
			nmap
			localsend
			pqiv
			cargo-watch
			noto-fonts
			];

	fonts.packages = with pkgs; [
		nerd-fonts.caskaydia-cove
	];
	fonts.fontconfig.enable = true;
	environment.variables.EDITOR = "nvim";



# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

# List services that you want to enable:

# Enable the OpenSSH daemon.
	services.openssh.enable = true;

# Open ports in the firewall.
	networking.firewall.allowedTCPPorts = [ 22 53317 ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;
# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "24.11"; # Did you read the comment?

}
# vim: set shiftwidth=2 tabstop=2 :
