{ config, pkgs, ... }:

{
  imports =
    [
      ./desktop.nix
      ./hosts/inspiron.nix
    ];
}
