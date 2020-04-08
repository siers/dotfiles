{ config, pkgs, ... }:

{
  imports =
  [
    ./t490-hardware.nix
    <nixos-hardware/lenovo/thinkpad/t490>
    ../lib/libinput.nix
  ];

  networking.hostName = "t490";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #

  services = (import ../lib/xserver.nix).xfce-i3-backlight;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.cpu.intel.updateMicrocode = true;

  virtualisation.virtualbox.host = {
    enable = true;
    headless = true;
  };

  environment.systemPackages =
    (import ../lib/package-sets.nix { inherit pkgs; }).everything ++
    (with pkgs; [ sbt openjdk nodejs yarn ]);
}
