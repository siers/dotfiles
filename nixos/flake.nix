# nixos-rebuild switch --upgrade --recreate-lock-file -L
{
  description = "A very basic flake";

  inputs = {
    nixpkgs = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixos-unstable";
      # ref = "nixos-22.11";
    };

    # nixpkgs-unstable = {
    #   type = "github";
    #   owner = "NixOS";
    #   repo = "nixpkgs";
    #   ref = "nixos-unstable";
    # };

    nixos-hardware = {
      type = "github";
      owner = "NixOS";
      repo = "nixos-hardware";
      ref = "master";
    };

    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      ref = "master";
    };

    neovim = {
      type = "github";
      owner = "neovim";
      repo = "neovim";
      ref = "nightly";
      dir = "contrib";
    };

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    secrets.url = "path:/home/s/code/nix/secrets";
  };

  outputs = { self, nixos-hardware, ... }@inputs:
    let
      commonModules = [
        inputs.home-manager.nixosModules.home-manager
        ./modules/literals.nix
        ./modules/base.nix
        ./modules/home-manager.nix
        ./modules/services.nix
        ./modules/fonts.nix
        #./modules/prometheus.nix
        inputs.secrets.nixosModules.default
      ];
    in {
      nixosConfigurations = {
        t480 = inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = commonModules ++ [
            ./hosts/t480.nix
            ./hosts/t480-hardware.nix
            ./modules/openvpn.nix
            ./modules/backlight.nix
            nixos-hardware.nixosModules.lenovo-thinkpad-t480
          ];
        };
        rv-p14s = inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = commonModules ++ [
            ./hosts/work-p53.nix
            ./hosts/work-p53-hardware.nix
            ./modules/openvpn.nix
            ./modules/backlight.nix
            ./modules/openconnect.nix
            nixos-hardware.nixosModules.lenovo-thinkpad-p52
          ];
        };
      };
    };
}
