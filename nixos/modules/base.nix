{ config, pkgs, inputs, ... }:

{
  system.stateVersion = "23.05";
  system.autoUpgrade.enable = true;

  security.sudo.extraConfig = "Defaults timestamp_timeout=30";

  boot.blacklistedKernelModules = [ "pcspkr" ];
  time.timeZone = "Europe/Riga";

  nix = {
    package = pkgs.nixUnstable;

    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    binaryCaches = [
      "https://cache.nixos.org/"
      "https://all-hies.cachix.org"
    ];

    binaryCachePublicKeys = [
      "all-hies.cachix.org-1:JjrzAOEUsD9ZMt8fdFbzo3jNAyEWlPAwdVuHw4RD43k="
    ];

    trustedUsers = [ "root" "s" ];

    nixPath = [
      "nixpkgs=/etc/channels/nixpkgs"
      "nixos-config=/etc/nixos/configuration.nix"
      "/nix/var/nix/profiles/per-user/root/channels"
    ];
  };

  environment.etc."channels/nixpkgs".source = inputs.nixpkgs.outPath;

  nixpkgs.config.allowUnfree = true;

  networking = {
    firewall.enable = true;
    firewall.allowedTCPPorts = [ 22 8080 65353 ];
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
    hashedPassword = config.secrets.password;
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGHwoKCn9k47dD+AiLD757nRkHtjoZV0FZ6vQtujdc5J"];
    extraGroups = [ "wheel" "networkmanager" "docker" "libvirtd" "cdrom" "audio" "camera" "video" "input" ];
    subUidRanges = [{ startUid = 100000; count = 65536; }];
    subGidRanges = [{ startGid = 100000; count = 65536; }];
  };
}
