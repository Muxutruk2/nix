{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    catppuccin.url = "github:catppuccin/nix";
    rust-overlay.url = "github:oxalica/rust-overlay";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, catppuccin, home-manager, rust-overlay, ... }@inputs: {
      # From here on out?
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs catppuccin;
          nixpkgs = { overlays = [ (import rust-overlay) ]; };
        };
        modules = [
          ./hosts/default/configuration.nix
          catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.home-manager
          { nixpkgs.overlays = [ (import rust-overlay) ]; }

          {
            home-manager.users.muxutruk = {
              imports =
                [ ./hosts/default/home.nix catppuccin.homeModules.catppuccin ];
            };
          }
        ];
      };

    };
}
