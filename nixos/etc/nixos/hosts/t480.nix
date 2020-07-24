{ config, pkgs, ... }:

{
  imports =
  [
    ./t480-hardware.nix
    <nixos-hardware/lenovo/thinkpad/t480s>

    ../lib/libinput.nix
    ../lib/openvpn.nix
    ../lib/printing.nix
    ../lib/backlight.nix
  ];

  networking.hostName = "t480";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #

  services = (import ../lib/xserver.nix).xfce-i3-backlight; # .gnome-backlight;

  virtualisation.virtualbox.host = {
    enable = true;
    headless = true;
  };

  environment.systemPackages = (import ../lib/package-sets.nix { inherit pkgs; }).everything;
}
