{ config, pkgs, lib, inputs, ... }:

{
  networking.hostName = "rv-p14s";

  boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.efi.efiInstallAsRemovable = true;

  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;

  services = (import ../modules/xserver.nix).xfce-i3;
  # services = (import ../modules/xserver.nix).gnome-backlight;

  environment.systemPackages = (
    import ../packages/package-sets.nix {
      inherit pkgs;
      # inherit (pkgs.override { openjdk = inputs.nixpkgs.openjdk19; });
      neovim-flake = inputs.neovim;
    }
  ).everything ++ [
    (pkgs.sbt.override { jre = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}.jdk19; })
    inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}.youtube-dl
  ];

  programs.java.enable = true;
  programs.java.package = pkgs.jdk17;

  programs.chromium = {
    enable = true;
    extensions = config.literals.chromiumExtensions;
  };
}
