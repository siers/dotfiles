{ config, pkgs, ... }:

/*
nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=live.nix
*/

{
  imports =
    [
      <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
      ./desktop.nix
    ];

  networking.hostName = "nixos-live";
  networking.wireless.enable = false;

  programs = {
    zsh.enable = true;
  }

  services = (import lib/xserver.nix).dm "xfce";

  isoImage.contents = [
    {
      source = toString ./image;
      target = "home/s.enc";
    }
  ];
}
