{ config, pkgs, ... }:

# this is basically for testing

/*
nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=live.nix
*/

{
  imports = [ <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix> ];
}
