{ config, pkgs, ... }:

with (import ./private.nix {});

{
  networking.extraHosts = "127.0.0.1 ${site1}";

  services.nginx = {
    enable = true;

    virtualHosts."${site1}" = {
      listen = [{ addr = "0.0.0.0"; port = 8080; }];

      locations."/build".extraConfig = ''
        proxy_pass http://0.0.0.0:4000$request_uri;
      '';
      locations."/web".extraConfig = ''
        proxy_pass http://0.0.0.0:4000$request_uri;
      '';
      locations."/".extraConfig = ''
        proxy_pass http://0.0.0.0:8088$request_uri;
      '';
    };
  };
}
