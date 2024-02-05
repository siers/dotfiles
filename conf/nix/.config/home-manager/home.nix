{ pkgs, lib, ... }:

let
  df = ~/dotfiles;
  conf = "${df}/conf";
in
  lib.attrsets.recursiveUpdate
    {
      home = {
        username = "raitisveinbahs";
        stateVersion = "23.05";
        homeDirectory = "/Users/raitisveinbahs";
        file.".hammerspoon/init.lua".source = "${conf}/hammerspoon/.hammerspoon/init.lua";
      };
    }
    (import "${df}/nixos/modules/home-manager-s.nix" { inherit pkgs lib conf; })
