{ config, pkgs, ... }:

{
  imports =
    [
      ./desktop.nix
      ./hosts/toshiba.nix
    ];
}
