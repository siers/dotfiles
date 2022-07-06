{ config, pkgs, ... }:

{
  services.globalprotect.enable = true;
  environment.systemPackages = [ pkgs.globalprotect-openconnect ];
  services.resolved.enable = true;
}
