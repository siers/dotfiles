{ config, pkgs, ... }:

{
  imports =
    [
      ./misc/podman.nix
    ];

  virtualisation = {
    # libvirtd.enable = true;
    docker = {
      # enable = true;
      # extraOptions = "--iptables=false";
    };
  };
}
