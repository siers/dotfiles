{ config, pkgs, inputs, ... }:

let
  conf = ../../conf;
  home = import ./home-manager-s.nix { inherit conf; };
in {
  home-manager.users.s = home;
  home-manager.users.d = home;
}
