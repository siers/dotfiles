{ config, pkgs, ... }:

{
  sound.enable = true;

  hardware.bluetooth.enable = true;

  programs = {
    bash.enableCompletion = true;
    zsh.enable = true;

    ssh.startAgent = true;
    ssh.knownHosts = config.literals.knownHosts;

    gnupg.agent = {
      enable = true;
      enableBrowserSocket = true;
      pinentryFlavor = "gtk2";
    };

    gphoto2.enable = true;
  };

  services = {
    cron.enable    = true;
    dbus.enable    = true;
    ntp.enable     = true;
    openssh.enable = true;
    blueman.enable = true;

    logind = {
      lidSwitch = "suspend";
    };

    xserver = {
      enable = true;
      layout = "lv";

      autoRepeatDelay = 150;
      autoRepeatInterval = 25;

      displayManager.sessionCommands = ''
        ${pkgs.xorg.xset}/bin/xset r rate 175 25
      '';
    };

    syncthing = {
      enable = true;
      user = "s";
      dataDir = "/home/s";
      openDefaultPorts = true;
    };

    avahi = {
      enable = true;
      publish.enable = true;
      publish.addresses = true;
      nssmdns = true;
      reflector = true;
      allowPointToPoint = true;
      openFirewall = true; # from https://nixos.wiki/wiki/Printing
    };

    keybase.enable = true;
  };

  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
    support32Bit = true;
    daemon.config = {
      flat-volumes = "no";
    };
  };
}
