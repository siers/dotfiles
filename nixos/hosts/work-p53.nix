{ config, pkgs, lib, inputs, ... }:

let
  services = {
    nginx = {
      enable = false;

      user = "s";
      group = "users";
      additionalModules = [ pkgs.nginxModules.rtmp ];

      appendConfig = ''
        rtmp {
          server {
            listen 1935;
            chunk_size 4096;
            application live {
              live on;
              record off;
              hls on;
              # hls_path /tmp/hls;
              hls_path /home/s/code/desktop/2023-10-13-webcam-broadcast/hls-gist/hls;
              # hls_fragment 3;
              # hls_playlist_length 60;
              dash on;
              dash_path /tmp/dash;
            }
            # application webcam {
            #   live on;
            #   record off;
            #   exec_static ffmpeg -f video4linux2 -i /dev/video0 -s 320x240 -c:v libx264 -an -f flv rtmp://localhost:1935/webcam/mystream;
            # }
          }
        }
      '';

      appendHttpConfig = ''
        server {
          # listen 65353;

          add_header Cache-Control no-cache;
          add_header Access-Control-Allow-Origin *;

          # location /h {
          #   autoindex on;
          #   rewrite ^/h/(.*)$ /$1 last;
          #   autoindex on;
          #   root /home/s;
          # }
          location / {
            root /home/s/code/desktop/2023-10-13-webcam-broadcast/hls-gist;
          }
          location /stat {
            rtmp_stat all;
          }
          location /hls {
            types {
              application/vnd.apple.mpegurl m3u8;
              video/mp2t ts;
            }
            # root /tmp;
            root /home/s/code/desktop/2023-10-13-webcam-broadcast/hls-gist;
          }
          location /dash {
            root /tmp;
          }
        }
      '';
    };
  };
in
{
  networking.hostName = "rv-p14s";

  boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.efi.efiInstallAsRemovable = true;

  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;

  services =
    lib.attrsets.recursiveUpdate
    # (import ../modules/xserver.nix).gnome-backlight
    (import ../modules/xserver.nix).xfce-i3
    services;
  # services = (import ../modules/xserver.nix).gnome-backlight;

  environment.systemPackages = (
    import ../packages/package-sets.nix {
      inherit pkgs;
      # inherit (pkgs.override { openjdk = inputs.nixpkgs.openjdk19; });
      neovim-flake = inputs.neovim;
    }
  ).everything ++ [
    # (pkgs.sbt.override { jre = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}.jdk19; })
    pkgs.jdk19
    pkgs.scala
    pkgs.glxinfo
  ];

  programs.java.enable = true;
  programs.java.package = pkgs.jdk17;

  programs.chromium = {
    enable = true;
    extensions = config.literals.chromiumExtensions;
  };

  systemd.services.nginx.serviceConfig.ProtectHome = "read-only";
  systemd.services.nginx.serviceConfig.ReadWritePaths = [
    "/home/s/code/desktop"
  ];
}
