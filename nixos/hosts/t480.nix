{ config, pkgs, ... }:

{
  networking.hostName = "t480";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # services = (import ../modules/xserver.nix).xfce-i3-backlight;
  services = (import ../modules/xserver.nix).gnome-backlight;

  users.extraGroups.vboxusers.members = [ "s" ];

  environment.systemPackages = (import ../modules/package-sets.nix { inherit pkgs; }).everything ++ [
    pkgs.transmission-gtk
    # pkgs.kdenlive
  ];

  programs.java = {
    enable = true;
    package = pkgs.jdk8;
  };
}
