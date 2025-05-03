{ config, lib, pkgs, catppuccin, ... }: {

  home.username = "muxutruk";
  home.homeDirectory = "/home/muxutruk";

  home.stateVersion = "24.11";

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  home.packages = with pkgs; [ dconf papirus-folders ];

  home.sessionVariables = { };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = lib.mkForce "Catppuccin-Macchiato-Standard-Blue-Dark";
      color-scheme = "prefer-dark";
    };

    # For Gnome shell
    "org/gnome/shell/extensions/user-theme" = {
      name = "Catppuccin-Macchiato-Standard-Blue-Dark";
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

    theme = {
      name = "catppuccin-mocha-mauve-standard";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "mauve" ];
        variant = "mocha";
      };
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "mauve";
      };
    };

    gtk3.extraConfig = gtk-extra-conf;
    gtk4.extraConfig = gtk-extra-conf;
  };
}

# vim: set shiftwidth=2 tabstop=2 :
