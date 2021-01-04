{ config, pkgs, ... }:

{
  imports =
    [
      ./lib/literals-option.nix
      ./lib/base.nix
      ./lib/audio.nix
      ./lib/services.nix
      ./lib/dev.nix
      ./lib/gnome-support.nix
      ./lib/fonts.nix
      ./lib/prometheus.nix
    ];
}
