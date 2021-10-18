{ config, pkgs, ... }:

let
  trace = a: builtins.trace a a;
  # also update NUR in lib/package-sets.nix
  nixpkgs = trace (fetchTarball {
    url = "https://channels.nixos.org/nixos-21.05/nixexprs.tar.xz?2021-09-09";
    sha256 = "189j2n7gz0xsvpxlw690rky5bwmzp89j450230v4csyxx2favs8s";
  });
  nixos-hardware = fetchTarball {
    url = "https://github.com/NixOS/nixos-hardware/archive/master.tar.gz?2021-09-09";
    sha256 = "18lzd51ihsdsjbv5677ngv4kvdi3gcdwp9zi4208585gkhmjjgpv";
  };
  home-manager = fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/release-21.05.tar.gz?2021-09-09";
    sha256 = "1x77fglv81rrpihkv8vnl1023hawg83k42vbflp76blgljv1sxm7";
  };
in

# I hope this makes sense... not sure any more
#assert builtins.readFile <nixpkgs/.version> == builtins.readFile (nixpkgs + "/.version");

{
  imports = [
    ./home-manager.nix
  ];

  system.stateVersion = "21.05";
  system.autoUpgrade.enable = true;

  # grouped by singlelinedness
  security.sudo.extraConfig = "Defaults timestamp_timeout=30";
  security.sudo.configFile = config.literals.sudoConf;
  boot.blacklistedKernelModules = [ "pcspkr" ];
  time.timeZone = "Europe/Riga";

  nix = {
    # package = pkgs.nixUnstable;

    # extraOptions = ''
    #   experimental-features = nix-command flakes
    # '';

    nixPath = ["nixpkgs=${nixpkgs}:nixos-hardware=${nixos-hardware}:nixos-config=/etc/nixos/configuration.nix:home-manager=${home-manager}"];
    daemonNiceLevel = 19;
    daemonIONiceLevel = 19;
    # gc = { automatic = true; dates = "00:00"; }; # interesting, but no

    binaryCaches = [
      "https://cache.nixos.org/"
      "https://all-hies.cachix.org"
    ];

    binaryCachePublicKeys = [
      "all-hies.cachix.org-1:JjrzAOEUsD9ZMt8fdFbzo3jNAyEWlPAwdVuHw4RD43k="
    ];

    trustedUsers = [ "root" "s" ];
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  networking = {
    firewall.enable = true;
    firewall.allowedTCPPorts = [ 22 8080 65353 ];
    networkmanager.enable = true;
    extraHosts = ''
      127.0.0.1 self
      ${config.literals.privateExtraHosts}
    '';
  };

  environment.etc."resolv.conf.head".text = ''nameserver 1.1.1.1'';

  users.extraUsers.s = {
    isNormalUser = true;
    uid = 1000;
    shell = pkgs.zsh;
    hashedPassword = config.literals.password;
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGHwoKCn9k47dD+AiLD757nRkHtjoZV0FZ6vQtujdc5J"];
    extraGroups = [ "wheel" "networkmanager" "docker" "libvirtd" "cdrom" "audio" "camera" "video" "input" ];
    subUidRanges = [{ startUid = 100000; count = 65536; }];
    subGidRanges = [{ startGid = 100000; count = 65536; }];
  };
}
