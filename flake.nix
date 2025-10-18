{
  description = "NixOS and Home Manager configuration of hayatroid";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/nixos-wsl";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, nixos-wsl, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations."hayatroid" = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          ./nixos/configuration.nix
          nixos-wsl.nixosModules.wsl
        ];
      };

      homeConfigurations."hayatroid" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./home-manager/home.nix
        ];
      };
    };
}
