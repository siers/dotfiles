{ config, pkgs, ... }:

{
  imports =
    [
      ./desktop.nix
      ./hosts/acer.nix
    ];
}
