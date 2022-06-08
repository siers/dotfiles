{ config, pkgs, ... }:

let
  inherit (pkgs) writeText;

  host = config.networking.hostName;
  keys = {
    ca = writeText "${host}-ovpn-ca" config.secrets.openvpn."ca.crt";
    cert = writeText "${host}-ovpn-cert" config.secrets.openvpn."${host}".crt;
    key = writeText "${host}-ovpn-key" config.secrets.openvpn."${host}".key;
  };
in

{
  services.openvpn.servers = {
    personal = {
      config = ''
        client

        dev tun0
        remote 209.97.130.188

        # ifconfig 10.8.0.2 10.8.0.1
        port 1194
        # redirect-gateway def1

        cipher AES-256-CBC
        auth-nocache

        comp-lzo
        keepalive 10 60
        resolv-retry infinite
        nobind
        persist-key
        persist-tun

        ca ${keys.ca}
        cert ${keys.cert}
        key ${keys.key}
      '';
    };
  };
}
