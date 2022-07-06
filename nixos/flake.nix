# nixos-rebuild switch --upgrade --recreate-lock-file -L
{
  description = "A very basic flake";

  inputs = {
    nixpkgs = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixos-22.05";
    };

    nixpkgs-unstable = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixos-unstable";
    };

    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      ref = "release-22.05";
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
        ./modules/dev.nix
        ./modules/gnome-support.nix
        ./modules/fonts.nix
        #./modules/prometheus.nix
        inputs.secrets.nixosModules.default
      ];
    in {
      nixosConfigurations = {
        t480 = inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = commonModules ++ [
            ./hosts/t480.nix
            ./hosts/t480-hardware.nix
            ./modules/user/ld.nix
            ./modules/openvpn.nix
            nixos-hardware.nixosModules.lenovo-thinkpad-t480
          ];
        };
        rv-p53 = inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = commonModules ++ [
            ./hosts/work-p53.nix
            ./hosts/work-p53-hardware.nix
            ./modules/libinput.nix
            ./modules/openvpn.nix
            ./modules/backlight.nix
            #./modules/printing.nix
            # /home/s/work/conf/evolution.nix
            ./modules/openconnect.nix
            nixos-hardware.nixosModules.lenovo-thinkpad-p53
          ];
        };
      };
    };
}
