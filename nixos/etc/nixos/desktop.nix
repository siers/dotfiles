{ config, pkgs, ... }:

let
  literals = import ./lib/literals.nix pkgs;
in

{
  imports =
    [
      ./lib/audio.nix
    ];

  system.stateVersion = "18.03";
  system.autoUpgrade.enable = true;

  # grouped by singlelinedness
  security.sudo.extraConfig = "Defaults timestamp_timeout=30";
  security.sudo.configFile = literals.sudoConf;
  boot.blacklistedKernelModules = [ "pcspkr" ];
  time.timeZone = "Europe/Riga";

  nix = {
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
    extraGroups = [ "wheel" "networkmanager" "docker" "libvirtd" "cdrom" "audio" "camera" ];
  };

  networking = {
    firewall.allowedTCPPorts = [ 22 80 8080 65353 ];
    networkmanager.enable = true;
  };

  environment.etc."resolv.conf.head".text = ''nameserver 1.1.1.1'';

  nixpkgs.config = {
    allowUnfree = true;
    chromium = {
      #enablePepperFlash = true;
      enablePepperPDF = true;
      #enableWideVine = true;
    };
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

      synaptics.enable = true;
      synaptics.twoFingerScroll = true;
      synaptics.palmDetect = true;
      synaptics.tapButtons = true;
    };

    syncthing = {
      enable = true;
      user = "s";
      dataDir = "/home/s/.syncthing";
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
