{ config, pkgs, ... }:

{
  sound.enable = true;

  hardware.bluetooth.enable = true;

  programs = {
    bash.enableCompletion = true;
    zsh.enable = true;

    ssh.startAgent = true;
    ssh.knownHosts = config.literals.knownHosts;

    chromium = {
      enable = true;
      extensions = config.literals.chromiumExtensions;
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

      autoRepeatDelay = 175;
      autoRepeatInterval = 25;

      displayManager.sessionCommands = ''
        ${pkgs.xorg.xset}/bin/xset r rate 175 25
      '';
    };

    syncthing = {
      enable = true;
      user = "s";
      dataDir = "/home/s";
    };

    avahi = {
      enable = true;
      publish.enable = true;
      publish.addresses = true;
      nssmdns = true;
      reflector = true;
      allowPointToPoint = true;
    };

    keybase.enable = true;
  };
}
