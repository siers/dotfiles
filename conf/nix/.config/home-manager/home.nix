{ pkgs, lib, ... }:

let
  df = ~/dotfiles;
  conf = "${df}/conf";
in
  lib.attrsets.recursiveUpdate
    {
      home = {
        username = "raitisveinbahs";
        stateVersion = "25.05";
        homeDirectory = "/Users/raitisveinbahs";
        file.".hammerspoon/init.lua".source = "${conf}/hammerspoon/.hammerspoon/init.lua";
        file.abc.source = "${pkgs.neovim-unwrapped}";
        # sessionVariables.NIX_PATH = "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixpkgs";
      };
    }
    (import "${df}/nixos/modules/home-manager-s.nix" { inherit pkgs lib conf; })
