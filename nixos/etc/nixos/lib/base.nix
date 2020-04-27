{ config, pkgs, ... }:

let
  literals = import ./literals.nix pkgs;

  # also update NUR in lib/package-sets.nix
  nixpkgs = fetchTarball {
    url = "https://channels.nixos.org/nixos-20.03/nixexprs.tar.xz?2020-04-25";
    sha256 = "13jfqal1l9sgdap9599rv9azvprqb1xp6fqa2qx9pnx02mxvnq7m";
  };
  nixos-hardware = fetchTarball {
    url = "https://github.com/NixOS/nixos-hardware/archive/master.tar.gz?2020-04-25";
    sha256 = "0mgsyahm4w8ngl50fajbnjg8vw6v6pjxcjk4a7zfnnyrhfiykpqv";
  };
in

# I hope this makes sense... not sure any more
#assert builtins.readFile <nixpkgs/.version> == builtins.readFile (nixpkgs + "/.version");

{
  system.stateVersion = "19.03";
  system.autoUpgrade.enable = true;

  # grouped by singlelinedness
  security.sudo.extraConfig = "Defaults timestamp_timeout=30";
  security.sudo.configFile = literals.sudoConf;
  boot.blacklistedKernelModules = [ "pcspkr" ];
  time.timeZone = "Europe/Riga";

  nix = {
    nixPath = ["nixpkgs=${nixpkgs}:nixos-hardware=${nixos-hardware}:nixos-config=/etc/nixos/configuration.nix"];
    binaryCaches = [ "https://cache.nixos.org/" ];
    daemonNiceLevel = 19;
    daemonIONiceLevel = 19;
    # gc = { automatic = true; dates = "00:00"; }; # interesting, but no
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  networking = {
    firewall.allowedTCPPorts = [ 22 80 8080 22000 65353 ];
    networkmanager.enable = true;
    extraHosts = ''
      127.0.0.1 self
    '';
  };

  environment.etc."resolv.conf.head".text = ''nameserver 1.1.1.1'';

  users.extraUsers.s = {
    isNormalUser = true;
    uid = 1000;
    shell = pkgs.zsh;
    hashedPassword = literals.password;
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGHwoKCn9k47dD+AiLD757nRkHtjoZV0FZ6vQtujdc5J"];
    extraGroups = [ "wheel" "networkmanager" "docker" "libvirtd" "cdrom" "audio" "camera" "video" "input" ];
    subUidRanges = [{ startUid = 100000; count = 65536; }];
    subGidRanges = [{ startGid = 100000; count = 65536; }];
  };
}
