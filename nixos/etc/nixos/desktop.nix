{ config, pkgs, ... }:

let
  literals = import ./lib/literals.nix pkgs;
  nixpkgs = fetchTarball {
    url = "https://nixos.org/channels/nixos-19.09/nixexprs.tar.xz?2019-11-20";
    sha256 = "0nvk4nfr7irshdg2m3gza4n6himvkdsd3ai3rbcinx8f6ag38qka";
  };
  nixos-hardware = fetchTarball {
    url = "https://github.com/NixOS/nixos-hardware/archive/master.tar.gz?2019-11-20";
    sha256 = "10v0wz4b6z2qcmg4ifqszfb1g7xvm8gggbdglb8lzf21ms6550ac";
  };
  # also update NUR in lib/package-sets.nix
in

# I hope this makes sense... not sure any more
assert builtins.readFile <nixpkgs/.version> == builtins.readFile (nixpkgs + "/.version");

{
  imports =
    [
      ./lib/audio.nix
      ./lib/podman.nix
    ];

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

  networking = {
    firewall.allowedTCPPorts = [ 22 80 8080 22000 65353 ];
    networkmanager.enable = true;
    extraHosts = ''
      127.0.0.1 self node-0 node-1 node-2 node-3 node-4 node-5 node-6 node-7 node-8 node-9
    '';
  };

  environment.etc."resolv.conf.head".text = ''nameserver 1.1.1.1'';

  nixpkgs.config = {
    allowUnfree = true;
  };

  virtualisation = {
    libvirtd.enable = true;
    docker = {
      enable = true;
      # extraOptions = "--iptables=false";
    };
  };

  services = {
    cron.enable    = true;
    dbus.enable    = true;
    ntp.enable     = true;
    openssh.enable = true;

    avahi = {
      enable = true;
      publish.enable = true;
      publish.addresses = true;
      nssmdns = true;
      reflector = true;
      allowPointToPoint = true;
    };

    logind = {
      lidSwitch = "suspend";
    };

    xserver = {
      enable = true;
      layout = "lv";

      autoRepeatDelay = 200;
      autoRepeatInterval = 25;
    };

    syncthing = {
      enable = true;
      user = "s";
      dataDir = "/home/s";
    };
  };

  programs = {
    bash.enableCompletion = true;
    zsh.enable = true;
    ssh.startAgent = true;

    ssh.knownHosts = literals.knownHosts;

    chromium = {
      enable = true;
      extensions = literals.chromiumExtensions;
    };

    gphoto2.enable = true;
  };

  hardware.brightnessctl.enable = true;

  sound.enable = true;

  fonts = {
    fontconfig.enable = true;
    fonts = with pkgs; [
      dejavu_fonts
      liberation_ttf
      material-icons
      source-code-pro
      source-sans-pro

      emojione
      noto-fonts
      noto-fonts-emoji
    ];
  };
}
