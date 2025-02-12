{ pkgs, lib, inputs, ... }:

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
        sessionVariables.NIX_PATH = "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixpkgs";
      };
    }
    (import "${df}/nixos/modules/home-manager-s.nix" { inherit pkgs lib conf; })
