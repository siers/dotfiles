{ config, pkgs, ... }:

let
  literals = import ./lib/literals.nix pkgs;
in

{
  imports =
    [
      ./lib/base.nix
      ./lib/audio.nix
      ./lib/services.nix
      ./lib/dev.nix
    ];
}
