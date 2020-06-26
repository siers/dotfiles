{ config, pkgs, ... }:

{
  imports =
  [
    ./work-p53-hardware.nix
    <nixos-hardware/lenovo/thinkpad/p53>

    ../lib/libinput.nix
    ../lib/openvpn.nix
    ../lib/printing.nix
  ];

  networking.hostName = "rv-p53";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #

  services = (import ../lib/xserver.nix).xfce-i3-backlight;

  virtualisation.virtualbox.host = {
    enable = true;
    headless = true;
  };

  environment.systemPackages = (import ../lib/package-sets.nix { inherit pkgs; }).everything ++
    (with pkgs; [
      (sbt.override { jre = openjdk11; })

      teams
      jetbrains.idea-community

      dbeaver
      kafkacat
      openjdk11
    ]);

  fonts = {
    fonts = [ pkgs.google-fonts ];
  };
}
