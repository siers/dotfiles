{ config, pkgs, lib, ... }:

let
  packages = (import ../lib/package-sets.nix { inherit pkgs; });
  ld-packages = with pkgs; [
    google-chrome
    mpv
    vlc
  ];
in
{
  imports = [
    ./ld-hardware.nix
    <nixos-hardware/lenovo/thinkpad/x220>

    ../lib/libinput.nix
    ../lib/openvpn.nix
    ../lib/printing.nix
    ../lib/backlight.nix
    /home/s/work/conf/evolution.nix
  ];

  networking.hostName = "ld-x220";

  system.stateVersion = "21.05";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.openssh.enable = true;
  services.openssh.permitRootLogin = "yes";
  services.timesyncd.enable = true;

  config.pulseaudio = true;

  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };
    displayManager.defaultSession = "xfce";
  };

  # users.mutableUsers = false;
  users.extraUsers.ld = {
    isNormalUser = true;
    uid = 1000;
    shell = pkgs.zsh;
    hashedPassword = config.literals.password;
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGHwoKCn9k47dD+AiLD757nRkHtjoZV0FZ6vQtujdc5J"];
    extraGroups = ["wheel" "networkmanager" "docker" "libvirtd" "cdrom" "audio" "camera" "video" "input"];
    initialHashedPassword = "123";
  };
  users.users.root.initialHashedPassword = "123";

  environment.systemPackages = packages.termtoolsEssential ++ packages.x ++ packages ++ ld-packages;
}
