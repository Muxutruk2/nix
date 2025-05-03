# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ pkgs, inputs, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    # inputs.nvf.nixosModules.default
    # ./modules/nixos/nvf.nix
  ];

  hardware.graphics.enable = true;
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  security.sudo.extraConfig =
    ''Defaults env_keep += "DISPLAY WAYLAND_DISPLAY XDG_RUNTIME_DIR" '';

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  time.timeZone = "Europe/Madrid";

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
  };

  nixpkgs.config.allowUnfree = true;

  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # System Utilities
    coreutils
    glib
    git
    grc
    home-manager
    lazygit
    networkmanagerapplet
    openssl
    pciutils
    pkg-config
    wget

    # Terminal and Shell Utilities
    bat
    chezmoi
    eza
    fd
    fish
    fzf
    kitty
    neovim
    ripgrep
    tmux
    tree-sitter
    vim
    wezterm

    # Fish Shell Plugins
    fishPlugins.colored-man-pages
    fishPlugins.done
    fishPlugins.fzf-fish
    fishPlugins.gruvbox
    fishPlugins.pisces
    fishPlugins.puffer
    fishPlugins.transient-fish
    fishPlugins.z

    # Hyprland Environment
    hyprland
    hyprpaper
    hyprpolkitagent
    waybar

    # Wayland and GUI Utilities
    adw-gtk3
    brightnessctl
    grim
    kde-gtk-config
    papirus-icon-theme
    qt6ct
    rofi-wayland
    slurp
    swww
    xdg-desktop-portal
    xdg-desktop-portal-hyprland
    xdg-utils
    xwayland
    xfce.thunar
    xfce.tumbler
    libsForQt5.breeze-gtk
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum

    # Audio and Media Tools
    flameshot
    libnotify
    obs-studio
    obs-studio-plugins.wlrobs
    playerctl
    pqiv
    vlc
    wireplumber

    # Browsers and Internet Apps
    firefox
    ungoogled-chromium
    vieb
    vesktop

    # File Management and GUI Tools
    appeditor
    dunst
    nemo
    glance

    # Clipboard Utilities
    wl-clipboard

    # Fonts
    font-awesome
    noto-fonts

    # Documentation and Manpages
    linux-manual
    man-pages
    man-pages-posix

    # Networking and Security Tools
    dig
    gh
    localsend
    nmap

    # Miscellaneous Tools
    qbittorrent
    sway-contrib.grimshot

    # Development - General Tools
    unzip
    nil
    nixfmt
    shellcheck
    shfmt
    vscode-langservers-extracted

    # Development - C and C++
    autoconf
    automake
    binutils
    clang
    clang-tools
    cmake
    gcc
    gdb
    gnumake
    libcxx
    libtool
    lld
    lldb
    m4
    ninja
    pkg-config
    valgrind

    # Development - Rust
    cargo
    cargo-watch
    rust-analyzer
    rustfmt
    rustup

    # Development - Python
    black
    pyright
    python314
    ruff

    # Development - Java
    jdt-language-server

    # Development - Lua
    lua-language-server
    stylua

    # Development - JavaScript / Web
    nodejs

    # Development - Bash
    bash-language-server

  ];

  fonts.packages = with pkgs; [
    nerd-fonts.caskaydia-cove
    noto-fonts
    font-awesome
  ];

  fonts.fontconfig.enable = true;

  environment.variables = {
    GTK_THEME = "Catppuccin-Mocha-Standard-Mauve-Dark";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_STYLE_OVERRIDE = "Catppuccin-Mocha";
    GDK_SCALE = "1";
  };

  documentation.enable = true;
  documentation.man.enable = true;
  documentation.dev.enable = true;
  documentation.man.generateCaches = false;

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  programs.dconf.enable = true;

  programs.nix-ld.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 53317 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;

  system.stateVersion = "25.05"; # Did you read the comment?
}
