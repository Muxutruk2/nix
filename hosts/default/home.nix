{ config, lib, pkgs, catppuccin, ... }: {

  home.username = "muxutruk";
  home.homeDirectory = "/home/muxutruk";

  home.stateVersion = "24.11";

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  home.packages = with pkgs; [ dconf papirus-folders catppuccin-gtk yazi ];

  home.sessionVariables = { };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = lib.mkForce "catppuccin-mocha-sapphire-standard+default";
      color-scheme = "prefer-dark";
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "catppuccin-mocha-sapphire-standard+default";
    };
  };

  gtk = let
    gtk-extra-conf = {
      gtk-application-prefer-dark-theme = true;
      gtk-button-images = true;
      gtk-menu-images = true;
      gtk-error-bell = false;
    };
  in {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "sapphire";
      };
    };

    gtk3.extraConfig = gtk-extra-conf;
    gtk4.extraConfig = gtk-extra-conf;
  };

  home.sessionVariables = {
    GTK_THEME = "catppuccin-mocha-sapphire-standard+default";
  };

  services.poweralertd = {
    enable = true;
    extraArgs = [ "-s" "-S" ];
  };

}
# vim: set shiftwidth=2 tabstop=2 :
