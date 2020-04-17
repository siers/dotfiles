{ config, pkgs, ... }:

let
  literals = import ./literals.nix pkgs;

  # also update NUR in lib/package-sets.nix
  nixpkgs = fetchTarball {
    url = "https://nixos.org/channels/nixos-19.09/nixexprs.tar.xz?2020-04-14";
    sha256 = "1xbs2fdzgw5lkwly523aiqdw9q4qq6x4nyl69rq1pc5hm7ifk14y";
  };
  nixos-hardware = fetchTarball {
    url = "https://github.com/NixOS/nixos-hardware/archive/master.tar.gz?2020-04-14";
    sha256 = "00r28jglx47wd2gd1bcs8m44z7a6hs5d8j48f0xjvc6s512359bm";
  };
in

# I hope this makes sense... not sure any more
assert builtins.readFile <nixpkgs/.version> == builtins.readFile (nixpkgs + "/.version");

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
      127.0.0.1 self node-0 node-1 node-2 node-3 node-4 node-5 node-6 node-7 node-8 node-9
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
