{ config, pkgs, lib, ... }:

{
  networking.hostName = "rv-p53";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;

  services = (import ../modules/xserver.nix).xfce-i3;
  # services = (import ../modules/xserver.nix).gnome-backlight;

  environment.systemPackages = (import ../modules/package-sets.nix { inherit pkgs; }).everything ++ [
    (pkgs.sbt.override { jre = pkgs.jdk17; })
  ];

  programs.java.enable = true;
  programs.java.package = pkgs.jdk17;

  programs.chromium = {
    enable = true;
    extensions = config.literals.chromiumExtensions;
  };
}
