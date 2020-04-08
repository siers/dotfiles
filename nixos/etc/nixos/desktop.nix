{ config, pkgs, ... }:

let
  literals = import ./lib/literals.nix pkgs;

  stow-home = pkgs.writeShellScriptBin "stow-home" ''
    ${pkgs.utillinux}/bin/runuser -u s touch ~s/touch-sudo
  '';
in

{
  imports =
    [
      ./lib/base.nix
      ./lib/audio.nix
      ./lib/services.nix
      ./lib/dev.nix
    ];

  syncthing.enable = true;

  systemd.services.stow = {
    wantedBy = [ "multi-user.target" ];
    description = "stow files";
    serviceConfig = {
      Type = "simple";
      User = "root";
      ExecStart = ''${stow-home}/bin/stow-home'';
    };
  };
}
