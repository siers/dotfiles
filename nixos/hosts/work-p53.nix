{ config, pkgs, lib, inputs, ... }:

{
  networking.hostName = "rv-p14s";

  boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.efi.efiInstallAsRemovable = true;

  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;

  services =
    lib.attrsets.recursiveUpdate
    (import ../modules/xserver.nix).gnome-backlight
    # (import ../modules/xserver.nix).xfce-i3
    {
      apache-kafka.enable = true;
      zookeeper.enable = true;
      cassandra.enable = true;

    };
  # services = (import ../modules/xserver.nix).gnome-backlight;

  nixpkgs.config.permittedInsecurePackages = [
    "python-2.7.18.6"
  ];

  environment.systemPackages = (
    import ../packages/package-sets.nix {
      inherit pkgs;
      # inherit (pkgs.override { openjdk = inputs.nixpkgs.openjdk19; });
      neovim-flake = inputs.neovim;
    }
  ).everything ++ [
    (pkgs.sbt.override { jre = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}.jdk19; })
    pkgs.scala
    pkgs.glxinfo
    inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}.youtube-dl
    pkgs.teams
  ];

  programs.java.enable = true;
  programs.java.package = pkgs.jdk17;

  programs.chromium = {
    enable = true;
    extensions = config.literals.chromiumExtensions;
  };
}
