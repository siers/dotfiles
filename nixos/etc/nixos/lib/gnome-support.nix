{ config, pkgs, ... }:

/*
https://nixos.wiki/wiki/GNOME
eog complains about no dconf, so let's make it work better when I'm using i3
*/

{
  programs.dconf.enable = true;
  environment.systemPackages = [ pkgs.gnome3.adwaita-icon-theme ];
}
