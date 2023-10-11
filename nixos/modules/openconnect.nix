{ config, pkgs, ... }:

{
  services.globalprotect.enable = true;
  environment.systemPackages = [ pkgs.globalprotect-openconnect ];
  services.resolved.enable = true;

  # nixpkgs.overlays = [
  #   (self: super: {
  #     globalprotect-openconnect = super.globalprotect-openconnect.overrideAttrs
  #       (old: rec {
  #         version = "1.4.7";
  #         src = super.fetchFromGitHub {
  #           owner = "yuezk";
  #           repo = "GlobalProtect-openconnect";
  #           fetchSubmodules = true;
  #           rev = "v${version}";
  #           sha256 = "sha256-MNH6zizPX3tcFsEPC5w0lr48KlV578kYe+f5v8Qc5FY=";
  #         };
  #       });
  #   })
  # ];
}
