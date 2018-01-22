# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./toshiba.nix
      ./packages.nix
    ];

  system.stateVersion = "17.09";

  # grouped by singlelinedness
  security.sudo.extraConfig = "Defaults timestamp_timeout=30";
  boot.blacklistedKernelModules = [ "pcspkr" ];
  time.timeZone = "Europe/Riga";

  users.mutableUsers = true;
  users.extraUsers.s = {
    isNormalUser = true;
    uid = 1000;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
  };

  networking = {
    firewall.allowedTCPPorts = [ 80 8000 8080 65353 ];
    networkmanager.enable = true;
  };

  services = {
    openssh.enable = true;
    cron.enable = true;

    xserver = {
      enable = true;
      layout = "lv";

      synaptics.enable = true;
      synaptics.twoFingerScroll = true;

      #displayManager.gdm.enable = true;
      #desktopManager.gnome3.enable = true;
      displayManager.lightdm.enable = true;
      windowManager.i3.enable = true;
    };

    syncthing = {
      enable = true;
      user = "s";
      dataDir = "/home/s/.syncthing";
    };
  };

  programs = {
    bash.enableCompletion = true;

    chromium = {
      enable = true;
      extensions = [
        "gcbommkclmclpchllfjekcdonpmejbdp" # https everywhere
        "dbepggeogbaibhgnhhndojpepiihcmeb" # vimium
        "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
        "jlgkpaicikihijadgifklkbpdajbkhjo" # mouse gestures
      ];
    };
  };

  fonts = {
    fontconfig.enable = true;
    fonts = with pkgs; [
      material-icons
      dejavu_fonts
      source-code-pro
      source-sans-pro
    ];
  };
}
