{ config, pkgs, ... }:

{
  imports =
  [
    ./work-p53-hardware.nix
    <nixos-hardware/lenovo/thinkpad/p53>
    ../lib/libinput.nix
  ];

  networking.hostName = "rv-p53";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #

  services = (import ../lib/xserver.nix).xfce-i3-backlight;

  # boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.cpu.intel.updateMicrocode = true;

  virtualisation.virtualbox.host = {
    enable = true;
    headless = true;
  };

  environment.systemPackages =
    (with pkgs; [ sbt openjdk nodejs yarn jetbrains.idea-community ]);
}
