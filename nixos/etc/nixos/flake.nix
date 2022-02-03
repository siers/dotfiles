{
  description = "A very basic flake";

  inputs = {
    nixpkgs = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixos-21.11";
    };

    nixpkgs-unstable = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixos-unstable";
    };

    nixpkgs-master = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "master";
    };

    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      ref = "release-21.11";
    };
  };

  outputs = { self, ... }@inputs:
    let
      commonModules = [
        inputs.home-manager.nixosModules.home-manager
        ./modules/literals-option.nix
        ./modules/base.nix
        ./modules/audio.nix
        ./modules/services.nix
        ./modules/dev.nix
        ./modules/gnome-support.nix
        ./modules/fonts.nix
        ./modules/prometheus.nix
      ];
    in {
      nixosConfigurations = {
        t480 = inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = commonModules ++ [
            ./hosts/t480/configuration.nix
            ./hosts/t480/hardware-configuration.nix
          ];
        };
        rv-p53 = inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = commonModules ++ [
            ./hosts/rv-p53/configuration.nix
            ./hosts/rv-p53/hardware-configuration.nix
          ];
        };
      };
    };
}
