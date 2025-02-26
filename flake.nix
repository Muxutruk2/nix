{
	description = "Nixos config flake";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		nixvim.url = "github:nix-community/nixvim";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		nvf = {
			url = "github:notashelf/nvf";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, home-manager, nvf, ... }@inputs: {
		nixosConfigurations.default = nixpkgs.lib.nixosSystem {
			specialArgs = {
				inherit inputs;
				homeManagerSettings = {
					useGlobalPkgs = true;
					useUserPackages = true;
				};
			};
			modules = [
					./hosts/default/configuration.nix
					({
					 config, pkgs, specialArgs, ...
					 }: {
					 home-manager.useGlobalPkgs = specialArgs.homeManagerSettings.useGlobalPkgs;
					 home-manager.useUserPackages = specialArgs.homeManagerSettings.useUserPackages;
					 home-manager.users.muxutruk = import ./hosts/default/home.nix;
					 })

			];
		};
	};
}
